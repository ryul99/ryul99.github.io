---
layout: post
title:  "Github Pages deploy"
date:   2019-06-09 23:43:59
author: ryul99
categories: 삽질
tags:	github
---

Github Pages는 지원되는 jekyll plugin이 정해져 있습니다. ([여기](https://pages.github.com/versions/)에서 확인할 수 있습니다.) 때문에 깃헙에서 지원되지 않는 jekyll plugin을 사용하려면 jekyll 소스코드를 build하는 것이 아니라 빌드된 결과물을 서빙해야 합니다. 이번에는 이 방법을 몇 가지 정리해보려 합니다.

# subtree
git subtree는 기본적으로 하나의 깃 레포 안에 다른 깃 레포가 포함되어 있는 형태입니다. 다만, subtree의 경우 포함되어 있는 하위 레포는 포함하고 있는 상위 레포에 의해 버전관리가 이루어지고 이렇게 관리된 버전을 하위 폴더의 remote에 push 혹은 pull 하기만 할 뿐입니다. Workflow는 다음과 같습니다.
1. `git subtree add --prefix {local subdirectory} {remote repo} {remote branch}` 를 통해서 local subdirectory의 위치에 remote repo의 remote branch에서 clone받습니다.
2. `git subtree [pull/push] --prefix {local subdirectory} {remote repo} {remote branch}` 를 통해서 local subdirectory를 pull / push 할 수 있습니다.
Github Page에서 이를 활용하는 방법은 remote에 build된 결과물을 두는 브랜치를 따로 두고 이를 subtree로 사용하는 방법입니다. 저는 master를 deploy브랜치, source를 소스코드 브랜치로 두고 있습니다. 

# orphan branch
`git checkout --orphan {new branch}`를 하면 어떤 커밋도 없는 브랜치가 new branch라는 명칭으로 생깁니다. 이를 활용해서 새로 만든 브랜치에 build된 결과물을 두고 이 브랜치를 기준으로 deploy하면 됩니다. subtree와 비교해보면 이 방법은  소스코드와 결과물의 버전관리를 각각 하게 되고 빌드한 결과물을 빼내서 다른 곳에 둔 후 checkout한 후 다시 결과물을 넣어줘야한다는 특징이 있습니다.
