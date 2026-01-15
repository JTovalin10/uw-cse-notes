# DNS Lookup
[[Resolving DNS Names]]

# Creating a Socket
```c
int socket(int domain, int type, int protocol);
```
- doesn't bind it to a port or socket (yet)
- returns a file descriptor or -1 on error

# Connect to the server
- **Connect**() established a connection to a remote host
```c
int connect(int sockfd, const struct sockaddr* addr, socklen_t addrlen);
```
	- sockfd - socket file description from creating a socket
	- addr and addrlen - comes from getaddressinfo 
	- returns 0 on success or -1 on error
- Make take some time to connect
	- blocking call by default
# Read
- if there is already data on the network stack it will return this data even if it hasn't completed the read
	- Might return with less data than you asked for
- If there is not data, the function will block for you, until something arrives
	- can cause deadlocks
	- 
# write
- enqueues the data in a data buffer in the os and then returns
- OS transmits the data over the network in the background
	- when write returns the data, the receiver probably doesn't have the data yet
- If no more space is left then write will block

# close
- same as [[POSIX Close]]
- 
