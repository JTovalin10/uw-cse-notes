# CSE451: Source of Interrupts

Interrupts can originate from several distinct sources:

- **Timer**: periodic interrupts fired at a fixed interval, giving the OS scheduler a chance to regain control from a running process and switch to another one (see [[Dual-Mode Restrictions]] — the timer is one of the three hardware mechanisms enforcing dual-mode operation)
- **I/O devices**: keyboard, disk, network card, and other peripherals signal the CPU when an operation completes, replacing the need for [[Polling]]
- **Software**: system calls (`int 0x80`, `syscall`) are software-triggered traps that a program executes intentionally to request OS services — see [[System Call]]
- **Exceptions**: page fault, divide by zero, [[General Protection Fault (GPF)]] — hardware-detected errors during the execution of an instruction, see [[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception]]

## Related
- [[Interrupts|Interrupts]] — the parent concept
- [[Interrupt Types Summary]] — how these sources map onto the hardware/software/exception categories
- [[Polling]] — the inefficient alternative that device interrupts replace
- [[System Call]] — the software-triggered source of interrupts
- [[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception]] — the error-triggered source of interrupts

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Timer Interrupt | Timer interrupt / clock interrupt |
| I/O Device Interrupt | Hardware interrupt / IRQ |
