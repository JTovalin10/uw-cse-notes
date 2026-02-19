# Spanning Tree Algorithm

Used by [[Network Switch (Switching)|switches]] to eliminate forwarding loops. Switches collectively find a spanning tree — a subset of links that reaches all switches with no cycles — and only forward frames along those links.

## Goal

- Elect a **root** switch (lowest ID wins)
- Each switch finds its **shortest path to the root** (ties broken by lowest switch ID)
- Turn off ports that are not on the spanning tree to prevent loops

## Rules

1. All switches run the same algorithm
2. They start with no prior information
3. Operate in parallel, sending messages to neighbors
4. Always converge to the best solution
5. Robust: adapts to topology changes and failures without manual configuration

## Configuration Messages

Each switch periodically sends messages to its neighbors containing:

| Field | Description |
|---|---|
| Sender ID | Address of the switch sending the message |
| Root ID | Who the sender currently believes is the root |
| Distance | Hops from the sender to the root |

## Convergence

Each switch initially believes it is the root and sends a configuration message claiming root with distance 0.

When a switch receives a message, it prefers the new message if:
1. It contains a **smaller root ID**, or
2. Root IDs are equal but the **distance is shorter**, or
3. Root ID and distance are equal but the **sending switch has a smaller ID**

If the new message is better, the switch:
- Discards the old entry
- Saves the new one with distance incremented by 1
- Stops generating its own root claims and starts forwarding

## Port Roles

| Role | Description |
|---|---|
| **Root port** | The port on each non-root switch with the shortest path to the root |
| **Designated port** | For each LAN segment, the port of the switch closest to the root (forwards toward root) |
| **Blocked port** | All other ports — disabled for forwarding to prevent loops |

## Termination

The algorithm stabilizes when:
- The root switch is the only one generating configuration messages
- All other switches only forward configuration messages on ports where they are the **designated switch**

If a designated switch fails, the algorithm reruns automatically.

## Limitations

- Does not use optimal paths (all traffic routes through the root)
- The root becomes a bottleneck
- Does not scale well — only suitable for small networks

See [[Spanning Tree Solution]] for a worked example and full textbook notes.
