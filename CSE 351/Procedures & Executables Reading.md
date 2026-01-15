# Recursion Notes

## Key Concept

Recursion works seamlessly with our stack frame layout and calling conventions - **no special considerations needed!**

## How Recursion Works with Stack Frames

### Automatic Stack Management

- Each recursive call creates a **new stack frame**
- Each instance has its own **local procedure context**
- Register saving conventions prevent instances from **corrupting each other's data**

### Dual Role Challenge

Recursive procedures must be written considering they are **both caller and callee**:

- **As callee:** Receives parameters, returns values
- **As caller:** Makes recursive calls with new parameters
- **Key insight:** Same registers used in recursive calls, so values must be carefully preserved

## Factorial Example Analysis

### C Code (Conceptual)

```c
int fact(int n) {
    if (n <= 1) return 1;
    return n * fact(n-1);
}
```

### Assembly Implementation

```assembly
0000000000401126 <fact>:
  401126:   mov    $0x1,%eax        # Set return value to 1
  40112b:   cmp    $0x1,%rdi        # Compare n with 1
  40112f:   ja     401132 <fact+0xc># Jump if n > 1 (recursive case)
  401131:   retq                    # Return 1 (base case)
  401132:   push   %rbx             # Save old %rbx (callee-saved)
  401133:   mov    %rdi,%rbx        # Save n in %rbx
  401136:   lea    -0x1(%rdi),%rdi  # Compute n-1 for recursive call
  40113a:   callq  401126 <fact>    # Recursive call fact(n-1)
  40113f:   imul   %rbx,%rax        # Multiply n * fact(n-1)
  401143:   pop    %rbx             # Restore old %rbx
  401144:   retq                    # Return result
```

### Stack Frame Growth for `fact(3)`

```
Higher addresses
┌─────────────────┐
│     main        │
├─────────────────┤
│ <ret to main>   │ ← fact(3) frame
│ <main's %rbx>   │
├─────────────────┤
│   0x40113f      │ ← fact(2) frame (return addr)
│       3         │   (saved n from fact(3))
├─────────────────┤  
│   0x40113f      │ ← fact(1) frame (return addr)
├─────────────────┤ ← Current %rsp
Lower addresses
```

### Execution Trace

#### fact(3) Call

1. **0x40112f:** `n = 3 > 1`, jump to recursive case
2. **0x401132:** Push main's `%rbx` value onto stack
3. **0x401133:** Save `n = 3` in `%rbx`
4. **0x401136:** Set `%rdi = 2` (n-1)
5. **0x40113a:** Call `fact(2)`, pushes return address `0x40113f`

#### fact(2) Call

6. **0x40112f:** `n = 2 > 1`, jump to recursive case
7. **0x401132:** Push `%rbx = 3` (from fact(3)) onto stack
8. **0x401133:** Save `n = 2` in `%rbx`
9. **0x401136:** Set `%rdi = 1` (n-1)
10. **0x40113a:** Call `fact(1)`, pushes return address `0x40113f`

#### fact(1) Call (Base Case)

11. **0x40112f:** `n = 1`, don't jump (base case)
12. **0x401131:** Return `%rax = 1`

#### Unwinding

- **fact(1)** returns 1
- **fact(2)** computes `2 * 1 = 2`, returns 2
- **fact(3)** computes `3 * 2 = 6`, returns 6

### Key Observations

- **fact(1) frame is smaller:** Doesn't reach `pushq` instruction in base case
- **Return address:** All recursive calls return to `0x40113f` (the `imul` instruction)
- **Value preservation:** Each `n` value saved in `%rbx` and restored for multiplication

## Quiz Answer

**Question:** In a recursive case of `fact(n)`, how is `n` being saved?

**Answer:** `n` is saved in `%rbx` (callee-saved register)

- Original `n` arrives in `%rdi`
- Copied to `%rbx` at instruction `0x401133`
- The value pushed at `0x401132` is the **previous frame's** `n`, not current `n`

---

# x86-64 Register Saving Conventions Notes

## Overview

**Register saving conventions** define how procedures handle register reuse to avoid destroying other procedures' data.

## Two Types of Registers

### Callee-saved Registers

