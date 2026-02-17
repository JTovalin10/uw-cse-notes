A flow control strategy where each pair of adjacent nodes along a path independently manages buffer usage. Each hop runs its own sliding window protocol to prevent the upstream node from overrunning the downstream node's buffers.

Used in [[Virtual Circuit (VC)]] networks like X.25 to guarantee buffer availability at every switch.
