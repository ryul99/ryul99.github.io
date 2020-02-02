---
title:  "Difference of locals, globals, vars in python3"
tags:	python
key: "python_locals-globals-vars"
---
reference: [https://stackoverflow.com/a/7969953](https://stackoverflow.com/a/7969953)<br>
부족한 영어실력으로 해석해서 정리한 글입니다. 오류가 있을 경우 지적해주세요.

# 파이썬 globals, locals, vars의 차이
- globals()
    - module의 namespace의 dic이를 return한다.
- locals()
    - 함수 안에서는 함수의 locals()를 호출한 순간의 namespace의 dict - 실제 namespace를 reflect하지 않음
    - 함수 밖에서는 현재의 namespace의 dict - 실제 namespace를 reflect함
    - 함수 안에서 locals()가 호출한 순간의 namespace를 들고오고 reflect 하지 않는다는 것은 CPython specific
- vars()
    - 인자로 object를 받는데 받은 object의 __dict__를 부르고 이게 없을 경우 그 object의 namespace를 return
    - 인자 없이 사용하는 vars()는 locals()랑 같다
    - vars()의 인자로 function을 줄 수 있는데 이 경우도 object로 봐서 function.__dict__를 부르거나 없다면 function의 object의 namespace를 부른다. function의 namespace와 다르게 function object의 namespace임
