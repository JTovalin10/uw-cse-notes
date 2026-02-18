# Open
This function opens a file with the mode given. 
## Errors
If there was an error reading the file then open will return -1 and it will sset errno to **EBADF**. so we can check it using
```c
int fd = open(...);
if (fd < 0) {
	perror("...");
	return EXIT_FAILURE
}
```
**Note**: Do not close a file that was not opened as this will overwrite the original errno and it has no purpose
```c
int fd = open(...);
if (fd < 0) {
	perror("...");
	return EXIT_FAILURE
}
int fd2 = open(...);
if (fd2 < 0) {
	perror(...);
	close(fd); // we can close it here since we know fd was opened
	return EXIT_FAILURE
}
```

[[POSIX Mode]]
[[POSIX perror]]