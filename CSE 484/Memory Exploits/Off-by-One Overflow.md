 
## What Is an Off-by-One Overflow?

An **off-by-one overflow** is a specific, subtle type of buffer overflow where a programming error causes a loop or a memory copy function to write exactly **one byte** past the end of an allocated buffer.

It's a classic "fencepost problem" often caused by using `<=` instead of `<` in a loop condition.

```c
// Vulnerable Code Example
char buffer[256];
for (int i = 0; i <= 256; i++) { // Oops! Should be i < 256
   buffer[i] = input[i];         // The 257th write goes out of bounds
   
```
## How the Attack Works: Stack Pivoting

The goal is to corrupt the **Saved Frame Pointer (SFP)** to gain control of the stack pointer later. This is called a **stack pivot**.

### 1. The Stack Layout

The SFP is stored on the stack right after the local buffer.

|High Memory Address ⬆️|Contents|Description|
|---|---|---|
||Return Address|Where to go after this function|
|`0xbfffef08`|**`0xbfffef58`**|**Saved Frame Pointer (SFP)**|
|`0xbfffef07`|`...`|Local Buffer `[255]`|
|`...`|`...`|...|
|`0xbfffee08`|`...`|Local Buffer `[0]`|
|Low Memory Address ⬇️|||

### 2. The One-Byte Overflow 💧

The attacker's single extra byte overwrites the **least significant byte (LSB)** of the SFP, causing it to point to a new location inside the attacker's buffer.

- Original SFP: `0xbfffef58`
    
- Attacker's overflow byte: `\x18`
    
- Corrupted SFP: `0xbfffef18`
    

### 3. The First Return (The Setup)

When the vulnerable function returns, it pops the corrupted SFP (`0xbfffef18`) into the `ebp` register. The program returns control to the parent function, but the `ebp` register is now pointing into the attacker's buffer.

### 4. The Second Return (The Pivot)

When the _parent_ function eventually finishes, it runs `leave`, which is equivalent to `mov esp, ebp`. Since `ebp` points into the attacker's buffer, the stack pointer (`esp`) is "pivoted" there.

### 5. Execution 🚀

The very next instruction is `ret`, which pops the top value from the now-pivoted stack and jumps to it. The attacker places a fake return address at this location, which points to their shellcode elsewhere in the buffer.

***

## The Goal: Hijack the Program's "To-Do" List

At its core, a computer's CPU has a special register called the **instruction pointer** (often called `EIP` or `RIP`). This register holds the memory address of the very next instruction the CPU is supposed to execute. The goal of code injection is to change the value in this register to point to the attacker's own malicious code.

A key place where a future instruction address is stored is the **stack**. When a function is called, the address it should _return to_ when it's done is saved on the stack. This is called the **return address**. An attacker's primary target is to find this saved return address on the stack and overwrite it.

---

## How the Attack Works

The attack involves three main phases: getting the malicious code into memory, finding the address to overwrite, and then using the format string bug to perform the overwrite.

### Step 1: Inject the Shellcode

First, the attacker needs to get their malicious code (the **shellcode**) into the program's memory. They might do this by providing it as input that gets stored in a buffer, or by placing it in an environment variable the program can access. The attacker takes note of the memory address where their shellcode now resides.

- **Result:** Malicious code is sitting at a known address, like `0xDEADBEEF`.
    

### Step 2: Craft the Malicious String

This is the core of the exploit. The attacker creates a special string to feed to the vulnerable `printf(user_input)` call. This string is carefully designed to do two things:

1. **Place the Target Address:** The string itself will contain the address they want to overwrite (the location of the saved return address).
    
2. **Contain the Write Gadget:** The string will use `%n` to perform the write and padding specifiers (like `%123x`) to control _what_ value gets written.
    

A conceptual payload might look like this: `[Address of Return Address] [Padding] %n`

### Step 3: Execute the `printf`

When the vulnerable `printf(payload)` line is executed, here’s what happens:

1. `printf` starts reading the attacker's string as its instructions.
    
2. It encounters the padding specifiers (e.g., `%500x`). It dutifully prints 500 characters to the screen. The internal character counter is now at 500.
    
3. It then encounters `%n`. The `%n` specifier needs an address to write to. `printf` looks for this address on the stack. The attacker has carefully crafted the string so that the address it pulls from the stack is the **[Address of Return Address]** they placed in the string earlier.
    
4. `%n` then performs its action: it writes the number of characters printed so far (500) into that target address.
    

By repeatedly using small, calculated writes, the attacker can overwrite the entire multi-byte return address, byte by byte, until it equals the address of their shellcode (`0xDEADBEEF`).

### Step 4: Hijack Complete

When the current function finishes, it executes its `return` instruction. The program looks at the stack to find its return address, but it finds the attacker's address instead! The instruction pointer is loaded with `0xDEADBEEF`, and the CPU begins executing the malicious shellcode. Game over. 💀

---

## Analogy: Tricking a Mail Sorter

Think of `printf` as an automated mail sorter and the stack as its conveyor belt of instructions.

- Normally, you give it a template (`"%s"`) and the data (`user_input`). It safely puts the data in the template.
    
- With a format string bug, you let an attacker write the instructions for the sorter.
    
- The attacker writes a note that says: "Take the 200th package on the conveyor belt (the return address), open it, and replace its contents with the number of letters we have sorted today (`%n`)."
    

By giving the attacker control of the instructions, you allow them to rewrite the program's own delivery addresses.

![profile picture](https://lh3.googleusercontent.com/a/ACg8ocKXJfpYmXtl1jivDDX92wib2emq4RSkdRfyrPekCJB6iALXHA=s64-c-mo)