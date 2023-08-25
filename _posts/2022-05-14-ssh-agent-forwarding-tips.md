---
title: "ssh-agent forwarding 팁들"
mathjax: true
tags:	git github linux debugging tmux
key: "ssh-agent-forwarding-tips"
---

# 트러블슈팅

깃헙에 푸시를 하는 등의 작업을 할 때 ssh key인증을 해야 합니다. 하지만 서버에서 주로 작업하는 경우 이러한 인증에 어려움이 있을 수 있고 어쩔 수 없이 서버에 key를 두고 작업하는 경우도 있습니다. 하지만 key는 공용 서버라면 서버에 두지 않는 편이 좋고 ssh-agent forwarding이라는 것을 사용하면 로컬에 있는 ssh key를 서버에서도 사용할 수 있습니다. 깃헙에서 이를 설명한 자세한 글이 [이 링크](https://docs.github.com/en/developers/overview/using-ssh-agent-forwarding)에 있습니다. 이 글에서도 트러블 슈팅 방법에 대해서 설명하고 있지만 간략하게 정리해보려고 합니다.

조심해야할 점은, 말 그대로 로컬의 ssh-agent를 forwarding하는 것이기에, forwarding 이후에 ssh-agent를 다시 실행하면 안됩니다. 다시 실행한다면 기존의 ssh-agent를 가르키고 있던 `$SSH_AUTH_SOCK`을 덮어 써버려서 의미가 없어집니다.

이러한 일은 특히 multiple hop ssh agent forwaridng에서 쉽게 일어날 수 있는데, shell rc 에 ssh-agent를 실행하게 한 경우 특히 자주 일어납니다.

이를 막기위해서는 `$SSH_AUTH_SOCK`이 Set되어 있는 지 확인하고, Set 되어 있지 않으면 ssh-agent를 실행하는 방식으로 해결할 수 있습니다.

## 과정

1. 기본적으로 로컬과 서버 모두 ssh-agent가 켜져 있는 지 확인해야 합니다
   - `echo $SSH_AUTH_SOCK` 에서 출력이 되는 지 아닌 지로 확인할 수 있습니다.
2. 로컬에 `ssh-add -L`을 했을 때 공개키가 출력되어야 합니다.
   - 만약 출력되지 않는다면 `ssh-add`를 입력하여 `~/.ssh`아래에 있는 키들을 자동으로 ssh-agent에 등록하거나 `ssh-add -K path/to/private_key`를 하여 다른 위치에 있는 private key를 ssh-agent와 키체인에 등록할 수 있습니다.
3. 마지막 과정으로 서버에서 `ssh-add -L`을 했을 때 마찬가지로 공개키가 출력되어야 합니다.
   - 여기서 공개키가 출력되지 않는다면 어딘가에서 문제가 있었기 때문이므로 1,2번 과정을 체크해보거나 앞서 언급한 [깃헙 링크](https://docs.github.com/en/developers/overview/using-ssh-agent-forwarding)에서 트러블슈팅 파트를 읽어 보시는 걸 추천합니다.

# ssh agent를 user-level systemd service로 만들기

트러블슈팅 글에서도 알 수 있듯이 ssh-agent가 항상 켜져있어야 문제 없이 ssh-agent-forwarding이 잘 작동합니다. 때문에 systemd를 사용할 수 있는 환경이라면 user-level systemd service를 활용하여 재부팅/세션종료 후 재접속 하더라도 ssh-agent가 항상 켜져있을 수 있도록 도와주게 할 수 있습니다. 

## 과정

1. `~/.config/systemd/user/ssh-agent.service`파일을 새로 만들면서 다음과 같이 설정합니다.

```sh
[Unit]
Description=SSH key agent

[Service]
Type=simple
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK

[Install]
WantedBy=default.target
```

2. `systemctl --user daemon-reload` 를 실행합니다.

3. `systemctl --user enable --now ssh-agent`를 실행합니다.

이렇게 하면 `${XDG_RUNTIME_DIR}/ssh-agent.socket`위치에 file의 형태로 `SSH_AUTH_SOCK`이 저장됩니다.

앞서 말한대로 SSH Agent Overwrite 이슈를 피하기 위해서는, shell rc (.bashrc / .zshrc 등...) 에 다음을 추가해주는 것이 좋습니다.

이 코드는 `SSH_AUTH_SOCK`이 설정되어 있지 않을 때 위에서 작업한 SSH Agent의 SOCK을 바라보도록 하는 코드입니다.

```sh
if ! test "$SSH_AUTH_SOCK" ; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
fi
```

## Reference

- https://unix.stackexchange.com/a/390631
- https://unix.stackexchange.com/questions/528360/ssh-agent-forwarding-troubleshooting#comment977659_528360

# tmux에서 ssh agent forwarding 사용하기

tmux에서 ssh agent forwarding이 잘 안되는 이유는, tmux가 ssh 세션보다 오래 살아있어서 `SSH_AUTH_SOCK` 변수를 이미 죽은 ssh 세션의 것으로 들고 있기 때문입니다. 이를 해결하기 위해서는 `SSH_AUTH_SOCK`이 가르키고 있는 temp 파일을 홈 디렉토리에 symlink하고, tmux에서는 그 파일을 보게 만들면 됩니다.

## 과정

- `~/.ssh/rc`에 다음 코드를 추가해줍니다.

```sh
# Fix SSH auth socket location so agent forwarding works with tmux
if test "$SSH_AUTH_SOCK" ; then
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
fi
```

- 그리고 위에서 shell rc에 추가한 코드를 수정하여 다음과 같이 바꿉니다.

```sh
if ! test "$SSH_AUTH_SOCK" ; then
    if test "~/.ssh/ssh_auth_sock" ; then
        export SSH_AUTH_SOCK='~/.ssh/ssh_auth_sock'
    else
        export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
    fi
fi
```

## Reference

- https://blog.testdouble.com/posts/2016-11-18-reconciling-tmux-and-ssh-agent-forwarding/
- https://blog.sanctum.geek.nz/reloading-tmux-config/
