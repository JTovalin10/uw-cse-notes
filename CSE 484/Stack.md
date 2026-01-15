
![[Screenshot 2025-10-02 at 12.44.39 PM.png]]
![[Screenshot 2025-10-02 at 12.51.45 PM.png]]
# Important Pointers
- %ebp
	- pointer to the top of the stack
- %esp
	- points to the bottom of the stack
- %EIP
	- instruction pointer
# calling a function
1. arguments to the function is pushed into the stack
2. the pointer to the instruction after the call (RET) is pushed on the stack.
3. the jump/call instruction is executed.
