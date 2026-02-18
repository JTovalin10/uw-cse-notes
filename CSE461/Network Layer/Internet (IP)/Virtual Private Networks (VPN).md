## Virtual Private Networks (VPN)
### Private Network
- Corporations with many sites build private networks by leasing circuits from phone companies
- Communication is restricted to only the sites of that corporation (desirable for security)

### Making it Virtual
- Replace leased transmission lines (not shared) with some sort of shared network
- A **virtual circuit (VC)** is a reasonable replacement for a leased line:
	- still provides a logical point-to-point connection between sites
- Example:
	- Corporation X has a VC from site A to site B and can send packets between them
	- Corporation Y cannot deliver packets to site B without establishing its own VC
	- VC establishment can be administratively prevented, blocking unwanted connectivity

![[Pasted image 20260215025516.png]]

See also: [[IP Tunneling]]
