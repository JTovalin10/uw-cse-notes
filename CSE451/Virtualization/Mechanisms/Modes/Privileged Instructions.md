# CSE451: Privileged Instructions

**Privileged instructions** are CPU instructions that can only be executed in kernel mode (Ring 0). If a user program attempts to execute one, the CPU raises an [[Exception]] and the OS takes control.

## What the OS Does When a User Program Attempts a Privileged Instruction
1. Halt the current instruction
2. Disable interrupts
3. Change mode to kernel
4. Take corrective action (usually terminate the process)

## Examples of Privileged Instructions
- `cli` / `sti` — disable/enable interrupts
- `hlt` — halt the CPU
- Loading page tables or segment descriptor tables (LGDT, LIDT)
- Direct I/O port access (IN, OUT)

Note: **load and store** instructions are not privileged by themselves, but can be restricted by memory protection (page tables and base/bound registers).

## Related
- [[Privilege Level]] — the Ring 0/3 system that defines what is privileged
- [[Dual-Mode Restrictions]] — privileged instructions are one of three restrictions
- [[General Protection Fault (GPF)]] — the exception raised for privilege violations
- [[Kernel Mode]] — the mode required to execute privileged instructions
