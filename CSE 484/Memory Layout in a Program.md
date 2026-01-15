## Memory Regions

### **Text Region**

- Contains the executable code of the program
- Typically read-only to prevent accidental modification
- Located at the lowest memory addresses

### **Heap**

- Stores dynamically allocated data
- Managed by `malloc()`, `free()`, `new`, `delete`, etc.
- Grows upward (toward higher addresses)
- Allocation and deallocation happen at runtime

### **Stack**

- Contains local variables and function call information
- Stores function return addresses and parameters
- Grows downward (toward lower addresses)
- Automatically managed - grows and shrinks as functions are called and return

## Memory Layout Diagram

```
Low Addresses                                    High Addresses
0x00000000                                       0xFFFFFFFF
    |                                                 |
    v                                                 v
┌─────────────┐
│             │
│    Text     │  ← Executable code (read-only) [low-addresses]
│   Region    │
│             │
├─────────────┤
│             │
│    Heap     │  ← Dynamically allocated memory
│      ↓      │     (grows upward →)
│      ↓      │
│      ↓      │
│             │
│   (free)    │
│             │
│      ↑      │
│      ↑      │
│    Stack    │  ← Local variables, return addresses
│             │     (grows downward ←) [high addresses]
│             │
└─────────────┘
```

### Key Points

- **Text and Heap grow from bottom to top** (low → high addresses)
- **Stack grows from top to bottom** (high → low addresses)
- The gap between heap and stack is free memory
- Stack overflow occurs when stack and heap collide

## Adding a New Frame to the Stack

When a function is invoked, a new **stack frame** (also called activation record) is pushed onto the stack. Each stack frame contains:

- **Local variables** declared within the function
- **Function parameters** passed to the function
- **Return address** - where to resume execution after the function returns
- **Saved registers** - previous state that needs to be restored
- **Frame pointer** - reference to the previous stack frame

When the function returns, its stack frame is popped off the stack, and execution continues at the saved return address.

### Stack Frame Diagram

```
High Addresses (Top of Stack)
    │
    v

┌──────────────────────┐  ← Stack Pointer (SP) [Current top]
│                      │
│   main() frame       │
│   - local vars       │
│   - return address   │
│                      │
├──────────────────────┤  ← Frame Pointer (FP)
│                      │
│   funcA() frame      │
│   - parameters       │
│   - local vars       │
│   - return address   │
│                      │
├──────────────────────┤
│                      │
│   funcB() frame      │  ← Currently executing
│   - parameters       │     (most recent call)
│   - local vars       │
│   - return address   │
│                      │
└──────────────────────┘  ← Stack grows downward

    ↓
    │
Low Addresses
```

### Example: Function Call Sequence

```
1. main() calls funcA()
   Stack: [main]

2. funcA() calls funcB()
   Stack: [main] → [funcA] → [funcB]

3. funcB() returns
   Stack: [main] → [funcA]

4. funcA() returns
   Stack: [main]
```

### What Happens During a Function Call

1. **Arguments are pushed** onto the stack (or passed via registers)
2. **Return address is saved** - where to continue after the function completes
3. **Stack pointer moves down** to allocate space for the new frame
4. **Frame pointer is updated** to reference the new frame
5. **Local variables are allocated** within the frame
6. Function executes
7. **Frame is popped** when function returns
8. **Control returns** to the saved return address