# Dual-Mode Restrictions

## [[Privileged Instructions]]
- available to kernel but not user code

## Limits on memory accesses
- to prevent user code from overwriting the kernel
- to prevent user from reading data it shouldn't

## Timer
- to regain control from a user program in a loop

**Provides a safe way to switch from user mode to kernel mode and vice versa**
