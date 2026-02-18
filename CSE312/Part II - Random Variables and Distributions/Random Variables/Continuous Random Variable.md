- All impossible events have probability 0, but the inverse isnt true
- Relative Chances
	- PDF: $p_f(k)$ Gives chance relative to $p_f(k')$ 
- Events
	- Integrate over PDF to get probability
- Convert from CDF to PMF
	-Take the derivate of CDF
- Convert PDF to CDF
	Integrate the PDF
$$
E[X] = \int_{-\infty}^{\infty}z\cdot f_x(z)dz
$$
$$
E[g(x)] = \int_{-\infty}^{\infty}g(z)\cdot f_x(z)dz
$$
$$
Var(X) = E[X^2] - E[X]^2 = \int_{-\infty}^{\infty}(z-E[X])^2\cdot f_x(z)dz
$$