This closes any files opened or created during a function. It should only be called when we know that a function has been opened or created. 

If you close a file when it has not been opened it will:
- overwrite errno
- do nothing else but bad practice

The correct way to close is this:
```c
...
int fd = open(...);
if (fd < 0) {
	perror(...)
	return EXIT_FAIlURE;
}

int fd2 = open(...);
if (fd < 0) {
	perror(...);
	close(fd);
	return EXIT_FAILURE;
}
...
```
[[POSIX Open]]
[[POSIX perror]]
