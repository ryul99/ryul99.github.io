---
title: "coc.clangd가 vim에서 기본적인 부분에서 에러를 내뱉는 경우"
mathjax: true
tags:	git github linux debugging
key: "ssh-agent-forwarding-debugging-tip"
---

## 사건의 시작

vim에서 c, c++ 를 사용하기 위해서 coc.clangd를 셋팅했었습니다. 그런데 이 coc.langd가 `#include <cstring>`같은 기본적인 부분에서 에러를 내뱉길래 트러블슈팅을 시작했습니다.

## 진행과정

- 처음에는 coc.clangd가 원래 c는 제대로 인식하는데 c++의 구문들을 이해하지 못한다고 생각해서 관련된 것들을 찾아봤습니다.
- 그런데 coc.clangd가 c만 지원하는게 아니라 c++도 기본적으로 지원한다는 내용을 발견했습니다.
- 이후 coc.clangd를 위한 패키지가 안 깔려있는 지, coc.clangd 재설치 등등 여러 과정을 거치다가 clangd가 c++를 이해하는 지 확인하기 위해서 이것저것 시도를 했습니다.
- 그 과정에서 clang이 깔려 있지 않다는 것을 확인했고 clang을 깔고 얘를 통해 빌드를 시도하니 빔에서 본 똑같은 에러가 발생했습니다.
- 이후 clang이 기본적인 헤더들을 못 찾는다는 [스택오버플로우 글](https://stackoverflow.com/questions/26333823/clang-doesnt-see-basic-headers)을 발견했고 현재 상황과 딱 맞는 것을 확인했습니다.
- 이 글에서 설명한대로 clang버전에 맞는 최신 g++-12를 설치하고 해결했습니다.

## 결론

1. clang 설치 (필요없을지도 모름)
2. clang -v 해서 사용하고 있는 gcc버전들 확인
3. 그중에서 젤 높은 버전에 맞게 g++-12를 설치
4. profit!

g++이 이미 설치되어 있었기 때문에 문제가 없을 것이다 하고 넘어갈 뻔 했지만 g++-12를 설치하는 것을 시도하여 잘 해결했습니다.

## Reference

https://stackoverflow.com/a/29821538