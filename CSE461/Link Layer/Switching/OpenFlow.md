the controller has a birds eye view of all ports, it doesn't deal with data just tells data where to go
the controller just gives the switches the flow table that tells it where to send
1. two different classes of programmability
2. at controller
	1. can be heavy processing algorithm
	2. results in messages that update switch flow table
3. at switch
	1. local flow table
	2. built from basic set of network primitives
	3. allows for fast operation
![[Screenshot 2026-02-06 at 1.09.10 PM.png]]

## Timescales
![[Screenshot 2026-02-06 at 1.10.29 PM.png]]

## Key outputs
simplify network design and implementation
- sorta, kinda pushed the complexity around to the controller
however, this enables code reuse and libraries. Does standardize and simplify deployment of rules to switches, allow for fast operation.

Part of [[SDN - Control and Data Plane]]
