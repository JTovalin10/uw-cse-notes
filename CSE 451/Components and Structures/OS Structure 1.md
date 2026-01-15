# Monolithic
- tranditionally, OS were built as a monolithic entity
![[Pasted image 20260114213634.png]]
## Advantages
- cost of module interaction is low
## Disadvantages
- hard to understand
- hard to modify
- unreliable
- hard to maintain
# Layering
![[Pasted image 20260114213758.png]]
## problems with layering
- imposes hierarchical structure
	- but real sytems are more complex
		- file system requires VM srevices (buffers)
		- VM would like to use files for its backing sotre
	- struct layering isnt flexible enough
- poor performance
	- each layer crossing has overhead associated with it
- disjunction between model and reality
	- system modeled as layers, but not really built that way