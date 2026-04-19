# CSE451: Polling

**Polling** is the act of waiting for a device to finish I/O by having the CPU continuously check whether the device has completed its task, instead of allowing the device to notify the CPU when done.

The CPU keeps checking if the device/process has finished rather than allowing the device to tell the CPU that it has finished the task.

This is inefficient because the CPU burns cycles repeatedly checking a status register rather than doing useful work.

## The Fix
[[Interrupts]] solve the polling problem by letting the device interrupt the CPU only when the operation completes.

## Related
- [[Interrupts]] — the alternative to polling
- [[Interrupt Handler]] — the code that runs when the device signals completion
- [[Blocking IO Problem]] — related issue with user threads and blocking I/O
