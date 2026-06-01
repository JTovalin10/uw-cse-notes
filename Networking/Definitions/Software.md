# CSE461: Socket API

The **Socket API** is the standard programming interface for building networked applications. It provides a set of system calls that abstract the underlying transport (TCP or UDP) into a simple read/write interface.

## Creating a Socket

Creating a socket:
```c
// domain - protocol family to use
// type - semantics of communication
// protocol - specific protocol to use
int socket(int domain, int type, int protocol);
```

Establishing a passive open:
```c
// binds a newly created socket to a specified address
int bind(int socket, struct sockaddr* address, int addr_len);

// defines how many connections can be pending on the specified socket
int listen(int socket, int backlog);

// carries out the passive open — blocks until a remote participant
// establishes a connection, then returns a new socket for that connection
int accept(int socket, struct sockaddr* address, int* addr_len);

// active open — blocks until TCP successfully establishes a connection,
// then the application is free to begin sending data
int connect(int socket, struct sockaddr* address, int addr_len);
```

## Connection Setup

Establishing a passive open (server):
```c
// binds a newly created socket to a specified address
int bind(int socket, struct sockaddr* address, int addr_len);

// defines how many connections can be pending on the specified socket
int listen(int socket, int backlog);

// carries out the passive open — blocks until a remote participant
// establishes a connection, then returns a new socket for that connection
int accept(int socket, struct sockaddr* address, int* addr_len);
```

Active open (client):
```c
// blocks until TCP successfully establishes a connection,
// then the application is free to begin sending data
int connect(int socket, struct sockaddr* address, int addr_len);
```

## Sending and Receiving

Once connected:
```c
int send(int socket, char* message, int msg_len, int flags);

int recv(int socket, char* buffer, int buf_len, int flags);
```

## Related
- [[Transmission Control Protocol (TCP)]] — the reliable transport underlying `SOCK_STREAM`
- [[User Datagram Protocol (UDP)]] — the unreliable transport underlying `SOCK_DGRAM`
- [[Applications]] — the programs built using the Socket API
