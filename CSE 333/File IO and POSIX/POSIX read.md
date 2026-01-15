this reads from the file (if we gave it the read flag)
we use it inside of a while loop as it will tell us if we keep reading or if we stop reading
```c
#define BUF_SIZE 100
int main() {
...
int fd = open(fileName, R_RDONLY);
if (fd < 0) {
	perror(...);
	return EXIT_FAILURE;
}

ssize_t buffer[BUF_SIZE];
ssize_t bytes_read;
while((bytes_read = read(fd, buffer, BUF_SIZE)) > 0) {
	...
}

if (bytes_read < 0) {
	perror(...);
	close(fd);
	return EXIT_FAILURE;
}
...
```
# returns
- numbers of bytes read
- 0 if we are at the end of file
- -1 if there was an error reading the file

[[POSIX write]]
[[POSIX write]]
[[POSIX perror]]