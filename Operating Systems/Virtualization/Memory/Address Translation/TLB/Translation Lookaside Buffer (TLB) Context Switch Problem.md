# The Context Switch Problem

When the OS switches from Process A to Process B, the TLB contains translations for Process A. If Process B tries to use those, it will access Process A's memory (security breach!).

The OS must do one of two things during a switch:

1. **Flush the TLB:** Empty the entire cache. (Safe, but Process B starts with 0 hits and runs slowly at first).

2. **ASID (Address Space ID):** Add a tag to every TLB entry identifying _who_ owns it (e.g., "This translation belongs to PID 10"). This allows entries from multiple processes to coexist in the TLB safely.
