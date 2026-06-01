# Course: Dynamic Scheduling and OoO

Out-of-Order (OoO) execution allows a processor to execute instructions as soon as their operands are available, rather than in the order they appear in the program. This masks stalls from long-latency operations (like cache misses).

## Concepts and Mechanisms

### Register Renaming
Eliminates "false" dependencies (WAR/WAW) by mapping architectural registers to a larger pool of physical registers.
- **Map Table**: Tracks current logical -> physical mappings.
- **Free List**: Tracks available physical registers.
- **Commit**: When an instruction retires, its *old* physical destination is returned to the free list.

### Scoreboarding
A centralized hardware structure that tracks the status of instructions and functional units. It prevents RAW, WAR, and WAW hazards but stalls on structural hazards.

### Tomasulo's Algorithm
A decentralized approach using **Reservation Stations (RS)**.
- **Key Innovation**: Results are broadcast on a **Common Data Bus (CDB)**.
- Instructions wait in RS until operands are broadcast. This effectively performs register renaming.

### Reorder Buffer (ROB)
Allows the processor to execute out-of-order but **Commit In-Order**.
- **Precise Exceptions**: If an exception occurs, the ROB allows the processor to flush all instructions younger than the faulting one, restoring the state to exactly what it would be in a sequential machine.
- **Commit/Retire**: The final stage where results are made permanent.

## Memory Disambiguation
Loads and stores are harder to reorder than ALU ops because their addresses are not known until execution.

### Load and Store Queues (LQ/SQ)
- **Store Queue**: Holds pending writes. Loads must search the SQ to see if a younger store is writing to the same address (**Store-to-Load Forwarding**).
- **Load Queue**: Tracks executed loads. When a store executes, it searches the LQ to see if a younger load "stole" the data too early.

### Scheduling Strategies
1. **Conservative**: A load waits until all older store addresses are known.
2. **Aggressive**: A load executes as soon as its own address is known, assuming no alias. If a violation is detected later, the pipeline is flushed.
3. **Predictive**: Uses a predictor to decide which loads should wait for specific stores.

## Comparison: VLIW vs. Superscalar
- **Superscalar**: Dynamic scheduling (hardware). Complex, power-hungry, but binary compatible.
- **VLIW**: Static scheduling (compiler). Simple hardware, but fragile binaries and complex compilers.

## Related
- [[Pipelining and Hazards|CSE469: Pipelining and Hazards]]
- [[Memory Hierarchy and Coherence|Memory Hierarchy and Coherence]]
