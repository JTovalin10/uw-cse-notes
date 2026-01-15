### What is a Buffer?

A **buffer** is a pre-defined, sequential area of computer memory (usually in the stack or heap) used to temporarily hold data while it's being moved from one place to another.

---

### How Does a Buffer Overflow Attack Happen? 💥

The vulnerability occurs when a program attempts to write more data into a buffer than it was originally allocated to hold.

1. A function has a pre-allocated buffer of a fixed size (e.g., 128 bytes).
    
2. The function takes some user input and writes it into the buffer.
    
3. Crucially, the developer **forgets to check if the input's size is smaller than the buffer's size**.
    

When the input data is too large, it "overflows" the buffer's boundary and starts overwriting adjacent memory locations. This can lead to two main outcomes:

- **Program Crash:** The overflow corrupts essential data that the program needs to function, such as other variables or control-flow information, causing it to crash (e.g., with a segmentation fault).
    
- **Execution Hijacking:** An attacker can carefully craft the oversized input to intentionally overwrite critical control-flow data, like a function's return address, to seize control of the program's execution.
    

---

### How It Works: The Stack Overflow

The most classic example is a **stack-based buffer overflow**. To understand it, you need to know what the **call stack** looks like for a function.

#### The Stack Frame

When a function is called, it gets its own section on the stack called a **stack frame**. It's typically organized like this (memory addresses grow downwards):

|High Memory Address ⬆️|
|---|
|Function Arguments|
|**Return Address**|
|Old Frame Pointer (EBP)|
|**Local Buffer**|
|Other Local Variables|
|Low Memory Address ⬇️|

The most important parts for an attack are:

- **Local Buffer:** The memory space where the function stores its local data.
    
- **Return Address:** The memory address of the instruction the CPU should execute _after_ the current function finishes.
    

#### The Attack

An attacker provides input that is much larger than the `Local Buffer`. The data fills the buffer and continues writing "up" the stack, overwriting everything in its path, including the **Return Address**.

The attacker crafts a malicious payload that consists of:

1. **Padding:** Junk data to fill the buffer.
    
2. **New Return Address:** A specific memory address that replaces the original one. This address points to the location of the attacker's malicious code.
    
3. **Shellcode:** The actual malicious code (e.g., code to open a command shell: `/bin/sh`). This shellcode is also part of the input and is now located in memory (often in the buffer itself).
    
4. **NOP Sled (Optional but common):** A long series of "No-Operation" (`NOP`) instructions placed before the shellcode. This acts as a "landing strip." If the new return address is slightly off, as long as it points somewhere in the NOP sled, the CPU will slide down the NOPs until it hits and executes the shellcode.
    

When the function finishes, instead of returning to the legitimate calling code, it reads the attacker's fake return address and **jumps to the shellcode**, giving the attacker control.