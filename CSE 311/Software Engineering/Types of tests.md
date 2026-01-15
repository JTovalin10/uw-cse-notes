- unit: checks one function
	- some functions might be too big
		- not being able to see what happens in the middle is an issue
		- **multiple loops often should be multiple functions**
		- 
- Integration: checks if things work correctly together
## rules for test
- only need to test inputs allowed by specs
- test each function individually
- test code should be simple
- if there are fewer than 10 allowed inputs, then test them all!
# statement coverage
- simplest metric is "statement coverage"
	- what percentage of the statement in the code are executed by at least one test
		- should be nearly 100%
		- besides throw as we are only testing allowed inputs
# Branch Coverage
- what percentage of conditionals are both branches covered by tests
- must test all branches on allowed inputs
	- can ignore branches that are unreachable
## Loop Coverage:
- loop coverage
	- what percentage of loops are executed 0, 1, and many (2+) times by some test case
- same idea is applied to recursion
- we might not see an error until 2 calls
# Summary:
- At least two tests for any function (non-UI)
- must have full coverage of all reachable
	- loops/recursion: must run 0,1 n number of times
	- branches: must execute all branches
	- statements: must be executed

[[Testing]]