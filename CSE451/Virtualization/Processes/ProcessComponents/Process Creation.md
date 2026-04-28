# Creation
- new processes are created by existing processes
	- **Parent**: the creator
	- **Child**: created [[Process]]
		- UNIX: do **ps**, look for PPID fields
# Semantics
- (Depending on the OS) child processes inherit certain attributes of the parent
	- examples:
		- open file table: implies stdin, stdout, stderr
		- on some systems, resource allocation to parent may be divided among children
## When child is created
- (unix) when a child is created, the parent may either *wait for the child to finish*, **or** *continue in parallel*
## Policies
- (unix) these are **policies implemented by the kernel**. In window, inheritance is done explicitly in user mode by the CreateProcess library routine (it's not a system call)
# Background process
- NULL (maybe called NULL) process
	- process that runs at lowest priority
	- when nothing is ready to run
	- we have a process always ready to run but the process doesn't do anything
# UNIX process creation
[[Fork]]

# How do we create a new program
instead of forking the old program we
1. [[Fork]]
2. [[Exec]]
