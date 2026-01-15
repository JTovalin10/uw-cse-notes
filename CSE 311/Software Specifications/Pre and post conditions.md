## pre
- preconditions on individual paraneters
	- often include in the @param
- with multipl parameters we use @ requires
	- @requires tells us the bound

## post
- only applies for allowed inputs
- only specified for allowed inputs
- Usually @throw and @return
## other
- method call either returns or throws error
	- @throw
	- @return
# Writing Method Specifications in Java
1. every input falls in one of the three:
	1. input is not allowed
	2. input is allowed and will return something
	3. input is allowed and will throw something
2. 