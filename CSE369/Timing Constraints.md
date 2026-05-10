# Course: Timing Constraints

In digital design, signals do not propagate instantaneously. Timing analysis ensures that data is stable when it needs to be sampled by a clock.

## Synchronous Digital Systems (SDS)
A system where all state changes are synchronized to a global **Clock**. A clock is a signal used to coordinate the actions of digital circuits, typically a square wave that oscillates between a high and a low state.

### Critical Parameters
- **$t_{setup}$ (Setup Time)**: Minimum time the data must be stable *before* the clock edge.
- **$t_{hold}$ (Hold Time)**: Minimum time the data must be stable *after* the clock edge.
- **$t_{C2Q}$ (Clock-to-Q Delay)**: Time it takes for the output of a flip-flop to change after the clock edge.
- **$t_{PD}$ (Propagation Delay)**: Time for a signal to pass through combinational logic.

## Timing Requirements

### Setup Time Constraint (Max Delay)
Ensures the clock period is long enough for the signal to propagate.
$$t_{C2Q} + t_{logic, max} + t_{setup} \le t_{period}$$
If this is violated, the system must run at a slower clock frequency.

### Hold Time Constraint (Min Delay)
Ensures the signal doesn't change too fast and "blow through" the next register.
$$t_{C2Q} + t_{logic, min} \ge t_{hold}$$
**Crucial Note**: Hold time violations *cannot* be fixed by slowing down the clock. They must be fixed by adding delay to the logic path.

## Metastability
**Metastability** is a phenomenon where a digital electronic system persists in an unstable equilibrium for an indeterminate period, often caused by violating setup or hold time constraints in a flip-flop.

### Formal Definition
A state where a digital signal is neither 0 nor 1, potentially causing downstream logic to interpret different values, leading to system failure.

### Simplified Explanation
It's like trying to balance a ball on a needle. Eventually it falls to one side, but you don't know when or which way.

## Related
- [[CSE369/Finite State Machines|Finite State Machines]]
- [[CSE369/Building Blocks|Building Blocks]]
