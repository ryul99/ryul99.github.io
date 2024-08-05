---
title: "What is Logit and Logistic?"
mathjax: true
tags:	DeepLearning
key: "what_is_logit_and_logistic"
---

# In Math

If $$p$$ is probability..

- **odds** is $$\frac{p}{1-p}$$.
- The **logit** (**log**istic un**it**) function or the **log-odds** is $$logit(p) = \log \frac{p}{1-p}$$ in statistics.
    - Logit function makes a map of probability values from $$(0, 1)$$ to $$(-\infty, +\infty)$$.
- The **logistic function** or the **sigmoid function** is the inverse-logit. ($$logistic(x) = logit^{-1}(x) = \frac{1}{1+e^{-x}}=\frac{e^{x}}{e^{x}+1}=p$$

# In Machine Learning

The **vector of raw (non-normalized) predictions** that a classification model generates, which is ordinarily then passed to a normalization function. Normalization function could be the **sigmoid function** in binary-class classification or **softmax function** in multi-class classification.

# Reference

- [https://stackoverflow.com/questions/41455101/what-is-the-meaning-of-the-word-logits-in-tensorflow](https://stackoverflow.com/questions/41455101/what-is-the-meaning-of-the-word-logits-in-tensorflow)
- [https://en.wikipedia.org/wiki/Logit](https://en.wikipedia.org/wiki/Logit)
- [https://en.wikipedia.org/wiki/Sigmoid_function](https://en.wikipedia.org/wiki/Sigmoid_function)
- [https://en.wikipedia.org/wiki/Logistic_regression](https://en.wikipedia.org/wiki/Logistic_regression)
- [https://developers.google.com/machine-learning/glossary/#logits](https://developers.google.com/machine-learning/glossary/#logits)
