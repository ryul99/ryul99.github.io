---
title: "ssh-agent forwarding 트러블슈팅 팁들"
mathjax: true
tags:	git github linux debugging
key: "ssh-agent-forwarding-debugging-tip"
---

## 서론

깃헙에 푸시를 하는 등의 작업을 할 때 ssh key인증을 해야 한다. 하지만 서버에서 주로 작업하는 경우 이러한 인증에 어려움이 있을 수 있고 어쩔 수 없이 서버에 key를 두고 작업하는 경우도 있다. 하지만 key는 공용 서버라면 서버에 두지 않는 편이 좋고 ssh-agent forwarding이라는 것을 사용하면 로컬에 있는 ssh key를 서버에서도 사용할 수 있다. 깃헙에서 이를 설명한 자세한 글이 [이 링크](https://docs.github.com/en/developers/overview/using-ssh-agent-forwarding)에 있다. 이 글에서도 트러블 슈팅 방법에 대해서 설명하고 있지만 간략하게 정리해보려고 한다.

## 과정

1. 기본적으로 로컬과 서버 모두 ssh-agent가 켜져 있는 지 확인해야한다
   - `echo $SSH_AUTH_SOCK` 에서 출력이 되는 지 아닌 지로 확인할 수 있다.
2. 로컬에 `ssh-add -L`을 했을 때 공개키가 출력되어야 한다.
   - 만약 출력되지 않는다면 `ssh-add`를 입력하여 `~/.ssh`아래에 있는 키들을 자동으로 ssh-agent에 등록하거나 `ssh-add -K path/to/private_key`를 하여 다른 위치에 있는 private key를 ssh-agent와 키체인에 등록할 수 있다.
3. 마지막 과정으로 서버에서 `ssh-add -L`을 했을 때 마찬가지로 공개키가 출력되어야 한다.
   - 여기서 공개키가 출력되지 않는다면 어딘가에서 문제가 있었기 때문이므로 1,2번 과정을 체크해보거나 앞서 언급한 [깃헙 링크](https://docs.github.com/en/developers/overview/using-ssh-agent-forwarding)에서 트러블슈팅 파트를 읽어보길 바란다.

## ssh agent를 user-level systemd service로 만들기

글에서도 알 수 있듯이 ssh-agent가 항상 켜져있어야 문제 없이 ssh-agent-forwarding이 잘 작동한다. 때문에 systemd를 사용할 수 있는 환경이라면 user-level systemd service를 활용하여 재부팅/세션종료 후 재접속 하더라도 ssh-agent가 항상 켜져있을 수 있도록 도와주는 할 수 있다. 자세한 내용은 [stack exchange 링크](https://unix.stackexchange.com/a/390631)를 확인하면 된다.