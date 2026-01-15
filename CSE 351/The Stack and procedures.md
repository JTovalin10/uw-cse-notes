# Switch Statements Notes

## Overview

Switch statements are implemented more efficiently than chains of if-else statements using **jump tables** and **indirect jumps**.

## Jump Tables

### Definition

A **jump table** is an array of pointers where each pointer points to a code block instead of program data.

### Structure

- Array indices correspond to case values
- Array entries contain addresses of code blocks
- More efficient than sequential if-else comparisons

### Handling Special Cases

#### Multiple Case Labels

```c
case 1:
case 2:
case 3:
    // same code block
```

**Implementation:** Store the same code block address in jump table entries 1, 2, and 3.

#### Fall-through

```c
case 1:
    code_a();
    // fall through
case 2:
    code_b();
    break;
```

**Implementation:** Place code blocks consecutively in memory so execution flows from one to the next.

#### Default Case

**Implementation:** All non-specified indices point to the default code block address.

## Program Counter (`%rip`)

### Definition

Special register that holds the **address of the next instruction** to execute.

### Behavior

- **Normal execution:** Advances to consecutive instructions
- **Jump instructions:** Can alter the program counter to jump elsewhere

## Indirect Jumps

### Syntax

```assembly
jmp *Loc
```

### Key Points

- **Asterisk (`*`)** differentiates from normal jumps
- Address to jump to is **found in** `Loc`, not directly given
- `Loc` can be a register or memory operand

### Example with Jump Table

```assembly
jmp *.L4(,%rdi,8)
```

**Explanation:**

- `.L4` = label of jump table start
- `%rdi` = switch variable value
- `8` = size of each pointer (8 bytes)
- Jumps to address stored at `jump_table[switch_value]`

### How It Works

1. Calculate jump table entry: `.L4 + %rdi * 8`
2. Load address from that memory location
3. Jump to the loaded address

## Complete Switch Example

```c
switch (x) {
    case 0: return a;
    case 1: return b;
    case 2: 
    case 3: return c;
    default: return d;
}
```

**Jump Table:**

```
.L4:    # Jump table
    .quad .L_case0    # case 0
    .quad .L_case1    # case 1  
    .quad .L_case23   # case 2
    .quad .L_case23   # case 3 (same as case 2)
    .quad .L_default  # anything else
```

**Assembly:**

```assembly
cmpq $3, %rdi         # Check if x > 3
ja .L_default         # Jump to default if out of range
jmp *.L4(,%rdi,8)     # Indirect jump using table

.L_case0:
    movq %rax, %rax   # return a
    ret

.L_case1:  
    movq %rbx, %rax   # return b
    ret

.L_case23:
    movq %rcx, %rax   # return c
    ret

.L_default:
    movq %rdx, %rax   # return d
    ret
```

---

# Memory Layout Notes

## Memory Segments Overview

From highest to lowest addresses:

|Segment|Purpose|Growth Direction|
|---|---|---|
|**Stack**|Local variables, function calls|Downward (↓)|
|**Heap**|Dynamic allocation (`malloc`)|Upward (↑)|
|**Static/Global**|Global variables, static data|Fixed|
|**Literals**|String literals, constants|Fixed|
|**Code/Text**|Program instructions|Fixed|

## The Stack

### Characteristics

- **Location:** Highest usable addresses
- **Contents:** Local variables, procedure context
- **Growth:** Downward (toward lower addresses)
- **Management:** Automatic (by function calls/returns)

### Why Downward Growth?

- Convention established by early systems
- Allows heap and stack to grow toward each other
- Maximizes available memory for both

## Quiz Example

**Question:** Which address is from the Heap?

**Given addresses:**

- `0x400547` (Code)
- `0x400670` (Code)
- `0x601038` (Static/Global)
- `0x12a8010` (Heap) ← **Answer**
- `0x7fff0b570788` (Stack)

**Memory addresses ordered:** Code < Static < Heap < Stack

---

# The Stack Pointer Notes

## Stack Pointer (`%rsp`)

### Definition

Special register that holds the address of the **current "top"** of the stack.

### Key Concept

- Addresses **below** `%rsp` are **not considered** part of the stack
- Stack "top" moves as `%rsp` is manipulated
- Very useful as a reference point for accessing stack data

### Accessing Stack Data

```assembly
movq 8(%rsp), %rax      # Access data 8 bytes from stack top
movq -16(%rsp), %rbx    # Access data 16 bytes "into" the stack
```

## Stack Manipulation

### Direct Manipulation

```assembly
subq $16, %rsp          # Allocate 16 bytes (stack grows down)
addq $16, %rsp          # Deallocate 16 bytes
```

**Important:** This only changes `%rsp`, not the actual data in memory!

### Push Instruction

```assembly
pushq %rax              # Push value in %rax onto stack
```

**Steps:**

1. **Decrement** `%rsp` by 8 (allocate space)
2. **Copy** `%rax` to memory at new `%rsp` location

