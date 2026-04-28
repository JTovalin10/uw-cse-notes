# CSE451: Exception

An **exception** is a hardware-initiated event that causes a transfer of control from a user program to the kernel. An exception differs from [[Interrupts]] and [[Traps]] in that it is the hardware's way of saying *"I cannot continue executing this user program safely; the OS needs to take over."*

Exceptions are triggered by unexpected or erroneous program behavior. The kernel saves program state, handles the exception, and may be able to correct and restart the offending instruction.

## Examples
- Divide by zero (or arithmetic overflow)
- Segmentation fault (segfault)
- Illegal instruction
- Load/store from a protected memory location

## How the OS Responds
See [[Dealing with Exceptions]] for the OS's options when an exception occurs.

## Related
- [[Interrupts]] — externally triggered; exceptions are internally triggered
- [[Traps]] — software-triggered; exceptions are hardware-triggered
- [[General Protection Fault (GPF)]] — a specific CPU exception for privilege violations
- [[Dealing with Exceptions]] — what the OS can do in response
- [[CSE351/System Programming/Exceptions]] — exceptions at the systems programming level
