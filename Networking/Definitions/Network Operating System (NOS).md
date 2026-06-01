## Network Operating System (NOS)
Software that provides a **Network Map** abstraction for [[Software Defined Networks|SDN]] control applications, similar to how a server OS provides file/process abstractions.

- Detects changes in the underlying network (switches, ports, links going up/down)
- Lets control apps implement routing logic on an abstract graph rather than dealing with distributed state collection directly
- Takes on the burden of collecting network state (replacing the distributed parts of link-state/distance-vector algorithms)
