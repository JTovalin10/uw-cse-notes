Works like a print system but is used for error reporting when doing POSIX I/O:
```c
int fd = open(...);
if (fd < 0) {
	perror("Failed when opening input file");
	return EXIT_FAIULURE;
}
```
