# Course: Instruction Set Architecture

The **Instruction Set Architecture (ISA)** is the abstract interface between the hardware (processor) and the lowest-level software (compiler/assembler). It defines everything a programmer needs to know to make a binary program work correctly, including instructions, registers, and memory behavior.

## ARMv8-A (AArch64)
The course focuses on the 64-bit ARMv8 architecture, which is a Reduced Instruction Set Computer (RISC).

### Core Registers
- **32x 64-bit Registers** (X0-X31):
    - **X0-X7**: Parameter passing and return values.
    - **X9-X15**: Caller-saved (temporary).
    - **X19-X28**: Callee-saved (preserved).
    - **X29 (FP)**: Frame Pointer.
    - **X30 (LR)**: Link Register (stores return address).
    - **XZR (X31)**: Zero Register. Always reads as 0; writes are discarded.
- **PC (Program Counter)**: Holds the address of the current instruction.

### Instruction Formats
All ARMv8 instructions are exactly **32 bits (4 bytes)** wide.

#### R-format (Register)
Used for arithmetic/logical operations between registers.
`ADD Rd, Rn, Rm`
- **Fields**: `opcode (11), Rm (5), shamt (6), Rn (5), Rd (5)`
- **shamt**: Shift amount (used for operations like `LSL`).

#### I-format (Immediate)
Used for operations with a constant value.
`ADDI Rd, Rn, #constant`
- **Fields**: `opcode (10), immediate (12), Rn (5), Rd (5)`
- **Range**: 12-bit unsigned immediate (0 to 4095).

#### D-format (Data Transfer)
Used for loads and stores.
`LDUR Rt, [Rn, #offset]`
- **Fields**: `opcode (11), address (9), op2 (2), Rn (5), Rt (5)`
- **LDUR/STUR**: "Unscaled" offset (9-bit signed).
- **LDR/STR**: "Scaled" offset (12-bit).

#### B-format & CB-format (Branching)
- **B**: Unconditional branch. `B offset`. 26-bit PC-relative offset.
- **CBZ/CBNZ**: Compare and branch if zero/not zero. `CBZ Rt, offset`. 19-bit offset.

## Addressing Modes

1. **Immediate Addressing**: Operand is a constant within the instruction.
   - Example: `MOV X0, #10`
2. **Register Addressing**: Operands are in registers.
   - Example: `ADD X0, X1, X2`
3. **Base Addressing (Register Offset)**: Address is sum of a register and a constant.
   - Example: `LDUR X0, [X1, #100]`
4. **PC-Relative Addressing**: Address is the sum of the PC and a constant.
   - Example: `B label` (The assembler calculates the offset from the current PC to the label).

## Assembly Example: SWAP
Swapping two values in memory.

```assembly
// Goal: Swap contents of addresses in X10 and X11
LDUR X0, [X10, #0]  // Load value at X10 into temp X0
LDUR X1, [X11, #0]  // Load value at X11 into temp X1
STUR X1, [X10, #0]  // Store X1 into address in X10
STUR X0, [X11, #0]  // Store X0 into address in X11
```

### Formal Definition
The ISA serves as a contract between the hardware and the software. It encapsulates the set of opcodes, the register set, the addressing modes, and the memory model (endianness, consistency).

### Simplified Explanation
The ISA is the "language" the CPU speaks. If you want the CPU to add two numbers, you have to use the specific word (`ADD`) and format it exactly how the ISA manual says.

## Related
- [[CSE469/Processor Datapath and Control|Processor Datapath]]
- [[CSE351/x86-64 Assembly|x86-64 Assembly]]
