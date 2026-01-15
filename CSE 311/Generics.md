- Declarations can have any number of arguments
	- only short names
		- E for element
		- K for key
		- V for value
## type constraints
- type declarations constain the value passed in
 ![[Screenshot 2025-11-28 at 12.27.59 AM.png]]
- bounds on the type
## Type Bounds
- upper bound
	- T must be this type or a subtype of it
- multiple upper bounds
	- must use & 
	- A extends B & C & D
		- A must satisfy all of these
![[Screenshot 2025-11-28 at 12.28.45 AM.png]]
## Type Arguments
- code can only use methods from the type bound
- can only call methods guaranteed to be there
- Whatever type passed must satisfy the contraint being passed 
	- if extends Comparable we must implement it
![[Screenshot 2025-11-28 at 12.29.51 AM.png]]