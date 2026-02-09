request by program for kernel to do some operation on its behalf
	- only limited # of very carefully coded entry points
	- pushes everything to the stack, runs system call, OS wakes up and takes parameters off the stack, then executes instruction

# Dealing with System calls
- locate arguments
	- in registers or on user stack
	- translate user addresses into kernel addresses
- copy arguments
	- from user memory into kernel memory
	- protect kernel from malicious code evading checks
- validate arguments
	- protect kernel from errors in user code
- copy results back into user memory
	- Translate kernel addresses into user addresses
- The kernel double checks the user request in case another thread changes the data
# Examples
- open/create a file
- read/write from a file
- allocate memory
	- sometimes these are handled in user mode libraries