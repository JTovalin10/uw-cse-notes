# CSE461: Applications

**Applications** (also called **apps** or **user programs**) are programs that use the network to communicate. They run on [[Host|hosts]] (end systems) and interact with the network via the **[[Software|Socket API]]**.

Applications have varied network requirements — it is not one-size-fits-all:
- **Video streaming** — needs high sustained throughput
- **Interactive audio/video** (e.g., VoIP) — needs timely transfer from sender to receiver; late delivery is as bad as dropped
- **Non-streaming** (e.g., web pages) — can be delivered in pieces; low delay is not essential

Examples: Skype, video on demand, web browsers, email.

## Related
- [[Software]] — the Socket API for building networked applications
- [[Requirements]] — general network design requirements
- [[Host]] — the machines that run applications
- [[Application Requirements.md|Application Requirements]] — deeper dive into multimedia and streaming requirements
