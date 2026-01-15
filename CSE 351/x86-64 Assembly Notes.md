 
## Instruction Format

Instructions follow the pattern: **instruction name + operands**

```assembly
instr op                # 1 operand: negq %rsi
instr src, dst          # 2 operands: addq %rdi, %rax
```

## Instruction Categories

1. **Data transfer** - copying data between locations
2. **Arithmetic and logical operations** - mathematical and bitwise operations
3. **Control flow** - changing execution order (jumps, calls, etc.)

## Size Specifiers

Every instruction ends with a size specifier:

- `b` = byte (1 byte)
- `w` = word (2 bytes)
- `l` = long word (4 bytes)
- `q` = quad word (8 bytes)

**Examples:**

```assembly
addb %al, %bl      # 1-byte addition
addw %ax, %bx      # 2-byte addition  
addl %eax, %ebx    # 4-byte addition
addq %rax, %rbx    # 8-byte addition
```

## Operand Types

### 1. Immediates (Constants)

- Prefix: `$`
- Constant integer values

```assembly
movq $42, %rax        # Move constant 42 into %rax
addl $10, %ebx        # Add 10 to %ebx
```

### 2. Registers

- Prefix: `%`
- Names of the 16 general-purpose registers

```assembly
movq %rdi, %rax       # Copy %rdi to %rax
subq %rcx, %rdx       # Subtract %rcx from %rdx
```

### 3. Memory

- Uses parentheses `()`
- Specifies memory addresses to dereference

```assembly
movq (%rsp), %rax     # Load value from memory at address in %rsp
movl 4(%rbp), %ecx    # Load from memory at %rbp + 4
```

## Operand Restrictions

**Cannot do:**

- Use immediate as destination: ~~`movq %rax, $5`~~
- Memory-to-memory operations: ~~`movq (%rax), (%rbx)`~~

**Valid combinations:**

```assembly
movq $5, %rax         # immediate → register ✓
movq %rax, (%rbx)     # register → memory ✓  
movq (%rax), %rbx     # memory → register ✓
```

## Register Names and Sizes

|64-bit|32-bit|16-bit|8-bit|
|---|---|---|---|
|%rax|%eax|%ax|%al|
|%rbx|%ebx|%bx|%bl|
|%rcx|%ecx|%cx|%cl|
|%rdx|%edx|%dx|%dl|

**Important:** Smaller register names refer to the **least significant bytes**

- `%ax` = lower 16 bits of `%rax`
- `%al` = lower 8 bits of `%rax`

**Special Rule:** 32-bit operations automatically zero the upper 32 bits

```assembly
movl $100, %eax       # Sets %rax = 0x0000000000000064
```

## Memory Addressing Modes

### General Form: `D(Rb,Ri,S)`

- **D** = Displacement (immediate/constant)
- **Rb** = Base register
- **Ri** = Index register
- **S** = Scale factor (1, 2, 4, or 8 only)

**Address calculation:** `Reg[Rb] + Reg[Ri] * S + D`

### Examples

```assembly
movb 8(%rax,%rbx,2), %cl    # Address = %rax + %rbx*2 + 8
```

Copies 1 byte from memory at that address into `%cl`.

**Key Point:** Always use full 64-bit register names in memory operands since addresses are word-size (8 bytes).

### Special Cases (Omitted Parts)

Default values when parts are missing:

- D = 0
- Reg[Rb] = 0
- Reg[Ri] = 0
- S = 1

**Examples:**

```assembly
(%rsi)              # Mem[%rsi]
4(%r10,%r11)        # Mem[%r10 + %r11 + 4]  
(,%rdx,2)           # Mem[%rdx * 2]
12(%rbp)            # Mem[%rbp + 12]
```

## Common Patterns

```assembly
# Array access: arr[i] where arr is in %rdi, i in %rsi  
movq (%rdi,%rsi,8), %rax    # Load arr[i] (8-byte elements)

# Stack operations
pushq %rax              # Push %rax onto stack
popq %rbx               # Pop into %rbx

# Function call setup
movq %rdi, %rax         # Move first argument to return register
```
# Condition Codes Notes

## Overview