**Equivalent to:**

```assembly
subq $8, %rsp           # Step 1: allocate
movq %rax, (%rsp)       # Step 2: store
```

### Pop Instruction

```assembly
popq %rbx               # Pop top stack value into %rbx
```

**Steps:**

1. **Copy** data from `(%rsp)` to `%rbx`
2. **Increment** `%rsp` by 8 (deallocate space)

**Equivalent to:**

```assembly
movq (%rsp), %rbx       # Step 1: load
addq $8, %rsp           # Step 2: deallocate
```

## Quiz Example

**Question:** If `%rsp = 0x7fffff000000`, what is `%rsp` after `popq %rbx`?

**Answer:** `0x7fffff000008`

- Pop **deallocates** 8 bytes
- Stack grows downward, so deallocation **increases** `%rsp`
- `0x7fffff000000 + 8 = 0x7fffff000008`

---

# x86-64 Procedure Calling Conventions Notes

## Overview

**Calling conventions** are established rules for how procedures pass data and control between each other.

### Terminology

- **Caller:** Procedure doing the calling
- **Callee:** Procedure being called

## Return Address

### Concept

Since procedures can be called from multiple locations, we need to store where to return after the call completes.

### Example

```c
void multstore(long x, long y, long* dest) {
    long t = mult2(x, y);    // Call mult2
    *dest = t;               // Return here after mult2
}
```

**Assembly with addresses:**

```
40112e: push %rbx
40112f: mov %rdx,%rbx  
401132: callq 401126 <mult2>    # Call instruction
401137: mov %rax,(%rbx)         # Return address ← HERE
40113a: pop %rbx
40113b: retq
```

**Key addresses:**

- `0x401132` = address of `callq` instruction
- `0x401137` = **return address** (next instruction after call)

## Procedure Call (`call`)

### Instruction: `call label`

### Steps:

1. **Push return address** onto stack (address of next instruction)
2. **Update `%rip`** to the address of the specified label

### Example

```assembly
401132: callq mult2
```

**Effect:**

1. Push `0x401137` onto stack
2. Jump to `mult2` function

## Procedure Return (`ret`)

### Instruction: `ret`

### Steps:

1. **Pop return address** from stack
2. **Update `%rip`** to the popped address

### Critical Requirement

`%rsp` **must** point to the return address before calling `ret`!

## Argument Passing

### First 6 Arguments (Registers)

Arguments passed in specific registers **in order:**

|Argument|Register|Mnemonic|
|---|---|---|
|1st|`%rdi`|**D**iane's|
|2nd|`%rsi`|**S**ilk|
|3rd|`%rdx`|**D**ress|
|4th|`%rcx`|**C**ost|
|5th|`%r8`|**$8**|
|6th|`%r9`|**9**|

**Memory aid:** "Diane's Silk Dress Cost $8 9"

### Additional Arguments (Stack)

- Arguments 7+ pushed onto stack in **reverse order**
- 7th argument pushed **last** (closest to return address)

### Example Function Call

```c
func(a, b, c, d, e, f, g, h);
```

**Setup:**

```assembly
movq h, (%rsp)          # 8th argument (push last)
movq g, 8(%rsp)         # 7th argument  
movq a, %rdi            # 1st argument
movq b, %rsi            # 2nd argument
movq c, %rdx            # 3rd argument
movq d, %rcx            # 4th argument
movq e, %r8             # 5th argument
movq f, %r9             # 6th argument
call func
```

## Return Value

### Single Return Value

- **Location:** `%rax` register
- **Size limit:** One word (8 bytes)

### Large Return Values

- Return **pointer** to the value in `%rax`
- Actual data stored elsewhere (usually caller-allocated space)

## Quiz Examples

### Question 1: Return Address

**Code:**

```
401126: sub $0x8,%rsp
40112a: mov $0x402010,%edi
40112f: callq 401030 <puts@plt>
401134: mov $0x0,%eax          ← Return address
401139: add $0x8,%rsp
40113d: retq
```

**Answer:** `0x401134` (instruction after `callq`)

### Question 2: Parameter Location

**Function:** `multstore(long x, long y, long* dest)` **Question:** Which register holds `dest`?

**Answer:** `%rdx` (3rd argument → "Dress" in mnemonic)

---

# Introduction to Stack Frames Notes

## Concept

**Stack frames** are conceptual divisions of the stack that hold the local state of each procedure instantiation.

## Why Stack Frames?

- **Enable recursion:** Multiple simultaneous instances of the same procedure
- **Organize memory:** Group related procedure data together
- **Automatic management:** Created on call, destroyed on return

## Stack Frame Lifetime

- **Created:** When procedure is called
- **Exists:** During procedure execution
- **Destroyed:** When procedure returns

## Stack Discipline

### Definition

Proper management of stack frames to ensure correct operation.

### Key Principle

