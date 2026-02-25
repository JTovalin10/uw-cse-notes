```c
// returns 0 to the child process
// returns the childs pid to the parent process
pid_t fork(void);
```
- creates a new process that is an exact clone of the current process
	- Everything but threads are exact copy
- Primary used in
	- servers: to handle a connection
	- shells: fork a child then execute the program
- Fork causes the OS to clone the address space
	- the copies of memory segments are (nearly) identical