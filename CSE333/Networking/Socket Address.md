# Linux Socket Address
Structure, constants, and helper functions in
```c
#include <arpa/inet.h>
```
- Addresses stored in network byte order (big endian) [[big endian]]
## Converting between host and network byte orders:
```c
uint32_t htonl(uint32_t hostlong); // h means host
uint32_t ntohl(uint32_t netlong); // n means network
```
