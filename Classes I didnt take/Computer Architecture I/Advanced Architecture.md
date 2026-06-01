# Course: Advanced Architecture

Advanced computer architecture focuses on exploiting **Instruction-Level Parallelism (ILP)** and **Data-Level Parallelism (DLP)** to push performance beyond the limits of simple pipelining.

## Exploiting Instruction-Level Parallelism (ILP)

### Superscalar Execution
**Superscalar** processors can issue and execute more than one instruction per clock cycle. This requires multiple execution units (ALUs, FPUs) and complex logic to detect dependencies in real-time.

### Out-of-Order (OoO) Execution
Instead of stalling when a hazard is encountered, an OoO processor skips the stalled instruction and finds subsequent independent instructions to execute.
- **Fetch/Decode**: In-order.
- **Dispatch/Rename**: Map architectural registers to physical registers.
- **Issue Queue (Reservation Stations)**: Instructions wait until their operands are ready.
- **Execute**: Out-of-order execution.
- **Commit/Retire**: Results are written back to architectural state **in-order** to maintain program correctness and handle exceptions.

### Register Renaming
**Register Renaming** is a technique used to eliminate "false" data dependencies (WAW and WAR hazards).
- **Architectural Registers**: What the ISA defines (e.g., X0-X31).
- **Physical Registers**: A larger pool of internal registers (e.g., 180+ in Intel Ice Lake).
- **Mechanism**: Each time an instruction writes to an architectural register, the hardware maps it to a new, unique physical register.

## Static Parallelism: VLIW
**Very Long Instruction Word (VLIW)** shifts the burden of finding parallelism from the hardware to the compiler.
- **Concept**: The compiler packs multiple independent operations into a single "bundle" or "super-instruction."
- **Trade-off**: Simple hardware (low power), but extremely complex compiler and poor binary compatibility across generations.

| Feature | Superscalar | VLIW |
| :--- | :--- | :--- |
| **Scheduling** | Dynamic (Hardware) | Static (Compiler) |
| **Hazard Detection** | Hardware Interlocks | Compiler-managed (No-ops) |
| **Complexity** | High Hardware | High Compiler |
| **Binary Compatibility** | Excellent | Poor |

## Data-Level Parallelism: SIMD
**Single Instruction, Multiple Data (SIMD)** allows one instruction to perform the same operation on multiple data elements (vectors) simultaneously.

- **Example**: Adding two 4-element vectors in one cycle.
  `ADDV V0.4S, V1.4S, V2.4S` (ARM NEON)
- **Use Case**: Video processing, graphics, scientific simulations, machine learning.

## Case Study: Intel Ice Lake (Sunny Cove)
- **Wide Issue**: Up to 10-way superscalar.
- **Huge Window**: ~352 entry Reorder Buffer (ROB) allows the CPU to "look ahead" for parallelism.
- **Unified Cache**: L3 cache is shared across all cores to minimize memory traffic.

## Related
- [[Pipelining and Hazards|Pipelining and Hazards]]
- [[Processor Performance|Processor Performance]]
