Type Checking, Reasoning, Testing removes about 2/3 of bugs present. each are for different bugs.

***
# Reasoning
- thinking through what the code does on all inputs
	- ensuring what it does is correct in **all** cases
	- type checking and testing doesn't do this
		- type checking only verifies that the return type is correct
		- testing only checks some cases
	- Can be formally or informally
# Correctness
For every input satisfying the precondition, the output will satisfy the postcondition [[Pre and post conditions]]
- precondition
	- promised **facts** about the input
- postcondition
	- promised **facts** about the output
	[[Facts]]

## checking correctness of functional code
- steps
	- collect facts about each return statement
	- ensure those facts imply each fact of the postcondition
- checking correction requires proving implication
	- prove facts of return values
	- return values must satisfy the facts of the postcondition
- if the known fact doesn't imply the postcondition then the code is wrong

## checking correction with no mutation
- Proving implications is the core step of reasoning
	- other techniques output implications for us to prove
- Facts are written in our math notation
	- we will use math tools to prove implications
- Core technique is "proof by calculation"
- Other techniques we will need:
	- proof by cases
	- structural induction

