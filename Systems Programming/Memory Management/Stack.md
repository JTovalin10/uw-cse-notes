# CSE333: Stack

The **Stack** is used to store data associated with function calls and local variables. It is a Last-In, First-Out (LIFO) structure managed automatically by the CPU and compiler via calling conventions.

## The Function Prologue

When a function is called, the CPU automatically handles the control flow. Conceptually, you can think of the **Frame Pointer (`%rbp`)** as a hidden parameter passed to every function to establish the new frame.

In x86-64 assembly, every function starts with a "prologue" that sets up the stack frame pointer:

```nasm
push %rbp        ; Save the CALLER's frame pointer on the stack
mov  %rsp, %rbp  ; Set the CURRENT frame pointer to the top of the stack
```

This is why, even for a function like `void foo()`, the stack always contains the saved `%rbp` of the caller.

## Stack Memory Layout

In the x86-64 architecture, the stack grows **downward** from high memory addresses toward low memory addresses.

```text
High Addresses
+-----------------------+ <--- Bottom of stack (start)
|   Initial Caller      |
+-----------------------+
|   Arguments (7, 8...) |
+-----------------------+
|   Return Address      |  (Where to return after function)
+-----------------------+
|   Saved %rbp (base)   |  (Frame pointer of caller)
+-----------------------+ <--- %rbp (current frame pointer)
|   Saved Registers     |  (Callee-saved registers)
+-----------------------+
|   Local Variables     |
|   (e.g., int arr[10]) |
+-----------------------+ <--- %rsp (current stack pointer)
|          |            |
|          v            |  (Stack grows DOWNWARDS)
|                       |
Low Addresses
```

## Stack Frames

A **Stack Frame** (or procedure activation record) is the block of memory reserved for a single function call. Even if a function has no parameters or local variables, a frame is typically created to manage control flow.

- **Return Address**: The address of the next instruction in the calling function, so execution can resume there after the called function returns.
- **Saved `%rbp` (Frame Pointer)**: A pointer to the base of the *previous* stack frame. This creates a linked list of frames on the stack, allowing tools like `gdb` to "walk the stack" during debugging.
- **Saved Registers**: Values of callee-saved registers that must be preserved across function calls.

## Automatic Management

Memory on the stack is allocated and freed automatically via **calling conventions**.

- **Allocation**: The stack pointer (`%rsp`) is decremented to make room for a new frame.
- **Deallocation**: When a function returns, the stack pointer is incremented back, effectively popping the frame. The bytes are not zeroed — they remain as "dead" data until overwritten by the next function call.
- **Lifetime**: Local variables only exist while their function is active. **Never return a pointer to a local variable**, as it will point to a "dangling" location in a frame that has been reclaimed.

## Related

- [[C Memory Model|C Memory Model]]
- [[Systems Programming/Memory Management/Heap Management|Heap Management]]
- [[Systems Programming/C Fundamentals/Arrays|Arrays]]
- [[Introduction to C|Introduction to C]]
- [[Stack Frames|CSE351: Stack Frames]]
- [[Stack Pointer|CSE351: Stack Pointer]]

## Industry Standard Terms

- **Stack frame** — Also called "activation record" or "call frame"; the data structure holding a function's execution context
- **Frame pointer (`%rbp`)** — A stable base address for a frame; some compilers omit it with `-fomit-frame-pointer` for performance, using `%rsp`-relative addressing instead
- **Calling convention** — The agreed-upon protocol (e.g., System V AMD64 ABI on Linux) for how arguments are passed, return values delivered, and registers saved across function calls
