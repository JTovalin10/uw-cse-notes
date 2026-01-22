# what is it
fork syscall
	- create an initialize a new proc
		- initializes kernel resources of new process with resources of parent
		- initializes EIP, ESP to be the same as parent
	- creates a new address space
		- initializes new address space with a copy of the entire contents of the address space of the parent
	- places new proc on the ready queue
- fork system call "returns twice"
	- once into the parent, and once into the child
		- returns the child's PID to the parent
		- returns 0 to the child
- fork() = "clone me"
	- **complete copy**
		- except PID
# Calling fork
1. creates a new address space
2. initialize page tables with same mapping as the parent's
	1. no copying address space content have occurred at this point - with sole exception of the top page of the stack
3. set both parent and child page tables to make all pages read-only
4. if either parent or child write to memory, an exception occurs
5. when [[Exception]] occurs, OS copies the page, adjusts page tables, etc
# Image
![[Pasted image 20260116005901.png]]