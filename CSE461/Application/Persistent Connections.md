- Parallel connections compete with each other for network resources
	- 1 parallel client = 8 sequential clients
	- exacerbates network bursts and loss
- persistent connection alternative
	- make 1 TCP connection to 1 server
	- use it for multiple HTTP requests
![[Screenshots/Persistent Connections.png]]