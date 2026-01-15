# Loops

Loops use [[Labels]] and [[Jump Instructions]] with **backward jumps** to repeat code.

**Related:** [[Conditionals]], [[Jump Instructions]], [[Condition Codes]]

---

## Key Differences from If-Else

- **Backward jumps:** Must jump back to loop beginning
- **Timing:** When to evaluate test condition
- **Efficiency:** Number of jump instructions

---

## Do-While Loop

```assembly
loopTop:
    <body code>         # Execute body first
    <CC instr>          # Set condition codes
    j* loopTop          # Jump back if condition true
loopDone:
```

**Characteristics:**
- Body executes **at least once**
- Test at **bottom**
- Most efficient

---

## While Loop (Version 1)

```assembly
loopTop:
    <CC instr>          # Test first
    j*' loopDone        # Jump out if false (opposite jump)
    <body code>
    jmp loopTop         # Jump back
loopDone:
```

---

## While Loop (Version 2 - Optimized)

```assembly
    <CC instr>          # Initial test
    j*' loopDone        # Skip if initially false
loopTop:
    <body code>
    <CC instr>          # Test again
    j* loopTop          # Jump back if true
loopDone:
```

**Why Version 2?** Fewer jumps in common case.

---

## For Loop

```c
for (init; test; update) { body; }
```

Equivalent to:
```c
init;
while (test) { body; update; }
```

---

## Example: Counter Loop

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

---

## Example: Array Traversal

```assembly
movq $0, %rsi           # index = 0
jmp test
loop:
    movq (%rdi,%rsi,8), %rax    # load array[index]
    # process element
    addq $1, %rsi       # index++
test:
    cmpq %rdx, %rsi     # compare index with size
    jl loop             # continue if index < size
```

**Related:** [[Arrays]], [[Pointer Arithmetic]]
