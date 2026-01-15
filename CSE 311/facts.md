- things we know to be true about the variables
	- hold for all inputs (no matter what value the variable has)
- typically = or $\leq$
- dont repeat things that are done by type checker ($n : \mathbb{Z}$)
# collecting facts
- saw how to collect facts in code consisting of
	- **final** variable declaration
	- **if** statements
	- collect facts reading top to bottom
- elements cover all code without mutation
	- covers everything describable by our math notation
	– we can calculate interesting values with recursion