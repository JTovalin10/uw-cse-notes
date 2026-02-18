This reads writes to a file that we have given the write flag to. \

It is defined as 
```c
ssize_t write(int fd, const void* buffer, size_t count)
```
buffer - points to the data we want to write to the file
count - how many bytes we want to write from the buffer

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
	ssize_t bytes_written = 0;
	while (bytes_written < bytes_read) {
		ssize_t result = write(fd, buffer + bytes_written, bytes_read - bytes_written);
		if (result < 0) {
			perror(...);
			close(fd);
			return EXIT_FAILURE;
		}
		bytes_written += result;
	}
}

if (bytes_read < 0) {
	perror(...);
	close(fd);
	return EXIT_FAILURE;
}
```

[[POSIX read]]
[[POSIX Open]]