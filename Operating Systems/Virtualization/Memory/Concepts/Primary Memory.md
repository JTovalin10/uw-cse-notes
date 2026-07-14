# CSE451: Primary Memory

**Primary Memory** is the directly accessed storage for the CPU (i.e., RAM).

- Programs must be resident in primary memory to execute — the CPU can only fetch and execute instructions that are currently loaded into RAM, unlike data on disk which must first be brought into memory before it can be used.
- Memory access is fast, since primary memory is directly addressable by the CPU without going through slower I/O paths like disk.
- However, primary memory doesn't survive power failures — it is volatile, so any data not written back to persistent storage is lost if power is interrupted, unlike disk-based storage.

## Related
- [[Operating Systems/Virtualization/Memory/Concepts/Memory|Memory]]
- [[Operating Systems/Virtualization/Memory/Concepts/Swapping|Swapping]]
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]]
