# CSE351: Exceptions

An **exception** is the transfer of execution/control to the OS **kernel** in response to some event.

---

## Exception Handling Process

1. **Event occurs** (interrupt, trap, fault, etc.)
2. **Control transfers** to kernel
3. **Handler executes** (kernel code)
4. **Handler completes** with one of three outcomes

---

## Handler Outcomes

| Outcome | When Used |
|:---|:---|
| Re-execute current instruction | Recoverable faults (e.g., page fault) |
| Execute next instruction | Successful traps, interrupts |
| Abort the process | Unrecoverable errors |

---

## Types of Exceptions

### Asynchronous Exceptions (Interrupts)

- **Cause:** Events external to the processor
- **Examples:** Timer interrupts, I/O completion, network packets
- **Handler:** Always returns to the **next** instruction
- Independent of the currently executing instruction

### Synchronous Exceptions

Caused by executing an instruction.

#### Traps
- **Nature:** Intentional transfer to OS
- **Purpose:** Access privileged resources ([[CSE351/System Programming/System Calls|System Calls]])
- **Examples:** `open()`, `malloc()`, `read()`
- **Handler:** Returns to **next** instruction

#### Faults
- **Nature:** Unintentional but possibly recoverable
- **Examples:** Division by zero, segfault, [[CSE351/Memory Management/Page Faults|page fault]]
- **Handler:** Returns to **current** instruction (if recoverable) or aborts

#### Aborts
- **Nature:** Unintentional and unrecoverable
- **Examples:** Hardware malfunction
- **Handler:** Always aborts the process

---

## Example: File Operations

```c
int fd = open("file.txt", O_RDONLY);  // Trap exception
```

- **Type:** Trap (intentional system call)
- **Handler outcome:** Execute next instruction

---

## Related
- [[CSE351/System Programming/Processes|Processes]]
- [[CSE351/System Programming/Context Switching|Context Switching]]
- [[CSE351/System Programming/System Calls|System Calls]]
- [[CSE351/Memory Management/Page Faults|Page Faults]]
- [[CSE451/Kernel Abstraction/Exceptions/Exception|Exceptions (CSE451)]]
- [[CSE451/Kernel Abstraction/Interrupts/Interrupts|Interrupts (CSE451)]]
- [[CSE451/Kernel Abstraction/Traps/Traps|Traps (CSE451)]]
