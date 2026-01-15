a variable is normal with mean $\mu$ and variance $\sigma^2$ 
$$
X ~ N(\mu, \sigma^2)
$$
has the density:
$$
	f_x(x) = \frac{1}{\sigma \sqrt{2\pi}}\cdot e^{-\frac{(x-\mu)^2}{2\sigma^2}}
$$
In order to Standarize 
$$
X ~ N(\mu, \sigma^2) \rightarrow Y ~ N(0,1)
$$
we must use this:
$$
Y = \frac{X - \mu}{\sigma}
$$
$$
E[X] = \mu
$$
$$
Var(X) = \sigma^2
$$

Attributes
Doesnt have a closed form so we cannot calculate CDF (Use z-table)
It can be shifted left or right by changing $\mu$
