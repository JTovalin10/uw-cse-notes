**Register Stack Pointer** (64-bit)

# What it does
- 64-bit version of [[ESP]]
- Points to the **top of the stack** in x86-64 mode
- Automatically modified by `push` (decrements) and `pop` (increments)

# Key points
- In 64-bit mode, stack operations work with 8 bytes by default
- Must be 16-byte aligned before `call` instructions (AMD64 ABI requirement)
- Red zone: 128 bytes below RSP can be used without adjusting RSP (leaf functions)

# Related
- [[ESP]] - 32-bit version
- [[RBP]] - 64-bit base pointer
- [[Stack Pointer]]
