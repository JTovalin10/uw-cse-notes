- Severs can have multiple ip address
	- usually one external and visible ip address and one for local only (127.0.0.1)
# Figure out IP address(es) & port
**getaddressinfo**() 

# Create a socket
same as before

# Bind a socket
```c
int bind(int sockfd, const struct sockaddr* addr, socklen_t addrlen)
```
- nearly identical to connect
- returns 0 on success and -1 on error
# Listen for incoming clients
```c
int listen(int sockfd, int backlog);
```
- tells OS that the socket is a listening one
- backlog: max length of the listening queue
- returns 0 on success and -1 on error
- Sever cant use a connection until you accept it

# Accept a Client Connection
```c
int accept(int sockfd, struct sockaddr* addr, socklen_t* addrlen);
```
- returns a new sockfd (different from the sockfd given), which is ready to use, which is connected to a client (-1 on error)
- 