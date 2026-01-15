# Processes

A **process** is an instance of a running program/executable.

**Related:** [[Exceptions]], [[Context Switching]], [[Fork-Exec Model]], [[Virtual Memory]]

---

## Key Process Abstractions

### 1. Logical Control Flow

- **Illusion:** Each process has exclusive CPU use
- **Reality:** CPU time shared among processes
- **Implementation:** [[Context Switching]]

### 2. Private Address Space

- **Illusion:** Each process has exclusive memory
- **Reality:** Physical memory shared and managed by OS
- **Implementation:** [[Virtual Memory]]

---

## Program vs. Process

```
Program: chrome.exe (executable file on disk)
    ↓
Process: Running instance with:
    - Logical control flow
    - Private address space
    - Process ID (PID)
    - Execution state
```

---

## Concurrency

Two processes run **concurrently** if their instruction executions overlap in time.

### Single CPU Concurrency

Achieved through:
- **Time slicing:** Rapidly switching between processes
- **Context switching:** Saving/restoring process state
- **Scheduling:** OS decides which process runs when

---

## Viewing Processes

| OS | Tool |
|----|------|
| Windows | Task Manager |
| macOS | Activity Monitor |
| Linux | `ps` command |

**Related:** [[Memory Layout]], [[Exceptions]]
