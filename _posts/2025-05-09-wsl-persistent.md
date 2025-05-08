---
title: "WSL2를 항상 켜져있는 서버로 사용하기"
mathjax: true
tags:	linux windows wsl
key: "wsl-persistent"
---

## 배경 설명

WSL2는 윈도우에서 Linux를 쉽게 사용할 수 있는 방법중에 하나입니다. 그런데 WSL2를 서버처럼 사용하기에는 터미널 등에서 켜두지 않으면 자동으로 꺼지는 것이 걸림돌로 작용합니다. 이번 글에서는 이를 해결할 수 있는 방법을 소개합니다.

## 1. 부팅 시 자동으로 켜기

ref: [StackExchange](https://askubuntu.com/a/1178910)

1. 윈도우키 + R 를 눌러 `shell:startup`을 입력하여 시작 프로그램 폴더를 엽니다.
    * 혹은 `C:\Users\<사용자이름>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup` 경로로 이동합니다.

2. `wsl.vbe`라는 이름의 배치 파일을 만들고 다음 내용을 추가합니다.

```
Set ws = CreateObject("WScript.Shell")
ws.run "wsl -d <배포판 이름> --cd ~", 0, False
```

## 2. 계속 켜두기

먼저 WSL2에서 systemd 기능을 켜야 합니다. [마소 공식 문서 참고](https://learn.microsoft.com/ko-kr/windows/wsl/systemd#how-to-enable-systemd)

1. vim, nano등을 사용하여 `/etc/wsl.conf`를 수정하여 다음 줄을 추가합니다.

   ```
   [boot]
   systemd=true
   ```

2. PowerShell에서 `wsl.exe --shutdown`을 하여 wsl을 끈 후 다시 wsl에 접속합니다.

실제 작업을 위해 systemd 서비스를 만들어줍니다.
원리는 wsl의 백그라운드에서 아무 일도 하지 않는 프로세스를 돌리는 것입니다. [firejox 유저의 깃헙 코멘트 참고](https://github.com/microsoft/WSL/issues/8854#issuecomment-1490454734)

1. `/etc/systemd/system/wsl-alive.service`이라는 파일을 만들어 다음 내용을 추가합니다.
  * 2025/05/09 수정: waitfor.exe가 사용하는 protocol이 24H2에서 deprecated 되어서 방법을 수정하였습니다. [관련 링크](https://learn.microsoft.com/en-us/windows/whats-new/whats-new-windows-11-version-24h2#remote-mailslot-protocol-disabled-by-default)

   ```
   [Unit]
   Description=Keep Distro Alive

   [Service]
   ExecStart=/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -WindowStyle Hidden -NonInteractive -NoProfile -Command "while ($true) { Start-Sleep -Seconds 3600 }"

   [Install]
   WantedBy=multi-user.target
   ```

2. `sudo systemctl daemon-reload`를 하여 서비스를 로드한 후 `sudo systemctl enable --now wsl-alive.service`를 하여 서비스를 켜줍니다.

3. `sudo systemctl status wsl-alive.service`를 하여 제대로 켜져 있는 지 확인합니다.

