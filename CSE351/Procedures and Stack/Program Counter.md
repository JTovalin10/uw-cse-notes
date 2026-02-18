# Program Counter (`%rip`)

The **program counter** is a special register holding the address of the **next instruction** to execute.

**Related:** [[x86-64 Registers]], [[Jump Instructions]], [[Switch Statements]]

---

## Behavior

- **Normal execution:** Advances to consecutive instructions
- **Jump instructions:** Can alter `%rip` to jump elsewhere
- **Call instruction:** Pushes `%rip + instruction_size`, then jumps
- **Ret instruction:** Pops address into `%rip`

---

## With Jump Instructions

```assembly
jmp label           # %rip = address of label
je label            # %rip = address of label (if ZF=1)
```

---

## With Call/Ret

```assembly
call func           # Push %rip (return addr), jump to func
ret                 # Pop into %rip (return to caller)
```

---

## Indirect Jumps

```assembly
jmp *%rax           # %rip = value in %rax
jmp *(%rax)         # %rip = value at address in %rax
```

Used for [[Switch Statements]] with jump tables.

**Related:** [[Calling Conventions]], [[Labels]]
