# What is it
a specific CPU register that stores the memory address of the top of the stack

Acts like a bookmark that tells the CPU "This is where the valid data ends and the free space begins"

# How it moves
on most architectures the stack grows **Downward**
- when you call a function
	- the SP moves down to make room for local variables and return address
	- when you return from a function
		- the SP moves up effectively discarding the local variables and freeing that space
# Why is it critical
without the stack pointer, the program would lose track of where its local variables are and would not know where to return after a function finishes