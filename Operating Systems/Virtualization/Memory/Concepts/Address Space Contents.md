# CSE451: What Does an Address Space Include

A process's **address space** is made up of several distinct regions, each serving a different purpose in supporting program execution.

- **Stack**
    - Holds return addresses and local variables, which is essential for function calls: every time a function is called, a new **stack frame** is pushed containing its local variables and the return address to resume the caller once the function completes.
- **Heap**
    - Holds dynamic memory allocated at runtime via `malloc()`/`new` — memory whose size and lifetime aren't known until the program is actually running, unlike the fixed-size stack frames used for function calls.
- **Static Data**
    - Holds initialized variables — memory that is set aside for the entire lifetime of the program rather than being allocated and freed dynamically.
- **Code**
    - Holds the static instructions of the program itself — the actual machine instructions the CPU fetches and executes, typically marked read-only and executable so that a running program cannot accidentally (or maliciously) modify its own instructions.

## Related
- [[Operating Systems/Virtualization/Memory/Concepts/Memory|Memory]]
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]]
- [[Operating Systems/Virtualization/Memory/Concepts/Memory Management Information|Memory Management Information]]
