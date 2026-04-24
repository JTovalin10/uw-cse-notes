# CSE351: Context Switching

The mechanism by which the OS switches execution between [[CSE351/System Programming/Processes|processes]].

---

## Context Switching Process

### 1. Save Current State
- Save all CPU registers to memory
- Save program counter (`%rip`)
- Save stack pointer and process state

### 2. Schedule Next Process
- OS scheduler selects the next process
- May consider priority, waiting time, etc.

### 3. Restore New Process State
- Load saved registers from memory
- Switch to the new process's address space
- Update the memory management unit (MMU)

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
- **Frequency:** Balance responsiveness vs. efficiency
- **Hardware support:** Modern CPUs have acceleration features

---

## What Gets Saved

| Component | Description |
|:---|:---|
| General registers | `%rax`, `%rbx`, etc. |
| Program counter | `%rip` |
| Stack pointer | `%rsp` |
| Condition codes | `EFLAGS` |
| Memory mappings | Page table pointer |

---

## Related
- [[CSE351/System Programming/Processes|Processes]]
- [[CSE351/System Programming/Exceptions|Exceptions]]
- [[CSE351/x86-64 Assembly/x86-64 Registers|x86-64 Registers]]
- [[CSE351/Procedures and Stack/Register Saving Conventions|Register Saving Conventions]]
- [[CSE451/Processes/CPUState/Context Switch|Context Switch (CSE451)]]
- [[CSE451/Virtual Memory/Virtual Memory|Virtual Memory (CSE451)]]
