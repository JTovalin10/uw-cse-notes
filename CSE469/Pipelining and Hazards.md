# Course: Pipelining and Hazards

Pipelining is a technique where multiple instructions are overlapped in execution. It improves **throughput** (total work per unit time) by allowing multiple instructions to be in different stages of completion simultaneously.

## Pipeline Stages (Classic RISC 5-Stage)
1. **IF (Instruction Fetch)**: Fetch the 32-bit instruction from memory (using PC).
2. **ID (Instruction Decode)**: Read registers (Rn, Rm) and decode the opcode.
3. **EX (Execute)**: Perform ALU operation, address calculation, or branch comparison.
4. **MEM (Memory Access)**: Read/write data memory (only for Load/Store).
5. **WB (Writeback)**: Write the result (from ALU or MEM) back to the destination register (Rd/Rt).

### Pipeline Timing Diagram
Example of 5 instructions executing concurrently:

| Cycle | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |
| :--- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| **Instr 1** | IF | ID | EX | MEM | WB | | | | |
| **Instr 2** | | IF | ID | EX | MEM | WB | | | |
| **Instr 3** | | | IF | ID | EX | MEM | WB | | |
| **Instr 4** | | | | IF | ID | EX | MEM | WB | |
| **Instr 5** | | | | | IF | ID | EX | MEM | WB |

## Pipeline Hazards
Hazards are situations that prevent the next instruction in the stream from executing in its designated clock cycle.

### 1. Structural Hazards
Conflict over a physical resource.
- **Example**: A single memory port used for both Instruction Fetch and Data Access.
- **Solution**: Use separate caches for instructions (L1I) and data (L1D) — the "Harvard Architecture."

### 2. Data Hazards (RAW - Read After Write)
An instruction depends on the result of a previous instruction that hasn't finished.

#### Example:
```assembly
ADD X0, X1, X2  // X0 is written in WB stage (Cycle 5)
SUB X3, X0, X4  // X0 is read in ID stage (Cycle 3) -> HAZARD!
```

#### Solutions:
1.  **Stalling**: Insert "bubbles" into the pipeline. (Inefficient).
2.  **Forwarding (Bypassing)**: Pass the result directly from the pipeline registers (EX/MEM or MEM/WB) to the ALU inputs of the dependent instruction.
    - **Logic**: If `(EX/MEM.RegisterRd == ID/EX.RegisterRn)`, then select the forwarded value instead of the value from the register file.

#### The Load-Use Hazard
A special case where forwarding cannot eliminate the stall.
```assembly
LDUR X0, [X1, #0] // X0 is only ready AFTER the MEM stage (Cycle 4)
ADD X2, X0, X3    // X0 is needed at the START of EX stage (Cycle 4)
```
- **Outcome**: Must stall for **1 cycle** even with forwarding.

### 3. Control Hazards (Branches)
The processor doesn't know which instruction to fetch next until the branch is resolved (usually in EX stage).

#### Solutions:
- **Flushing**: If the prediction is wrong, discard the instructions already in IF/ID.
- **Dynamic Branch Prediction**:
    - **1-bit Predictor**: Remembers the last outcome.
    - **2-bit Saturating Counter**: Requires two consecutive "wrong" outcomes to change prediction (more stable).
        - *States*: Strongly Taken (11), Weakly Taken (10), Weakly Not Taken (01), Strongly Not Taken (00).

### Formal Definition
Pipelining is a method of implementing a CPU where multiple instructions are processed concurrently in different stages of the execution cycle, increasing instruction throughput.

### Simplified Explanation
Instead of waiting for one person to finish their entire laundry load (wash, dry, fold) before the next person starts, the next person starts washing as soon as the first person moves to the dryer.

## Related
- [[CSE469/Processor Performance|Processor Performance]]
- [[CSE469/Advanced Architecture|Advanced Architecture]]
