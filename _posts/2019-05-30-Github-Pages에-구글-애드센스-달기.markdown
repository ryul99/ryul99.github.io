---
layout: post
title:  "Github Pages에 구글 애드센스 달기"
date:   2019-05-30 11:43:59
author: ryul99
categories: 삽질
tags:	github adsense
---

첫 게시글! 삽질정리를 위해 블로깅을 하기에 블로깅 하기 위해서 했던 삽질부터 올립니다.
저는 개인용으로 github pages를 처음 써서 이 블로그를 만들었습니다. 

# 문제의 시작...
처음에 제가 원했던 것은 마크다운 파일들만 정리해서 올리고 레포 세팅에서 테마 선택하는 것 정도로 간단하게 하는 것이었습니다.
문제는 구글 애드센스와 구글 애널리틱스 삽입..
결론부터 말하자면 **깃헙 세팅에서 테마 선택하는 거로는 애드센스와 애널리틱스 적용이 안되더군요**
하지만 생각보다 애드센스와 애널리틱스 적용하는 게 어렵지는 않습니다.

# 테마 가져오기
애드센스와 애널리틱스를 적용하려면 직접 테마를 자신의 github page 레포에 가져와서 적용을 해야합니다.
찾아보니 github page는 기본적으로 Jekyll이라는 것으로 돌아가고 있고 깃헙 세팅에서 테마를 선택하는 것도 이 Jekyll 테마를 자동으로 적용해주는 것입니다.
[github help](github help)를 참고해보면 깃헙에서 제공하는 Jekyll 테마는 [여기](https://github.com/pages-themes/)에서 확인할 수 있다는 것을 알 수 있습니다.
깃헙에서 제공되는 Jekyll 테마 외에도 Jekyll 테마는 다양한 테마가 있는데 이 들을 자신의 레포로 가져오면 됩니다.

## Jekyll 설명
이렇게 가져온 Jekyll 테마들을 사용하기 위해서 간단히 Jekyll에 대해서 알아봅시다. (저도 Jekyll에 대해서 확실히 아는 것은 아니고 삽질하면서 배운 정도가 다아니 너무 맹신하지는 말아주세요)
먼저 중요하게 보셔야 할 것이 `_config.yml`입니다. 사이트의 설정들을 담고 있는 듯 한데 뒤에서 설명할 `_includes`나 `_layouts`폴더 안의 html파일들을 보면 이 파일에서 변수를 가져와서 렌더링 하는 부분이 있을 수 있습니다. 때문에 가져오신 테마의 `_config.yml`를 잘 이해하시고 설정해주셔야 합니다.
`_includes`와 `_layouts`는 실제 html를 담고 있습니다. 보통 `_includes`에는 `_layouts`에서 사용할 코드들을 조각조각으로 가지고 있고 `_layouts`에 있는 파일들을 이용해서 페이지를 렌더링할 수 있습니다.
`_post`에는 말 그대로 블로그의 글들이 담기게 됩니다. 여기에 담기는 파일들의 양식은 `YYYY-MM-DD-title.md`이런 식으로 담기고 이 파일의 맨 위에 `---`로 감싼 부분에서 layout과 다른 설정들을 정할 수 있습니다.
예를 들어
{% raw %}
---
layout: post
title:  "Github Pages에 구글 애드센스 달기"
date:   2019-05-30 11:43:59
author: ryul99
categories: 삽질
tags:	github adsense
---
{% endraw %}
라고 하면 `_layouts`에 저장된 post.html이 적용되어 나오게 됩니다.

# 애드센스/애널리틱스의 코드 스니펫 추가하기
이제 마지막으로 애드센스/애널리틱스에서 준 코드 스니펫을 추가하면 됩니다!
실제 사용되는 `_layouts`의 파일이나 `_layouts`에서 사용되는 `_includes`의 파일에 추가하시면 됩니다.
제가 추가했던 커밋은 [여기서](https://github.com/ryul99/ryul99.github.io/commit/2c77701489c15aa6de77a1eaf3d07784359ee80b) 확인하실 수 있으니 함께 참고하시면 좋을 듯 합니다.


-[github help]: https://help.github.com/en/articles/adding-a-jekyll-theme-to-your-github-pages-site-with-the-jekyll-theme-chooser
