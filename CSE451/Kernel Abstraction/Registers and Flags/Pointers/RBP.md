**Register Base Pointer** (64-bit)

# What it does
- 64-bit version of [[EBP]]
- Points to the **base of the current stack frame**
- Provides stable reference point for accessing local variables and parameters

# Key points
- Often omitted in optimized 64-bit code (frame pointer omission)
- When used, set up at function entry: `push rbp; mov rbp, rsp`
- Restored at function exit: `leave` or `mov rsp, rbp; pop rbp`

# Stack frame layout (when RBP is used)
```
[RBP + 16]  → second argument (if passed on stack)
[RBP + 8]   → return address
[RBP]       → saved RBP (previous frame)
[RBP - 8]   → first local variable
```

# Related
- [[EBP]] - 32-bit version
- [[RSP]] - 64-bit stack pointer
