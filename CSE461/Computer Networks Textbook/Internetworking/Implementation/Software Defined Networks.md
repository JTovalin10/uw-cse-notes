## Software Defined Networks (SDN)
**Core idea**: decouple the control plane from the data plane:
- **Control plane** — moved into software running on commodity servers
- **Data plane** — implemented by bare-metal switches

SDN defines a standard interface between the control and data plane so they can communicate regardless of implementation.

### Key Properties
- A **logically centralized** control plane manages a distributed network data plane
	- "logically centralized" because the state (e.g., a Network Map) can still be distributed across multiple servers (e.g., in the cloud) for scalability and availability
	- the two planes are configured and scaled independently
- The control plane manages both **physical** (hardware) switches connecting physical servers and **virtual** (software) switches connecting VMs and containers
	- virtual switch ports surpassed physical switch ports in the Internet in 2012

### [[Network Operating System (NOS)]]
- Like a server OS provides abstractions (e.g., files instead of raw disk access), a NOS provides a **Network Map** abstraction to make it easier to implement network control functionality (**Control Apps**)
- The NOS detects changes in the underlying network (switches, ports, links going up/down)
- Control apps implement behavior on the abstract graph — e.g., shortest path algorithm — then load forwarding rules into the underlying switches
- The NOS takes on the burden of collecting network state (the hard part of distributed algorithms like link-state and distance-vector), freeing the app to focus on the routing logic
- By centralizing this logic, the goal is a **globally optimized** solution

See also: [[Software Switch]], [[Hardware Switch]], [[CSE461/Computer Networks Textbook/Internetworking/Routing/Routing]]
