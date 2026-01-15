- What is a subtype?
	- sometimes every B is an A
		- Every book is a library holding
		- every circle is a shape
	- Formally: ADT $S_1$ is a subtype than $S_2$
		- Satisfying $S_1$ implies also satisfying $S_2$
## NOTE
Subclass $\neq$ subtyping
Subclassing is a means of code sharing
- all fields of the superclass
- all methods of superclass copied into subclass
- ensures it has all methods of the parent class
Subtyping is about specifications
- each method spec must be stronger
- mostly in the comments

