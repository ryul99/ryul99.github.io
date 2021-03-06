---
title:  "Run dev-server with Google Cloud Shell"
tags:	github GCP
key: "ghpage_devserver_with_Google-Cloud-Shell"
---
github page를 블로그로 사용하면서 불편했던 것 중 하나는 네이버, 티스토리 블로그등과는 다르게 웹 브라우저에서 블로그 글을 수정하거나 새롭게 적는 것이 안된다는 점이었습니다. 
또한 블로그에 수정이 필요할 때마다 로컬에 빌드 환경을 구축해야 했고 로컬의 환경이 달라짐에 따라 빌드가 안되는 경우도 종종 생겼습니다. 
그래서 제가 찾아보았던 방법은 클라우드 서비스에 블로그 소스코드와 빌드 환경을 구축하고 여기에 접속해서 블로그 글을 작성하고 수정하는 방식으로 로컬 환경의 제약없이 블로그를 빌드하는 것이었습니다.
그러던 중 제가 찾은 완벽한 대안은 Google Cloud Platform에서 제공하는 Google Cloud Shell입니다.
<br>
# Google Cloud Shell의 특징
Google Cloud Shell은 다양한 특징이 있는 데 제가 중점적으로 끌렸던 특징을 모아봤습니다.

- 웹 브라우저에서 인스턴스에 대한 명령줄 액세스
- 코드 편집기(베타) 기본 제공
- 5GB의 영구 디스크 저장소
- 사전 설치된 Google Cloud SDK 및 기타 도구
- 자바, Go, Python, Node.js, PHP, Ruby, .NET과 같은 언어 지원
- 웹 미리보기 기능

여기서 특히 좋은 것은 인스턴스에서 개발서버를 열었을 때 웹 미리보기가 가능한 점, 웹 브라우저에서 인스턴스에 대한 명령줄 액세스가 가능한 점, 웹 브라우저 상에서 코드 편집기를 제공하는 점이었습니다.
웹 브라우저에서 게시글의 수정, 빌드가 가능하고 deploy하기 전 잘 보이는 지 확인까지 별다른 설정없이 가능하기에, 네이버 / 티스토리 블로그 같이 웹 브라우저에서 모든 블로그 관리가 가능해졌습니다.<br>
다만 조심해야 할 점은 이 인스턴스는 일시적으로 사용이 가능하다는 점입니다. 홈디렉토리를 제외하면 인스턴스는 일정시간 후에 삭제됩니다.
<br>
# 시작하기
[https://ssh.cloud.google.com/cloudshell](https://ssh.cloud.google.com/cloudshell)에 접속하셔서 사용하실 수 있습니다.<br>
웹 미리보기의 경우 아래 사진의 연필 모양(편집기 모양) 오른쪽에 있는 아이콘입니다.<br>
<img src="/assets/images/Google-Cloud-Platform/startcloudshell2.png" title="GCP control bar">

<br>
[공식문서](https://cloud.google.com/shell/docs/)를 참고하시면 더 좋을 듯 합니다.