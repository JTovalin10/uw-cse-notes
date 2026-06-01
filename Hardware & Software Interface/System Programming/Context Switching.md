# CSE351: Context Switching

**Context switching** is the mechanism by which the OS saves the state of one [[Processes|process]] and restores the state of another, allowing multiple processes to share a single CPU. It is the fundamental mechanism behind the illusion of concurrent execution.

---

## Context Switching Process

### (1) Save Current State

The OS saves everything needed to resume the current process later:
- All CPU registers (`%rax`, `%rbx`, etc.)
- Program counter (`%rip`) — where the process was executing
- Stack pointer (`%rsp`) and process-visible state
- `EFLAGS` register (condition codes)

### (2) Schedule the Next Process

The OS scheduler selects the next process to run, considering:
- Process priority
- Time waiting in the ready queue
- Scheduling policy (round-robin, priority-based, etc.)

### (3) Restore New Process State

The OS restores the selected process's saved context:
- Load saved registers from memory.
- Switch to the new process's virtual address space (update the MMU's page table pointer — `CR3` on x86-64).
- Resume execution at the saved `%rip`.

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

- **Overhead:** Context switches consume CPU cycles — the OS must save and restore state, and the cache and TLB may be "cold" for the new process.
- **Frequency:** More frequent switches improve responsiveness but increase overhead.
- **Hardware support:** Modern CPUs provide mechanisms (like ASIDs in the TLB) to reduce the cost of switching address spaces without flushing the entire TLB.

---

## What Gets Saved

| Component | Description |
|:---|:---|
| General registers | `%rax`, `%rbx`, `%rcx`, `%rdx`, `%rsi`, `%rdi`, `%r8`–`%r15` |
| Program counter | `%rip` — where to resume |
| Stack pointer | `%rsp` — top of the process's stack |
| Condition codes | `EFLAGS` register |
| Memory mappings | Page table pointer (`CR3`) to switch address spaces |

---

```mermaid
sequenceDiagram
    participant A as Process A
    participant OS as OS Scheduler
    participant B as Process B
    A->>OS: Timer interrupt (quantum expired)
    OS->>OS: Save A's registers, %rip, %rsp, EFLAGS
    OS->>OS: Select Process B
    OS->>OS: Restore B's registers, %rip, %rsp, EFLAGS; update CR3
    OS->>B: Resume B
    B->>OS: Timer interrupt
    OS->>OS: Save B's state; restore A's state
    OS->>A: Resume A
```

---

## Related

- [[Processes|Processes]]
- [[Exceptions|Exceptions]]
- [[x86-64 Registers|x86-64 Registers]]
- [[Register Saving Conventions|Register Saving Conventions]]
- [[CPU State#Context Switch|Context Switch (CSE451)]]
- [[Operating Systems/Virtualization/Memory/Virtual Memory|Virtual Memory (CSE451)]]

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|:---|:---|
| Context switch | Context switch; task switch; process switch |
| Saving registers on switch | Context save; register file save |
| Switching page table pointer | Address space switch; CR3 update; TLB flush (or ASID-tagged TLB) |
| OS scheduler selecting next process | Scheduling decision; dispatch |
| Hardware support for switching | ASID (Address Space Identifier); VMID (Virtualization) |
