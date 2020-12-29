---
title: "Entropy, Cross-Entropy, KL-Divergence"
mathjax: true
tags:	DeepLearning
key: "entropy_cross-entropy_KL-divergence"
---

# Entropy (at Information theory)

- The **expectation of bits** that used for notating (or classify each other) **probabilistic events** when using optimal bits coding scheme. ($$log_2(\frac{1}{p})$$ bits for notating events)
- Entropy also can be interpreted as the **average rate** at which **information is produced** ($$\text{I}(X) = log_2(\frac{1}{p})$$) by stochastic source of data. (rare events have more information than an often occurring event.)
- Entropy can be calculated by $$\text{H}(X) = \text{E}[\text{I}(X)] = \text{E}[-\text{log}_2 (\text{P}(X)] = \sum\limits_{p \in P} p \text{log}_2(\frac{1}{p}) = -\sum\limits_{p \in P} p \text{log}_2({p})$$ where $$P$$ is probability distribution. (Shannon's source coding theorem)

Let's think about the situation that you need to notate characters "**A**, **B**, **C**, **D**" in bits that stochastically written in a sentence. You can simply notate each character with 2 bits. For example, "00" for **A**, "01" for **B**, "10" for **C**, "11" for D. If every character have the same probability, ($$\text{P}(A) = \text{P}(B) = \text{P}(C) = \text{P}(D) = 1/4$$) this notating is optimal notating. You used **2 bits for each character on average.** (2 * 1/4 * 4)

But how about $$\text{P}(A) = 1/2, \text{P}(B) = 1/4, \text{P}(C) = \text{P}(D) = 1/8$$ ? If you use same scheme, you will use **2 bits** for each character on average. (2 * 1/2 + 2 * 1/4 + 2 * 1/8 * 2 = 2 * (1/2 + 1/4 + 1/8 + 1/8)) However, this is not optimal scheme for notating 4 character. As character **A** is frequently used than others, if you notate **A** with less bits, you can use less bits on average. So when notating "1" for **A**, "01" for **B**, "000" for **C**, "001" for **D**, **1.75 bits are used on average** (1 * 1/2 + 2 * 1/4 + 3 * 1/8 * 2 = 1.75). In that case, you can decode bits by following rules:

1. If looking bit is 1 or length of group of bits is 3, finish one character decoding.
2. If looking bit is 0, add looking bit (0) to group of bits and looking next bit.

# Cross-Entropy and KL-Divergence

The **cross-entropy** of the distribution $$q$$ relative to distribution $$p$$ over a given set is defined as follows:

$$\text{H}(p,q) = -\text{E}[l] = - \text{E}_p[\text{log}_2(q)] = - \sum_{x \in X} p(x) \text{log}_2(q(x)) = \text{H}(p) + D_{KL}(p \Vert q) \tag{1}$$

You can think **cross-entropy** as applying coding scheme which is optimal to probability distribution $$q$$ ($$l_i = - \text{log}_2(q(x_i)) \Leftrightarrow q(x_i) = (\frac{1}{2})^{l_i}$$) to probability distribution $$p$$ where $$l_i$$ is length of bits to coding i-th. 

**Kullback–Leibler divergence (KL-Divergence)** can be thought of as something like a measurement of how far the distribution $$q$$ is from the distribution $$p$$.

$$D_{KL}(p \Vert q) = \sum_{x \in X} p(x)\text{log}(\frac{p(x)}{q(x)}) = - \sum_{x \in X}p(x)\text{log}q(x) - (- \sum_{x \in X}p(x)\text{log}p(x))\\
= \text{H}(p,q) - \text{H}(p)$$

In deep learning, $$p$$ is dataset and $$q$$ is neural network output. Making cross-entropy loss smaller is making KL-Divergence of $$p$$ and $$q$$ ( $$D_{KL}(p \Vert q))$$ ) smaller because $$\text{H}(p)$$ is fixed value. 

# Reference

- [https://en.wikipedia.org/wiki/Entropy_(information_theory)](https://en.wikipedia.org/wiki/Entropy_(information_theory))
- [https://en.wikipedia.org/wiki/Cross_entropy](https://en.wikipedia.org/wiki/Cross_entropy)
- [https://en.wikipedia.org/wiki/Kullback–Leibler_divergence](https://en.wikipedia.org/wiki/Kullback%E2%80%93Leibler_divergence)