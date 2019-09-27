---
layout: post
title:  "Jekyll Trouble Shooting"
date:   2019-09-26 14:43:59 +0900
author: ryul99
categories: 삽질
tags:	Jekyll
---

깃헙 페이지를 위해 Jekyll을 사용하면서 겪었던 trouble shooting들을 정리해본다.

- 윈도우용 루비를 설치해서 Jekyll을 사용하면 url에 한글이 들어갈 경우 한글이 깨지기 때문에 url에 한글이 들어가는 페이지는 들어갈 수 없다.인코딩 설정을 해서 해결할 수 있어 보이는데 나는 그냥 WSL을 사용했다.
- Jekyll 3.5부터 `_config.yml`에 있는 `gems`키워드가 `plugins`로 바뀌었다. Jekyll 4.0.0에서는 `gems`로 되어 있는 경우 인식을 못해 플러그인들이 동작하지 않았다. [지킬 릴리즈 참조](https://jekyllrb.com/news/releases/)