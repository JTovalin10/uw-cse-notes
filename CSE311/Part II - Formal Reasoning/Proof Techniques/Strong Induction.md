We use this when we have a recursive function and have multiple constant base cases

Example:
$$
 a(1) = 1 \quad a(2) = 3 \quad a(n) = 2a(n-1) - a(n-2), n \geq 3
$$
use strong induction to prove that a(n) = 2n-1 $\forall n \geq 1$
Template
Let P(n) = "a(n) = 2n-1" for every integer n, n $\geq 1$
Base Case(s)
	- n = 1, by definition of a(1) = 1 = 2(1) - 1
	- n = 2, by definition  of a(2)=3 = 2(2) -1
Induction Hypothesis: Assume P(j) for all integer j: $1 \leq j \leq k$ for some integer $k \geq 3$
Induction Step: 
$$
P(k+1) = 2a(k) - a(k-1) \quad \text{as k and k-1 fall within } 1 \leq j \leq k \text{ we can use our I.H}
$$
$$
2a(k) - a(k-1) \quad  \Rightarrow \quad 2(2k-1) - (2(k-1) - 1) 
$$
$$
2(2k-1)-2(k-1)-1 \quad \Rightarrow 4k-2-(2k-2-1) \quad \Rightarrow 2k+1
$$
$$
2k + 1 \Rightarrow 2k+2 -1 \Rightarrow 2(k+1)-1
$$
So P(k+1) holds
Conclusion
Therefore, P(n) holds for all integer $n \geq 1$ by strong induction
[[Induction]]