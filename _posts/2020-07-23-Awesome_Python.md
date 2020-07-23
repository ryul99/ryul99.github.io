---
title: "Awesome Python"
mathjax: true
tags:	Python
key: "awesome_python"
---

# 1. "and" and "or" returns the object

```python
>>> [] and {}
[] # what???
```

Python's "and" operation and "or" operation **doesn't returns "True" or "False".**

```python
A or B # is equal to
A if A is True else B
# and also
A and B # is equal to
A if A is False else B
```

> Note that neither and nor or restrict the value and type they return to `False` and `True`, but rather **return the last evaluated argument**.

ref: [https://docs.python.org/3/reference/expressions.html#boolean-operations](https://docs.python.org/3/reference/expressions.html#boolean-operations)

# 2. Chaining comparison operators

```python
>>> def f(x):
...     print(x)
...     return x
...
>>> 1 > f(2) > f(3)
2
False
>>> 1 < f(2) < f(3)
2
3
True
>>> 1 > f(2) and f(2) > f(3)
2
False
>>> 1 < f(2) and f(2) < f(3)
2
2
3
True
>>> a = 2
>>> a > 1 == a > 1
False
>>> a < 3 == True
False
>>> 1 < 3 is True
False
```

> Comparisons can be chained arbitrarily, e.g., `x < y <= z` is equivalent to `x < y and y <= z`, except that y is evaluated only once (but in both cases z is not evaluated at all when `x < y` is found to be false).
Formally, if a, b, c, …, y, z are expressions and op1, op2, …, opN are comparison operators, then `a op1 b op2 c ... y opN z` is equivalent to `a op1 b and b op2 c and ... y opN z`, except that each expression is evaluated at most once.

ref: [https://docs.python.org/3/reference/expressions.html#comparisons](https://docs.python.org/3/reference/expressions.html#comparisons)