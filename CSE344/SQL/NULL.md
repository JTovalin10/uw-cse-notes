- A NULL value means missing, unknown, undefined, or inapplicable
## Predicate
A predicate can evalute to
- false: 0
- Unknown: 0.5
- True: 1
## Three-Valued Logic
- A op B is defined as:
	- False or True when both A, B are not null
	- Unknown otherwise
	- This
		- A AND B = min(A, B)
		- A OR B = max(A, B)
		- NOT A = 1 - A
- SQL only returns tuples whose condition is true
- ![[three-value logic.png]]