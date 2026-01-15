# x86-64 Registers

**Related:** [[x86-64 Instruction Format]], [[Calling Conventions]], [[Register Saving Conventions]]

---

## Register Names and Sizes

| 64-bit | 32-bit | 16-bit | 8-bit |
|--------|--------|--------|-------|
| %rax | %eax | %ax | %al |
| %rbx | %ebx | %bx | %bl |
| %rcx | %ecx | %cx | %cl |
| %rdx | %edx | %dx | %dl |
| %rsi | %esi | %si | %sil |
| %rdi | %edi | %di | %dil |
| %rbp | %ebp | %bp | %bpl |
| %rsp | %esp | %sp | %spl |
| %r8 | %r8d | %r8w | %r8b |
| %r9 | %r9d | %r9w | %r9b |
| %r10 | %r10d | %r10w | %r10b |
| %r11 | %r11d | %r11w | %r11b |
| %r12 | %r12d | %r12w | %r12b |
| %r13 | %r13d | %r13w | %r13b |
| %r14 | %r14d | %r14w | %r14b |
| %r15 | %r15d | %r15w | %r15b |

---

## Key Points

- Smaller register names refer to **least significant bytes**
  - `%ax` = lower 16 bits of `%rax`
  - `%al` = lower 8 bits of `%rax`

- **32-bit operations automatically zero the upper 32 bits**
```assembly
movl $100, %eax       # Sets %rax = 0x0000000000000064
```

---

## Special Registers

| Register | Purpose |
|----------|---------|
| `%rsp` | [[Stack Pointer]] |
| `%rbp` | Frame pointer (optional) |
| `%rip` | [[Program Counter]] |
| `%rax` | Return value |

**Related:** [[Calling Conventions]], [[Stack Frames]]
