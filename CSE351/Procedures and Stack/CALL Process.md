# CALL Process (Building an Executable)

**CALL** = **C**ompiling → **A**ssembling → **L**inking → **L**oading

**Related:** [[CSE351/Procedures and Stack/Memory Layout]], [[x86-64 Instruction Format]]

---

## Overview

| Phase | Input | Output |
|-------|-------|--------|
| Compiling | `.c` source | `.s` assembly |
| Assembling | `.s` assembly | `.o` object file |
| Linking | `.o` files | executable |
| Loading | executable | running process |

---

## Compiling

### Steps
1. **Preprocessor:** Handle `#include`, `#define`
2. **Compiler:** Translate C to assembly

### Optimization Flags

| Flag | Purpose |
|------|---------|
| `-O0` | No optimization (debugging) |
| `-O1`, `-O2`, `-O3` | Performance optimization |
| `-Os` | Size optimization |
| `-Og` | Debug-friendly optimization |

```bash
gcc -S source.c         # Stop after compiling
gcc -O2 -S source.c     # With optimization
```

---

## Assembling

Converts assembly to object code.

### Object File Contents
- **Object code:** Incomplete machine code
- **Symbol table:** Globally accessible labels
- **Relocation table:** Addresses needing patching

### Why "Incomplete"?
- Don't know final addresses yet
- Multiple files only know about themselves

---

## Linking

Stitches object files and libraries into final executable.

### Process
1. Combine code, data, literal sections
2. Resolve references (relocation table ↔ symbol table)
3. Assign final addresses

### Symbol Resolution
- **Relocation table:** "I need address of function X"
- **Symbol table:** "Function X is at address Y"
- **Linker:** Updates all references

### Even Single Files Need Linking
- Standard library functions (`printf`, `malloc`)
- System call interfaces
- Runtime startup code

---

## Loading

OS converts executable to running process.

### OS Tasks
- Initialize code, data, stack, heap sections
- Set initial register values
- Create process control block
- Jump to program entry point

```
┌─────────────────┐
│     Stack       │ ← Initialized by OS
├─────────────────┤
│      Heap       │ ← Empty initially
├─────────────────┤
│ Static/Global   │ ← From executable
├─────────────────┤
│   Literals      │ ← From executable
├─────────────────┤
│     Code        │ ← From executable
└─────────────────┘
```

---

## Disassembling

Reverse engineering: binary → assembly

```
0000000000401126 <main>:
  401126: 48 83 ec 08    sub    $0x8,%rsp
  40112a: bf 10 20 40 00 mov    $0x402010,%edi
```

| Column | Meaning |
|--------|---------|
| Left | Memory addresses |
| Middle | Machine code bytes |
| Right | Assembly instructions |

**Related:** [[CSE451/Virtual Memory/Virtual Memory]], [[CSE351/Procedures and Stack/Memory Layout]]