**Parallel allocation/deallocation:** Any space allocated during procedure execution must be deallocated in the **opposite order** before return.

### Why Important?

- Ensures `ret` correctly pops the return address
- Maintains stack integrity for nested calls
- Prevents stack corruption

## LIFO (Last In, First Out) Consequences

### Nested Calls

```
main → foo → bar
```

- `bar` must return before `foo` can return
- `foo` must return before `main` can continue
- Caller's frame cannot be deallocated until callee's frame is

### Memory Reuse Example

```
main calls foo → foo calls bar → bar returns → foo returns
main calls baz → baz overwrites foo's old frame data
```

**Important:** Don't use data from deallocated frames - it **will** be overwritten!

## Stack Frame Example

```
Higher addresses
┌─────────────────┐
│     main        │ ← main's frame
├─────────────────┤
│      foo        │ ← foo's frame (created when main calls foo)
├─────────────────┤  
│      bar        │ ← bar's frame (created when foo calls bar)
├─────────────────┤ ← Current %rsp
│                 │
│   (unused)      │
│                 │
└─────────────────┘
Lower addresses
```

**After bar returns:**

```
┌─────────────────┐
│     main        │
├─────────────────┤
│      foo        │ ← Current frame
├─────────────────┤ ← Current %rsp
│   (old bar)     │ ← Don't use this data!
│                 │
└─────────────────┘
```

---

# Stack Frame Details Notes

## Stack Frame Layout

```
Higher addresses
┌─────────────────┐
│ Caller's frame  │
├─────────────────┤
│ Arguments 7+    │ ← Part of caller's argument build area
├─────────────────┤
│ Return address  │ ← Pushed by call instruction (frame start)
├─────────────────┤
│ Old %rbp        │ ← Optional frame pointer (if used)
├─────────────────┤
│ Saved registers │ ← Callee-saved registers
├─────────────────┤
│ Local variables │ ← Local data not in registers
├─────────────────┤
│ Saved registers │ ← Before calling other functions
├─────────────────┤
│ Arguments 7+    │ ← For functions this frame calls
├─────────────────┤ ← Current %rsp
Lower addresses
```

## Frame Components

### 1. Return Address

- **Location:** Top of frame (highest address in frame)
- **Created by:** `call` instruction automatically pushes it
- **Purpose:** Tells `ret` where to return

### 2. Frame Pointer (`%rbp`) - Optional

- **Purpose:** Reference point for accessing frame data
- **x86-64:** Not required, often omitted for efficiency
- **If used:** Old `%rbp` value must be saved and restored

### 3. Saved Registers

- **Purpose:** Preserve values that callee might modify
- **Location:** After frame pointer
- **Restored:** Before function returns

### 4. Local Variables

- **Purpose:** Variables that don't fit in registers
- **Access:** Via offsets from `%rsp` or `%rbp`
- **Example:** `movq -8(%rsp), %rax` (load local variable)

### 5. Argument Build Area

- **Purpose:** Arguments 7+ for functions this frame calls
- **Location:** Bottom of frame (lowest addresses)
- **Timing:** Created before making function calls

## Frame Efficiency

### Why Omit Parts?

- **Stack access is slow** (memory vs. registers)
- **Omit unused components** to improve performance
- **Modern compilers** heavily optimize frame usage

### Common Optimizations

- Use registers instead of stack for local variables
- Omit frame pointer when not needed
- Minimize saved registers

## Quiz Example

**Question:** If a procedure takes 7 arguments, where is the 7th argument found?

**Answer:** In the **caller's argument build area**, above the return address.

**Explanation:**

- Arguments 7+ are pushed **before** `call` executes
- They appear **above** the return address in memory
- They're part of the **caller's** frame, not the callee's frame

## Frame Access Patterns

### Using Stack Pointer (`%rsp`)

```assembly
movq 8(%rsp), %rax      # Access return address
movq -8(%rsp), %rbx     # Access local variable
movq -16(%rsp), %rcx    # Access another local variable
```

### Using Frame Pointer (`%rbp`) - If Used

```assembly
pushq %rbp              # Save old frame pointer
movq %rsp, %rbp         # Set up new frame pointer

movq 8(%rbp), %rax      # Access first argument (if on stack)
movq -8(%rbp), %rbx     # Access local variable
movq -16(%rbp), %rcx    # Access another local variable

popq %rbp               # Restore old frame pointer
```

## Frame Management Example

```assembly
# Function prologue
pushq %rbp              # Save caller's frame pointer
movq %rsp, %rbp         # Set up our frame pointer
subq $16, %rsp          # Allocate space for local variables

# Function body
movq %rdi, -8(%rbp)     # Store first argument locally
movq $42, -16(%rbp)     # Initialize local variable

# Function epilogue  
movq %rbp, %rsp         # Deallocate local variables
popq %rbp               # Restore caller's frame pointer
ret                     # Return (pops return address)
```