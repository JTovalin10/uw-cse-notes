hosts are wired to ethernet with [[Twisted Pair]]. The switch is what connects the hosts and wires run to a closet

has three layers
1. hub or repeater
2. switch
3. router
![[Screenshot 2026-02-06 at 12.38.10 PM.png]]

## Inside a hub
all ports are wired together which is more reliable than a single shared wire
![[Screenshot 2026-02-06 at 12.40.15 PM.png]]

## Inside a repeater
all inputs are connected and amplified before going out
![[Screenshot 2026-02-06 at 12.41.49 PM.png]]

## Inside a switch
uses the MAC (Media Access Control) address in ethernet to connect input port to the right output port; multiple frames may be switched in parallel

ports can be used for input and output, no MAC protocol needed
![[Screenshot 2026-02-06 at 12.41.20 PM.png]]
however needs buffer for multiple inputs to send to one output. It is important to note that sustained overload will fill buffer and lead to frame loss
![[Screenshot 2026-02-06 at 12.43.04 PM.png]]

## Advantages of switches
they have replaced the shared cable of classic ethernet
- its more convenient to run wires to one location
- more reliable as a wire cut is not a single point of failure that is hard to find
switches offer scalable performance
- 100 Mbps per port instead of 100 Mbps for all nodes of shared cable/hub