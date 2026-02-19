How the cost of a link is measured affects which paths the routing algorithm prefers.

See also: [[Routing]]

## Delay

```
Delay = (depart_time - arrival_time) + transmission_time + latency
```

- `depart_time - arrival_time` — time the packet spent queued
- `transmission_time` — time to put bits on the wire
- `latency` — propagation delay across the link
