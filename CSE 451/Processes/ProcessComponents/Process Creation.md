- new processes are created by existing processes
	- **Parent**: the creator
	- **Child**: created process
- (Depending on the OS) child processes inherit certain attributes of the parent
	- open file table: implies stdin, stdout, stderr
	- on some systems, resource allocation to parent may be divided among children
- (unix) when a child is created, the parent may either wait for the child to finish, or continue in parallel
- (unix) these are **policies impemented by the kernel**. In window, inheritance is done explicitly in user mode by the CreateProcess library routine (it's not a system call)

# UNIX process creation
[[Fork]]

# How do we create a new program
instead of forking the old program we
1. [[Fork]]
2. [[Exec]]
