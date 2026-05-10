# Course: Verilog Fundamentals

**Verilog** is a Hardware Description Language (HDL) used to model electronic systems. Unlike C or Java, Verilog describes *structure* and *concurrency* rather than sequential instructions.

## Module Structure
A Verilog design is organized into modules.

```verilog
module half_adder (
    input  logic a,
    input  logic b,
    output logic carry,
    output logic sum
);
    assign carry = a & b;
    assign sum   = a ^ b;
endmodule
```

## Logic Types
- **Combinational Logic (`always_comb`)**: Used for logic that depends only on inputs. CAD tools check for unintended latches.
- **Sequential Logic (`always_ff`)**: Used for logic triggered by a clock edge (e.g., flip-flops).

### Blocking vs. Non-Blocking Assignments
- **Blocking (`=`)**: Evaluated sequentially within a block. Used in `always_comb`.
- **Non-Blocking (`<=`)**: Evaluated in parallel at the end of the time step. Used in `always_ff` to prevent race conditions.

### Formal Definition
Verilog is a concurrent language where statements like `assign` represent physical wires connecting components. The execution is driven by events (changes in signals) rather than a program counter.

### Simplified Explanation
You aren't writing a recipe for a computer to follow; you are drawing a map of how wires and gates should be connected.

## Advanced Features
- **Parameters**: Allow for reusable, generic modules (e.g., `parameter WIDTH=8`).
- **Generate Blocks**: Use `for` loops to instantiate multiple modules or gates programmatically.

## Related
- [[CSE369/Combinational Logic|Combinational Logic]]
- [[CSE369/Timing Constraints|Timing Constraints]]
