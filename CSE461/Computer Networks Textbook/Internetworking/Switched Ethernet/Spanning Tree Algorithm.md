## Problem
[[Learning Bridges]] work until the network contains a loop, in which case frames can potentially get forwarded forever.

![[Pasted image 20260214212957.png]]

In the figure, S1, S4, and S6 form a loop.

## Solution
If we think of the network as being represented by a graph that possibly has loops, then a spanning tree is a subgraph of this graph that covers all vertices but contains no cycles.

![[Pasted image 20260214213330.png]]

### Idea
A spanning tree is a subset of the actual network topology that has no loops and that reaches all the devices in the network.

### How It Works
The spanning tree determines which ports each switch will use to forward frames. The algorithm selects ports as follows:

1. Each switch has a unique ID.
2. Elect the switch with the smallest ID as the **root**.
	1. The root switch always forwards frames out over all of its ports.
3. Each switch computes the shortest path to the root and notes which of its ports is on this path.
	1. This port is selected as the **preferred port** to the root.
4. For each LAN segment, account for the possibility that another switch could be connected to the same port. Each switch elects a single **designated switch** that will be responsible for forwarding frames towards the root — the one closest to the root.
	1. If two or more switches are equally close to the root, then the smallest switch ID wins.

### Configuration Messages
For switches to decide if they are the root or a designated switch, they exchange configuration messages. These contain:

1. The ID of the switch sending the message.
2. The ID of what the sending switch believes to be the root.
3. The number of hops from the sending switch to the root.

Each switch records the current *best* configuration message it has seen on each of its ports, including both messages it received from other switches and messages it has transmitted itself.

#### How the Algorithm Converges
Each switch initially thinks it is the root, so it sends a message identifying itself as the root with a distance of 0. When a switch receives a message, it checks whether the new message is considered better than the currently recorded info:

1. The message contains a **smaller root ID**.
2. The root ID is equal but the **distance is shorter**.
3. The root ID and distance are equal but the **sending switch has a smaller ID**.

If the new message is better than the current info, the switch discards the old entry and saves the new one, adding 1 to the distance-to-root field since this switch is one hop further away from the root than the switch that sent the message.

The system stabilizes only when the root switch is still generating configuration messages and the rest of the switches are only forwarding messages over ports for which they are the designated switch — at this point the spanning tree is built.

If any designated switch fails, the algorithm is run again.

#### Not Root
If a switch receives a message that indicates it is not the root — a message from a switch with a smaller ID — it stops generating configuration messages and starts forwarding configuration messages from other switches.

#### Not Designated
Likewise, when a switch receives a configuration message that indicates it is not the designated switch for that port — that is, a message from a switch that is closer to the root or equally far from the root but with a smaller ID — the switch stops sending configuration messages over that port.
