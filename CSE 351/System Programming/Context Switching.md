# Context Switching

The mechanism by which the OS switches execution between [[Processes|processes]].

**Related:** [[Processes]], [[Exceptions]], [[x86-64 Registers]]

---

## Context Switching Process

### 1. Save Current State
- Save all CPU registers to memory
- Save program counter ([[Program Counter|%rip]])
- Save stack pointer and process state

### 2. Schedule Next Process
- OS scheduler selects next process
- May consider priority, waiting time, etc.

### 3. Restore New Process State
- Load saved registers from memory
- Switch to new process's address space
- Update memory management unit (MMU)

---

## Visualization

```
Timeline: Process A → Context Switch → Process B → Context Switch → Process A

Process A: [Execute] [SAVE STATE] [Wait...] [RESTORE STATE] [Execute]
Process B: [Wait...] [RESTORE STATE] [Execute] [SAVE STATE] [Wait...]

CPU:       [A code] [OS switch] [B code] [OS switch] [A code]
```

---

## Performance Considerations

- **Overhead:** Context switches consume CPU cycles
- **Frequency:** Balance responsiveness vs efficiency
- **Hardware support:** Modern CPUs have acceleration features

---

## What Gets Saved

| Component | Description |
|-----------|-------------|
| General registers | `%rax`, `%rbx`, etc. |
| Program counter | `%rip` |
| Stack pointer | `%rsp` |
| Condition codes | `EFLAGS` |
| Memory mappings | Page table pointer |

**Related:** [[Register Saving Conventions]], [[Virtual Memory]]
