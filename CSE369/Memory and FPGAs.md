# Course: Memory and FPGAs

Memory elements allow digital systems to store data, while FPGAs provide a programmable platform for implementing custom hardware logic.

## Memory Types

### ROM (Read-Only Memory)
- **Characteristics**: Non-volatile (retains data without power). Data is typically "burned in."
- **Use Case**: Look-up tables (LUTs), fixed firmware, constant data like fonts.

### RAM (Random Access Memory)
- **Characteristics**: Volatile (data lost on power-off). Can be read from and written to.
- **SRAM (Static RAM)**: Fast, built from flip-flops/latches. Used for CPU caches and registers.
- **DRAM (Dynamic RAM)**: Dense, uses capacitors. Slower than SRAM and requires refreshing.

## FPGAs

### Architecture
A **Field-Programmable Gate Array (FPGA)** consists of:
- **Logic Elements (LE)** or **Adaptive Logic Modules (ALM)**: Contain a Look-Up Table (LUT) for combinational logic and a Flip-Flop for sequential logic.
- **Programmable Interconnects**: Wires that can be configured to connect any LE to another.
- **I/O Blocks**: Connect the internal logic to physical pins on the chip.

### Workflow
1. **Design**: Write code in **[[CSE369/Verilog Fundamentals|Verilog]]**.
2. **Synthesis**: Convert Verilog into a netlist of logic gates.
3. **Place and Route**: Assign gates to physical LEs and determine the wiring.
4. **Bitstream**: Generate a file that configures the FPGA's internal switches.

## Related
- [[CSE369/Building Blocks|Building Blocks]]
- [[CSE369/Verilog Fundamentals|Verilog Fundamentals]]
