# what is it
fork syscall
	- create and initialize a new proc
		- initializes kernel resources of new process with resources of parent
		- initializes EIP, ESP to be the same as parent
	- creates a new address space
		- initializes new address space with a copy of the entire contents of the address space of the parent
	- places new proc on the ready queue
- fork system call "returns twice"
	- once into the parent, and once into the child
		- returns the child's PID to the parent
		- returns 0 to the child
	- **The Register-Level Trick**: 
		- When `fork()` is called, the OS clones the entire process state, including all registers.
		- To allow the two processes to distinguish themselves, the OS manually modifies the **return value register** (e.g., `%rax` on x86-64 or `%eax` on x86-32) in the child's saved context.
		- In the **Parent**: The OS places the PID of the new child into the return register.
		- In the **Child**: The OS places **0** into the return register.
		- When both processes resume (pop their registers and return to user space), they see different values from the same function call.
- fork() = "clone me"
	- **complete copy**
		- except PID
# Calling fork
1. creates a new address space
2. initialize page tables with same mapping as the parent's
	1. no copying of address space contents has occurred at this point — with the sole exception of the top page of the stack
3. set both parent and child page tables to make all pages read-only
4. if either parent or child write to memory, an exception occurs
5. when [[Exception]] occurs, OS copies the page, adjusts page tables, etc
# Image
![[Pasted image 20260116005901.png]]