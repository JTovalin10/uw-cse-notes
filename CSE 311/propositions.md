- precondition & postcondition are propositions
	- T/F claims about values in the progra,
- we say that $P_1$ is stronger than $P_2$ 
	- whenever p1 is true, p2 is also true
	- values that satisfy p1 are a subset for p2
- p1 implies p2
- we say p2 is weaker than p1
- A stronger postcondition:
	- smaller subset of allowed outputs for a given inout
	- return is between 1 and 100 is stronger than is positive
- a weaker precondition:
	- larger subset of allowed inputs
		- allowing all ints value instead of positive ones
- A most specific return means the spec if stronger
	- more details is better
# weaker or stronger pre/post condition

# what makes a spec stronger
- S1 is stronger than S2 if:
- a stronger postcondition 
	- smaller subset of allowed values
- a weaker precondition
	- larger subset of allowed values
- (or both)