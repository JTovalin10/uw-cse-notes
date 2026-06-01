# CSE461: Multiplexing

**Multiplexing** is the process of sharing a system resource among multiple users, similar to timesharing a computer. Three main approaches:

- **[[Synchronous Time-Division Multiplexing]]** — round-robin time slots; each flow gets a fixed slot whether or not it has data to send
- **[[Frequency Division Multiplexing (FDM)]]** — each flow transmits at a different frequency; all flows transmit simultaneously
- **[[Statistical Multiplexing]]** — on-demand sharing; flows only use the link when they have data, so idle flows waste no capacity

## Related
- [[Time Division Multiplexing (TDM)]] — TDM definition entry
- [[Frequency Division Multiplexing (FDM)]] — FDM definition entry
- [[Statistical Multiplexing]] — statistical multiplexing definition entry
- [[Link Layer - Multiplexing (TDM and FDM)]] — detailed comparison with formulas
