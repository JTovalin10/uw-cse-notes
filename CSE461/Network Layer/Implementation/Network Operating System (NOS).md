The NOS layer in [[Software Defined Networks|SDN]] plays the same role a server OS plays for applications — it provides a high-level abstraction so control apps don't have to deal with low-level network details.

- Provides a **Network Map** abstraction — a global view of the network topology as a graph
- Detects changes in the underlying network (switches, ports, links going up/down) and keeps the map current
- Control apps implement behavior on the abstract graph (e.g., shortest-path routing) and then push forwarding rules down to the underlying switches
- The NOS takes on the burden of collecting distributed network state — the hard part of algorithms like link-state and distance-vector — so the app only needs to focus on the routing logic
- Goal: a **globally optimized** solution by centralizing control

See also: [[Software Defined Networks]], [[Routing]]
