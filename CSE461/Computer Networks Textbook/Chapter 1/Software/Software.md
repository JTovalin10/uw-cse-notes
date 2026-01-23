# Socket API
Creating a socket
```c
// designed to be general enough to support any underlying protocl suite
// domain - protocl family that is going to be used
// type - semantic of communication
// protocl - the specific protocol that will be used
int socket(int domain, int type, int protocl);
```

establish a passive open
```c
// binds a newly created socket to a specified address
int bind(int socket, struct sockaddr* address, int addr_len);

// defines how many connections can be pedning on the specified socket
int listen(int socket, int backlog);

// carries out the passive open. it is a blocking oepration that does not return
// until a remote particpant has established a connection, and when it does
// it returns a new socket to this just-established conenction
int accept(int socket, struct sockaddr* address, int* addr_len);

//does not return until TCP has successfuly established a conenction
// then the application is frree to begin sending data
int conenct(int socket, struct sockaddr* address, int addr_len);
```
connection esablished
```c

int send(int socket, char* message, int msg_len, int flags);

int recv(int socket, char* buffer, int buf_len, int flags);
```