- **Responsibility:** Callee must save/restore if it uses the register
- **Timing:** Save early in function, restore just before `ret`
- **Caller perspective:** Values remain unchanged across function calls

### Caller-saved Registers

- **Responsibility:** Caller must save/restore if it needs the value later
- **Timing:** Save before `call`, restore after `call` returns
- **Callee perspective:** Free to modify without concern for old values

## Examples

### Callee-saved Example (`%rbx`)

```assembly
# Callee function
function:
    pushq %rbx          # Save old %rbx value
    movq %rdi, %rbx     # Use %rbx for our purposes
    # ... function body ...
    popq %rbx           # Restore old %rbx value
    ret
```

**Caller's view:**

```assembly
movq $42, %rbx          # Caller puts value in %rbx
call function           # Call function
# %rbx still contains 42 after return
```

### Caller-saved Example (`%rax`)

```assembly
# Caller code
movq %rax, %r10         # Save %rax value (if needed later)
call some_function      # Function may overwrite %rax
movq %r10, %rax         # Restore %rax value
```

**Callee's view:**

```assembly
some_function:
    movq $100, %rax     # Free to overwrite %rax
    # ... function body ...
    ret                 # Return value typically in %rax
```

## Stack Ordering (LIFO)

When saving multiple registers, maintain **proper order**:

```assembly
# Saving (push in any order)
pushq %rcx
pushq %rdx

# Restoring (pop in REVERSE order)
popq %rdx               # Must pop %rdx first
popq %rcx               # Then pop %rcx
```

## Stack Frame Integration

### Callee-saved Registers

- **Location:** Near return address (saved early)
- **Purpose:** Must save before using these registers

### Caller-saved Registers

- **Location:** After local variables (saved before calls)
- **Purpose:** Only saved when making function calls

```
┌─────────────────┐
│ Return address  │
├─────────────────┤
│ Callee-saved    │ ← Saved early in function
│ registers       │
├─────────────────┤
│ Local variables │
├─────────────────┤
│ Caller-saved    │ ← Saved before making calls
│ registers       │
├─────────────────┤
│ Arguments 7+    │
└─────────────────┘
```

## Optimization Strategy

Choose register types carefully to **minimize stack usage**:

- Use **caller-saved** for temporary values not needed across calls
- Use **callee-saved** for values needed throughout function
- Compilers optimize register allocation automatically

---

# Stack Frame Contents Notes

## Ideal Case: Minimal Stack Frame

**Goal:** Stack frame contains **only return address**

- All work done in registers (much faster than memory)
- Compiler optimization aims to minimize memory usage

## When Stack Growth is Required

### 1. Too Many Local Variables

```c
int func() {
    int a, b, c, d, e, f, g, h, i, j;  // More variables than registers
    // Must save some callee-saved registers for local storage
}
```

### 2. Large Local Data Structures

```c
int func() {
    int array[1000];        # Arrays can't fit in single registers
    struct large_struct s;  # Structs require memory allocation
}
```

### 3. Address-of Operator (`&`)

```c
int func() {
    int x = 5;
    int *ptr = &x;          # x must be in memory (registers have no address)
}
```

### 4. Functions with 7+ Arguments

```c
void caller() {
    func(a, b, c, d, e, f, g, h);  # g, h pushed to stack
}
```

### 5. Caller-saved Data Across Calls

```c
int func() {
    int important_value = compute();
    other_function();       # Must save important_value if in caller-saved register
    return important_value; # Still need the value after call
}
```

### 6. Using Callee-saved Registers

```c
int func() {
    // Any use of %rbx, %rbp, %r12-r15 requires saving old values
}
```

## Memory Access Performance

- **Registers:** ~1 cycle access time
- **Stack (L1 cache):** ~4 cycles
- **Memory:** 100+ cycles

**Optimization principle:** Keep frequently used data in registers!

---

# CALL Process Notes

## Overview: Building an Executable

**CALL** = **C**ompiling → **A**ssembling → **L**inking → **L**oading

### Build Process (First 3 phases)

1. **Compiling:** Source code → Assembly code
2. **Assembling:** Assembly code → Object file
3. **Linking:** Object files → Executable

### Runtime Process (4th phase)

4. **Loading:** Executable → Running process

## Compiling Phase

### Input/Output

- **Input:** Source code (`.c` files)
- **Output:** Assembly code (`.s` files)

