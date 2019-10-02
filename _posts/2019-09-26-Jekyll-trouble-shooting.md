---
layout: post
title:  "Jekyll Trouble Shooting"
date:   2019-09-26 14:43:59 +0900
author: ryul99
categories: 삽질
tags:	Jekyll
---

깃헙 페이지를 위해 Jekyll을 사용하면서 겪었던 trouble shooting들을 정리해본다.

- 윈도우에서 한글 카테고리의 포스트가 포스트 목록에는 보이지만 링크를 눌렀을 때 포스트에 접속이 안되고 Not Found가 뜨는 경우
  - 윈도우용 루비를 설치해서 Jekyll을 사용하면 url에 한글이 들어갈 경우 한글이 깨지기 때문에 url에 한글이 들어가는 페이지는 들어갈 수 없다.인코딩 설정을 해서 해결할 수 있어 보이는데 나는 그냥 WSL을 사용했다.
- 포스트 링크를 통해서는 들어갈 수 있는데 페이지 목록에 뜨지 않는 경우 등의 플러그인 작동 오류
  - Jekyll 3.5부터 `_config.yml`에 있는 `gems`키워드가 `plugins`로 바뀌었다. Jekyll 4.0.0에서는 `gems`로 되어 있는 경우 인식을 못해 플러그인들이 동작하지 않았다. [지킬 릴리즈 참조](https://jekyllrb.com/news/releases/)
