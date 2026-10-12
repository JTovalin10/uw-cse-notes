# Warehouse-Scale Computer Architecture: Failure Modes

## Edge Cases, Failure Modes & Mitigations

### 1. High Component Fault Rates
- **Failure Dynamics**: In a cluster of 50,000 servers with an Annualized Failure Rate (AFR) of $4\%$, the cluster experiences over 5 server failures per day, alongside frequent disk crashes, memory ECC errors, and network link drops.
- **Mitigation**: Systems must eliminate single points of failure. Applications store replicated state across independent fault domains (different racks/power buses) and rely on automated cluster schedulers to restart failed tasks on healthy nodes.

### 2. Network Bisection Bandwidth Bottlenecks
- **Failure Dynamics**: Uncontrolled cross-rack traffic can saturate oversubscribed cluster switch uplinks, leading to buffer drops, TCP retransmission timeouts, and microsecond-to-millisecond latency spikes.
- **Mitigation**: Application software groups communicating tasks within the same rack or network switch domain. Schedulers implement topology-aware task placement.

### 3. Thermal Throttling & Power Envelopes
- **Failure Dynamics**: Modern high-density CPUs operate near their maximum thermal design power (TDP). A localized cooling fan failure or airflow obstruction triggers hardware thermal throttling, causing severe straggler latency.
- **Mitigation**: Environmental monitoring systems continuously track inlet/outlet temperatures. Load balancers redirect request traffic away from thermally degraded racks.

## Related

- [[Datacenter Systems/Warehouse-Scale Computer Architecture|Warehouse-Scale Computer Architecture]] — Hub for this topic
- [[Datacenter Systems/Warehouse-Scale Computer Architecture/Scatter-Gather Query Trace|Scatter-Gather Query Trace]] — Processing a query across a WSC
- [[Datacenter Systems/Warehouse-Scale Computer Architecture/Power, PUE, and AFR Formulas|Power, PUE, and AFR Formulas]] — Power dynamics, PUE, and failure rates
