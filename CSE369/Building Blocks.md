# Course: Building Blocks

Complex digital systems are built using standard, reusable components called building blocks. These blocks abstract away low-level gate logic.

## Routing Elements

### Multiplexer (MUX)
A **Multiplexer** selects one of several input signals and forwards it to a single output line.
- An $n:1$ MUX has $n$ inputs and $\log_2(n)$ select lines.
- **Use Case**: Selecting between different data sources.

### Decoder
A **Decoder** converts an $n$-bit input code into at most $2^n$ unique outputs.
- Usually "one-hot," meaning only one output is active at a time.
- **Use Case**: Memory addressing, instruction decoding in CPUs.

### Encoder
An **Encoder** is the inverse of a decoder. It converts a one-hot input into a binary code.
- **Priority Encoder**: If multiple inputs are high, it encodes the index of the highest-priority (usually most significant) bit.

## Computational Elements

### Adder
- **Half Adder**: Adds two bits, producing a sum and a carry.
- **Full Adder**: Adds two bits and a carry-in, producing a sum and a carry-out.
- **Ripple-Carry Adder**: Chains full adders together. The delay is proportional to the number of bits ($O(n)$).

### Arithmetic Logic Unit (ALU)
The **ALU** is the "brawn" of the CPU. It performs arithmetic (ADD, SUB) and logical (AND, OR, XOR) operations. It is an idealized model of computation or a physical electronic device implementing a Boolean function.
- Selection of the operation is typically controlled by a MUX driven by the instruction decoder.

## Related
- [[CSE369/Combinational Logic|Combinational Logic]]
- [[CSE369/Finite State Machines|Finite State Machines]]
- [[CSE369/Memory and FPGAs|Memory and FPGAs]]
