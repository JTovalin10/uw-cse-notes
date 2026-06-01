# CSE451: Hardware Modes

**Hardware modes** refer to the CPU's privilege levels that determine which instructions a program may execute and which memory it may access. The core question is: *who gets to control the hardware?*

## Control Options
- [[Application Control]] — pros and cons of letting applications directly access hardware
- [[OS Control]] — pros and cons of having the OS mediate all hardware access

## Mode Information
- [[Mode Storage]] — where the current mode is stored (EFLAGS register on x86)
- [[User Mode]] — limited privileges; cannot directly access hardware
- [[Kernel Mode]] — full hardware access; can execute any instruction

## Related
- [[Privilege Level]] — the Ring 0 / Ring 3 system
- [[Dual-Mode Restrictions]] — what user mode cannot do
- [[Mode Switch]] — how the CPU transitions between modes
- [[Privileged Instructions]] — the instructions only available in kernel mode
