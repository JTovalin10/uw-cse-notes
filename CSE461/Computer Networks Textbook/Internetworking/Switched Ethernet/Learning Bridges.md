**Goal:** The bridge should observe that it does not always need to forward all frames that it receives.

![[Pasted image 20260214211836.png]]

## How Can We Achieve This

### Approach 1: Static Table
Allow hosts to directly receive the frame on the LAN by having a human download a table into the bridge.
- This is very difficult to maintain.
- ![[Pasted image 20260214212349.png]]

### Approach 2: Dynamic Learning
The bridge inspects the source address on all the frames it receives.
- When host A sends a frame to a host on either side of the bridge, the bridge receives this frame and records the fact that a frame from host A was just received on port 1.
- Entries are added over time, and timeouts associated with every entry cause them to be discarded after a specified period of time — this protects against the situation in which a host is moved from one network to another.

See [[Learning Bridges Implementation]] for the code that implements this forwarding table.

## Issue
Learning bridges cannot handle loops. If the network contains a cycle, frames can potentially get forwarded forever. This is solved by the [[Spanning Tree Algorithm]].
