- simple idea
	- node just sends when it has traffic
	- if there was a collision (no ACK received) then wait a random time and resend

![[Screenshot 2026-01-22 at 3.34.26 PM.png]]

the gray area means there is a collision and it has to retransmit

With slotted aloha we can avoid overlapping collision by creating slots which increases effiencey by 36%
# Throughput
Let $G$ = offered load (avg frames transmitted per slot), $S$ = throughput

**Pure ALOHA:**
$$S = Ge^{-2G}$$
- Max throughput: $S \approx 0.184$ (18.4%) at $G = 0.5$

**Slotted ALOHA:**
$$S = Ge^{-G}$$
- Max throughput: $S \approx 0.368$ (36.8%) at $G = 1$

# Limitations
simple, decentralized protocol that works well under low loads
- not efficient under high loads