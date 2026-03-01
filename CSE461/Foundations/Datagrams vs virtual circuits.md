![[Screenshot 2026-02-09 at 12.47.28 PM.png]]

The quality of service is the reason why virtual circuits are still around:
1. Virtual circuit IDs can be used as a direct index instead of an indirect key to [[Forwarding Table]]
2. Virtual circuits can have lower per-packet overhead
3. Routing only needs to happen once per-flow instead of per-packet