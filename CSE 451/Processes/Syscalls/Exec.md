```c
int exec(char* prog, char* argv[]) { ... }
```
1. stops the current [[Process]]
2. loads program 'proc' into the address space
	1. overwrites the existing process image
3. initializes hardware context, args for new program
4. places proc onto ready queue
**does not create a new process**
