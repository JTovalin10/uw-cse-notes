in IPv4 we began to ran out of IP addresses. A solution was to make multiple devices in one area (house or building) loo like one device

- maps an internal Ip to an external IP
	- many internal IP connected using few external IP
	- [[Middlebox]] translate the address

maps multiple private addresses to one public address

## How it works
![[Screenshot 2026-02-18 at 12.34.43 PM.png]]![[Screenshot 2026-02-18 at 12.35.13 PM.png]]![[Screenshot 2026-02-18 at 12.35.21 PM.png]]

## Pros and Cons
despite NAT boxes becoming redundant due to IPv6, people still want to use it as it provides security
Pros:
- relives IP address pressure
	- m:n connections, m internal hosts to n external addresses
- easy to deploy
- useful functionality
	- firewall which helps with privacy
- 
Cons:
1. Connectivity has been broken
	1. can only send incoming packets after an outgoing connection is set up
	2. difficult to ryn servers or peer-to-peer apps
2. doesn't work when there are no connections (UDP)
3. breaks apps that expose their IP addresses (FTP)