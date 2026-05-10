# Course: Instruction Set Architecture

In CSE470, the **Instruction Set Architecture (ISA)** is viewed through the lens of micro-architectural implementation, particularly the challenges of building high-bandwidth front ends.

## ISA Design for Parallelism

### The Front-End Bottleneck
A 4-way superscalar processor must fetch and decode 4 instructions every cycle.
- **Fixed Length (RISC)**: Makes decoding easy because instruction boundaries are predictable.
- **Variable Length (CISC/x86)**: Extremely difficult. Requires complex pre-decoding to find where instructions start.

### Control Flow and Branching
Branches are the enemy of wide-issue.
- **Branch Penalty**: In a 15-stage pipeline, a misprediction can waste dozens of cycles.
- **Branch Prediction**:
    - **BTB (Branch Target Buffer)**: Stores the target address of branches.
    - **RAS (Return Address Stack)**: Special predictor for function returns.
    - **Direction Predictors**: TAGE predictors are the current state-of-the-art.

## ISA Extensions

### Conditional Execution
- **Predication**: Every instruction has a predicate bit. If the bit is false, the instruction is a NOP. Eliminates short branches (e.g., Intel Itanium).
- **Conditional Moves (CMOV)**: RISC-friendly version of predication.

### Memory Models
The ISA defines the memory consistency model (e.g., TSO for x86, Weak for ARM). This is a critical part of the contract between hardware and software.

## Case Study: ARMv8-A
- **64-bit Fixed Length**: Clean for high-performance superscalar.
- **Weak Consistency**: Allows aggressive memory reordering.
- **SIMD (NEON)**: Integrated vector support.

## Related
- [[CSE469/Instruction Set Architecture|CSE469: Instruction Set Architecture]]
- [[CSE470/Dynamic Scheduling and OoO|Dynamic Scheduling and OoO]]