**Condition codes** are status bits in the CPU that track information about the most recently executed instruction. They're part of the `EFLAGS` register and act like single-bit flags.

## The Four Main Condition Codes

|Flag|Name|Indicates|
|---|---|---|
|`CF`|Carry Flag|Unsigned overflow occurred|
|`ZF`|Zero Flag|Result was zero|
|`SF`|Sign Flag|Result was negative|
|`OF`|Overflow Flag|Signed overflow occurred|

## How Condition Codes Are Set

### 1. Implicit Setting (Side Effects)

Arithmetic and logical operations **automatically update** condition codes based on their results.

**Example:**

```assembly
# If %al contains 0x80
addb %al, %al           # %al = 0x80 + 0x80 = 0x00 (with overflow)
```

**Result:** `%al = 0x00` and condition codes are set:

- `CF = 1` (unsigned overflow: 0x80 + 0x80 = 0x100, carry out)
- `ZF = 1` (result is zero)
- `SF = 0` (result is not negative in 2's complement)
- `OF = 1` (signed overflow: -128 + -128 = -256, outside 8-bit range)

### 2. Explicit Setting (Dedicated Instructions)

Two special instructions **only** update condition codes without storing results:

#### Compare (`cmp`)

- Performs subtraction but **doesn't store result**
- Equivalent to `sub` instruction for condition code purposes

```assembly
cmpq %rax, %rbx         # Computes %rbx - %rax, sets flags only
```

#### Test (`test`)

- Performs bitwise AND but **doesn't store result**
- Equivalent to `and` instruction for condition code purposes

```assembly
testq %rax, %rax        # Computes %rax & %rax, sets flags only
```

**Example:**

```assembly
# If %al = 0x83, %bl = 0x8C  
testb %al, %bl          # Compute 0x83 & 0x8C = 0x80, don't store
```

**Result:** No registers change, but condition codes are set:

- `CF = 0` (bitwise operations never cause carry)
- `ZF = 0` (result 0x80 ≠ 0)
- `SF = 1` (result 0x80 is negative in 2's complement)
- `OF = 0` (bitwise operations never cause overflow)

## Why Condition Codes Matter

Condition codes are used by **control flow instructions**:

### 1. Jump Instructions (`j*`)

Make decisions based on condition code values

```assembly
cmpq $0, %rax           # Compare %rax with 0
je zero_label           # Jump if equal (ZF = 1)
jl negative_label       # Jump if less than (SF ≠ OF)
```

### 2. Set Instructions (`set*`)

Set a byte to 0 or 1 based on condition codes

```assembly
cmpq %rax, %rbx         # Compare %rbx with %rax
setg %cl                # Set %cl = 1 if %rbx > %rax, else %cl = 0
```

## Common Patterns

### Testing for Zero

```assembly
testq %rax, %rax        # Sets ZF = 1 if %rax == 0
je is_zero              # Jump if %rax was zero
```

### Comparing Values

```assembly
cmpq $10, %rdi          # Compare %rdi with 10
jle less_equal          # Jump if %rdi ≤ 10
jg greater              # Jump if %rdi > 10
```

### Checking Sign

```assembly
testq %rax, %rax        # Check sign of %rax
js negative             # Jump if %rax < 0 (SF = 1)
```

## Key Points

- **Implicit setting:** Most arithmetic/logical operations update flags automatically
- **Explicit setting:** `cmp` and `test` exist solely to set flags
- **No storage:** `cmp` and `test` never modify operands, only condition codes
- **Bitwise operations:** Always have `CF = 0` and `OF = 0` (no carry/overflow possible)
- **Control flow:** Condition codes enable if-statements, loops, and conditional execution

## Implementation of Control Structures

Through `jump` and `set` instructions using condition codes, we can implement:

- **if-else statements**
- **loops** (for, while, do-while)
- **switch statements**
- **conditional expressions**
# Jump and Set Instructions Notes

## Overview

**Jump** and **Set** instructions work as pairs with condition-setting instructions to implement control flow. They read the condition codes set by previous instructions to make decisions.

## Instruction Families

### Jump Instructions (`j*`)

- **Purpose:** Change which instruction executes next (control flow)
- **Effect:** Jump to a specified **target** if condition is met
- **Includes unconditional jump:** `jmp` (always jumps)

### Set Instructions (`set*`)

- **Purpose:** Set a 1-byte register to 0 or 1 based on condition
- **Effect:** Store condition result in **dst** register (`0x00` = false, `0x01` = true)
- **No unconditional set:** All set instructions are conditional

## Common Jump and Set Instructions

|Instruction|Description|Jump Behavior|Set Behavior|
|---|---|---|---|
|`je`/`sete`|Equal to zero|Jump if equal|Set if equal|
|`jne`/`setne`|Not equal to zero|Jump if not equal|Set if not equal|
|`jg`/`setg`|Greater than zero|Jump if greater|Set if greater|
|`jge`/`setge`|Greater than or equal to zero|Jump if ≥|Set if ≥|
|`jl`/`setl`|Less than zero|Jump if less|Set if less|
|`jle`/`setle`|Less than or equal to zero|Jump if ≤|Set if ≤|
|`ja`/`seta`|Above (unsigned >)|Jump if above|Set if above|
|`jb`/`setb`|Below (unsigned <)|Jump if below|Set if below|
|`jmp`|Unconditional|Always jump|_(no equivalent)_|

## Typical Usage Pattern

### Two-Instruction Pairs

1. **First instruction:** Sets condition codes (`cmp`, `test`, or arithmetic/logical operation)
2. **Second instruction:** Uses condition codes (`jump` or `set`)

## Examples

### Jump Example

```assembly
# if (x > y) goto label;
# Assume x in %rdi, y in %rsi
cmpq %rsi, %rdi         # Compare x - y, set condition codes
jg greater_label        # Jump if x > y (result > 0)

# Code for x <= y case
...

greater_label:
# Code for x > y case
```

### Set Example

```assembly
# bool result = (x > y);
# Assume x in %rdi, y in %rsi
cmpq %rsi, %rdi         # Compare x - y, set condition codes  
setg %al                # %al = 1 if x > y, else %al = 0
```

**Explanation:**

- `cmpq %rsi, %rdi` computes `%rdi - %rsi` (i.e., `x - y`)
- `setg %al` checks if the result was "greater than 0"
- `%al` gets `0x01` if `x > y`, `0x00` if `x ≤ y`

### Combining with Test

```assembly
# if (x != 0) goto nonzero;
testq %rax, %rax        # Test if %rax is zero
jne nonzero             # Jump if not equal to zero

# Code for x == 0 case
...

nonzero:
# Code for x != 0 case
```

### Set with Arithmetic Result

```assembly
# Check if addition resulted in zero
addq %rbx, %rax         # %rax = %rax + %rbx (sets condition codes)
sete %cl                # %cl = 1 if result was zero, else 0
```

## Key Concepts

### Focus on Descriptions, Not Formulas

- **Don't memorize** the exact condition code formulas
- **Do understand** what each instruction tests for (equal, greater, less, etc.)
- Ask: "Is the description true of the last result that set condition codes?"

### Signed vs Unsigned Comparisons

```assembly
# Signed comparisons
jg label        # Jump if greater (signed)
jl label        # Jump if less (signed)

# Unsigned comparisons  
ja label        # Jump if above (unsigned >)
jb label        # Jump if below (unsigned <)
```

### Common Patterns

#### Testing for Zero

```assembly
testq %rax, %rax        # Set flags based on %rax
je zero_case            # Jump if %rax == 0
jne nonzero_case        # Jump if %rax != 0
```

#### Range Checking

```assembly
cmpq $100, %rdi         # Compare with upper bound
ja too_big              # Jump if %rdi > 100 (unsigned)

cmpq $0, %rdi           # Compare with lower bound  
jl too_small            # Jump if %rdi < 0 (signed)
```

#### Boolean Logic Implementation

```assembly
# Implement: result = (a == b)
cmpq %rbx, %rax         # Compare a and b
sete %cl                # %cl = (a == b)

# Implement: result = (a >= 5)  
cmpq $5, %rax           # Compare a with 5
setge %dl               # %dl = (a >= 5)
```

## Remember

- **Jump instructions** change program flow (like `goto`)
- **Set instructions** store boolean results (like `result = condition`)
- Both families work by reading condition codes set by previous instructions
- The "description" tells you what condition is being tested
# Extension Instructions (`movz` and `movs`) Notes

## Overview

Extension instructions are like `mov` but handle **size mismatches** where the source is smaller than the destination. They perform the two types of integer extension from C.

## Two Types of Extension

### Zero Extension (`movz`)

- Fills upper bits with **zeros**
- Used for **unsigned** values
- Preserves the unsigned magnitude

### Sign Extension (`movs`)

- Fills upper bits with copies of the **sign bit**
- Used for **signed** values
- Preserves the signed value in two's complement

## Instruction Format

**Two size specifiers required:**

- First: source width
- Second: destination width

Format: `mov[z|s][source_size][dest_size]`

## Examples

Starting with `%al = 0x80`:

```assembly
movzbw %al, %bx     # Zero extend byte→word: %bx = 0x0080
movsbw %al, %bx     # Sign extend byte→word: %bx = 0xFF80  
movsbl %al, %ebx    # Sign extend byte→long: %ebx = 0xFFFFFF80
```

**Important:** When using 32-bit destination (`%ebx`), upper 32 bits of the full register are automatically zeroed:

```assembly
movsbl %al, %ebx    # %ebx = 0xFFFFFF80, %rbx = 0x00000000FFFFFF80
```

## Quiz Example

**Question:** If `%rdi = 0xF8F7F6F5F4F3F2F1`, what is `%rdi` after `movswq %di, %rdi`?

**Solution:**

- `%di` contains lower 16 bits: `0xF2F1`
- `movswq`: sign extend word (16-bit) to quad word (64-bit)
- `0xF2F1` in signed 16-bit = negative (MSB = 1)
- Sign extend with 1s: `%rdi = 0xFFFFFFFFFFFFF2F1`

---

# Conditionals Notes

## Basic Structure

Conditionals in assembly use **two instructions:**

1. **Condition setter:** Sets condition codes (`cmp`, `test`, arithmetic, logical)
2. **Conditional jump:** Branches based on condition codes (`j*`)

## Converting C Conditions to Assembly

### Key Principle: Compare to Zero

All conditional jumps test the result **compared to zero**.

### Common Patterns

#### Comparison: `x >= y`

- Rewrite as: `x - y >= 0`
- Assembly:

```assembly
cmpq %rsi, %rdi     # Compute %rdi - %rsi (x - y)
jge target          # Jump if result >= 0
```

#### Equality: `x == 3`

- Rewrite as: `x - 3 == 0`
- Assembly:

```assembly
cmpq $3, %rax       # Compute %rax - 3 (x - 3)
je target           # Jump if result == 0
```

#### Bitwise Test: `x & 1`

- Rewrite as: `x & 1 != 0`
- Assembly:

```assembly
testq $1, %rax      # Compute %rax & 1
jne target          # Jump if result != 0
```

## Quiz Example

**Question:** Which instructions jump to `target` when `x < 3`?

**Solution:**

- Rewrite as: `x - 3 < 0`
- Need: `cmpq $3, %rax` (computes x - 3)
- Then: `jl target` (jump if less than 0)

---

# Labels Notes

## Definition

A **label** is a symbolic name for an instruction's memory address.

## Syntax

- **Declaration:** `identifier:` (with colon)
- **Usage:** `identifier` (without colon)

## Examples

```assembly
main:               # Label declaration
    movq %rdi, %rax
    jmp done        # Label usage

done:               # Another label
    ret
```

## Auto-generated Labels

Compilers typically use format: `.L#:` (following GCC convention)

```assembly
.L1:                # Auto-generated label
    addq $1, %rax
.L2:                # Another auto-generated label  
    ret
```

## Label Association

Labels are associated with the **next instruction** after them (ignoring whitespace).

---

# If-else Statements Notes

## Basic Strategy

Use **labels and jumps** to ensure only one branch executes.

## Key Principle

Jump targets almost always go **forward** in if-else statements.

## Example: C Code

```c
if (x < 3)          // x in %rax
    y += 2;         // y in %rbx  
else
    y = 10;
```

## Assembly Implementation (Version 1)

```assembly
cmpq $2, %rax       # Compare x with 2
jg .L2              # Jump if x > 2 (equivalent to x >= 3)
addq $2, %rbx       # if case: y += 2
jmp .L3             # Skip else case
.L2:
movq $10, %rbx      # else case: y = 10
.L3:
```

**Logic:**

- `x > 2` is equivalent to `x >= 3` for integers
- When `x >= 3` (condition false), jump to else case
- When `x < 3` (condition true), fall through to if case

## Assembly Implementation (Version 2)

```assembly
cmpq $3, %rax       # Compare x with 3
jl .L2              # Jump if x < 3  
movq $10, %rbx      # else case: y = 10
jmp .L3             # Skip if case
.L2:
addq $2, %rbx       # if case: y += 2
.L3:
```

## Quiz Example

**Complete assembly for:**

```c
if (x > 1)          // x in %rax
    y = 20;         // y in %rbx
else  
    y -= 5;
```

**Solution:**

```assembly
cmpq $1, %rax       # Compare x with 1
jle .L2             # Jump if x <= 1 (opposite of condition)
movq $20, %rbx      # if case: y = 20
jmp .L3             # Skip else case
.L2:
subq $5, %rbx       # else case: y -= 5
.L3:
```

---

# Loops Notes

## Key Differences from If-else

- **Backward jumps:** Must jump back to loop beginning
- **Timing:** When to evaluate the test condition (top vs bottom)
- **Efficiency:** Number of jump instructions needed

## Do-while Loop Structure

```assembly
loopTop:
    <body code>         # Execute body first
    <CC instr>          # Set condition codes
    j* loopTop          # Jump back if condition true
loopDone:
```

**Characteristics:**

- Body executes **at least once**
- Test at **bottom** of loop
- Most efficient (minimal jumps)

## While Loop Structure

### Version 1 (Simple Translation)

```assembly
loopTop:
    <CC instr>          # Test condition first
    j*' loopDone        # Jump out if condition false (opposite jump)
    <body code>         # Execute body
    jmp loopTop         # Unconditional jump back
loopDone:
```

### Version 2 (Compiler Optimized)

```assembly
    <CC instr>          # Initial test
    j*' loopDone        # Jump out if initially false
loopTop:
    <body code>         # Execute body
    <CC instr>          # Test again
    j* loopTop          # Jump back if condition true
loopDone:
```

**Why Version 2?**

- More efficient during execution
- Fewer jumps in the common case
- Compilers prefer this form

## For Loop Structure

```c
for (init; test; update) {
    body;
}
```

**Equivalent to:**

```c
init;
while (test) {
    body;
    update;
}
```

## Quiz Examples

### Question 1: Identify Loop Type

```assembly
1  movl $0, %rsi         # i = 0
2  cmpl $9, %rsi         # Compare i with 9  
3  jg .L2                # Jump if i > 9
.L3:
4  addq $10, %rdi        # Body code
5  addl $1, %rsi         # i++ (update)
6  cmpl $9, %rsi         # Compare i with 9
7  jle .L3               # Jump back if i <= 9
.L2:
```

**Answer:** Version 2 (has initial test before loop)

### Question 2: Identify Update Statement

**Answer:** Line 5 (`addl $1, %rsi`)

- Comes right before condition check
- Updates the loop variable (`%rsi`)

## Common Loop Patterns

### Counter Loop

```assembly
movq $0, %rcx           # counter = 0
jmp test
loop:
    # body code
    addq $1, %rcx       # counter++
test:
    cmpq $10, %rcx      # compare with limit
    jl loop             # continue if counter < 10
```

### Array Traversal

```assembly
movq $0, %rsi           # index = 0
jmp test
loop:
    movq (%rdi,%rsi,8), %rax    # load array[index]
    # process array[index]
    addq $1, %rsi       # index++
test:
    cmpq %rdx, %rsi     # compare index with array_size
    jl loop             # continue if index < size
```