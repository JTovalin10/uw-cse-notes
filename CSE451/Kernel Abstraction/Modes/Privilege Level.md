# CSE451: Privilege Level

x86 hardware implements **privilege levels** as concentric rings, where Ring 0 has full access and Ring 3 is most restricted. Most modern OSes use only Ring 0 (kernel) and Ring 3 (user).

## Levels
- [[Ring 0]] — kernel mode; full access to everything
- [[Ring 3]] — user mode; limited access
- [[Dual-Mode Restrictions]] — the three hardware mechanisms that enforce the boundary

## Related
- [[Hardware Modes]] — the broader concept of kernel vs. user mode
- [[Privileged Instructions]] — instructions only available at Ring 0
- [[General Protection Fault (GPF)]] — exception raised when Ring 3 violates restrictions
- [[Code Segment]] — the CS register encodes the current privilege level