### Two Steps

1. **Preprocessor:** Handle directives (`#include`, `#define`, etc.)
2. **Compiler:** Translate C semantics to assembly instructions

### Compiler Optimization Flags

- **`-O0`:** No optimization (fast compilation, debugging)
- **`-O1`, `-O2`, `-O3`:** Performance optimization (increasing levels)
- **`-Os`:** Size optimization
- **`-Og`:** Debug-friendly optimization

### GCC Usage

```bash
gcc -S source.c         # Stop after compiling, output source.s
gcc -O2 -S source.c     # Compile with optimization level 2
```

## Assembling Phase

### Input/Output

- **Input:** Assembly code (`.s` files)
- **Output:** Object files (`.o` files)

### Object File Contents

- **Object code:** Incomplete machine code
- **Symbol table:** Globally accessible labels (function names, global variables)
- **Relocation table:** Addresses that need patching

### Why "Incomplete"?

- **Missing addresses:** Don't know final addresses of labels yet
- **Need patching:** Addresses filled in during linking
- **Multiple files:** Each object file only knows about itself

### Object File Sections

Correspond to memory layout:

- **Code section:** Program instructions
- **Static data section:** Global variables
- **Literals section:** String constants, etc.

### Quiz Example

**Question:** Which instruction has "incomplete" translation?

```assembly
movq $5, %rax           # Complete (immediate value)
addq %rbx, %rax         # Complete (register operations)
callq puts              # Incomplete (label address unknown)
ret                     # Complete (no labels)
```

**Answer:** `callq puts` - don't know address of `puts` function yet

## Linking Phase

### Purpose

**Stitch together** all object files and libraries into final executable.

### Process

1. **Combine sections:** Merge code, data, and literal sections
2. **Resolve references:** Match relocation table entries with symbol table entries
3. **Assign addresses:** Give final addresses to all labels

### Symbol Resolution

- **Relocation table:** "I need the address of function X"
- **Symbol table:** "Function X is at address Y"
- **Linker:** Updates all references with correct addresses

### Failure Cases

```bash
# Undefined function
gcc file1.o file2.o     # Error if file1 calls function not defined anywhere

# Missing library
gcc program.o           # Error if program uses printf but doesn't link libc
gcc program.o -lc       # Success - links standard C library
```

### Quiz Answer

**Question:** "The linker is unnecessary if I only wrote a single source file."

**Answer:** **False** - Even single files need linking for:

- Standard library functions (`printf`, `malloc`, etc.)
- System call interfaces
- Runtime startup code

## Disassembling (Not part of CALL)

### Purpose

**Reverse engineering:** Convert binary back to readable assembly.

### Example Output

```
0000000000401126 <main>:
  401126: 48 83 ec 08    sub    $0x8,%rsp
  40112a: bf 10 20 40 00 mov    $0x402010,%edi
  40112f: e8 fc fe ff ff callq  401030 <puts@plt>
  401134: b8 00 00 00 00 mov    $0x0,%eax
  401139: 48 83 c4 08    add    $0x8,%rsp
  40113d: c3             retq
```

### Column Meanings

- **Left:** Memory addresses (hex)
- **Middle:** Machine code bytes (hex)
- **Right:** Interpreted assembly instructions

### Limitations

- **Not perfect:** May misinterpret non-instruction bytes
- **Lost information:** Comments, variable names, etc.
- **Best effort:** Disassembler guesses instruction boundaries

## Loading Phase

### Purpose

**Start execution:** Convert executable file into running process.

### Operating System Tasks

- **Memory setup:** Initialize code, data, stack, heap sections
- **Register initialization:** Set initial register values
- **Process creation:** Create process control block
- **Begin execution:** Jump to program entry point

### Memory Layout Creation

```
Higher addresses
┌─────────────────┐
│     Stack       │ ← Initialized by OS
├─────────────────┤
│      Heap       │ ← Empty initially
├─────────────────┤
│ Static/Global   │ ← Copied from executable
├─────────────────┤
│   Literals      │ ← Copied from executable  
├─────────────────┤
│     Code        │ ← Copied from executable
└─────────────────┘
Lower addresses
```

**Note:** Code, Static, and Literals sections copied directly from executable file!