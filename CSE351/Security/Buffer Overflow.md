# CSE351: Buffer Overflow

---

## Core Concepts

### Buffer
A region of memory (usually an array) used to temporarily store data.

### Buffer Overflow
Writing data past the end of a buffer, overwriting adjacent memory locations.

- Possible in C because there is **no automatic bounds checking**
- Outcomes range from innocuous to crashes to malicious exploitation

---

## Stack Smashing

A specific type of buffer overflow targeting **local arrays on the stack**.

### Memory Layout Behavior
- Array elements: increasing address order (`&a[i+1] > &a[i]`)
- Stack growth: **downward** (toward lower addresses)
- Overflow direction: toward **higher** addresses
- Eventually overwrites the return address and previous stack frames

---

## Little-Endian Impact

In little-endian systems (see [[CSE351/Memory Fundamentals/Words and Memory|Words and Memory]]):
- Least significant byte at the lowest address
- During stack smashing, the **lowest byte is overwritten first**
- Example: Return address `0x4011b1` → `b1` byte overwritten first

---

## Vulnerable Code Patterns

### Dangerous Functions (No Bounds Checking)

| Function | Risk |
|:---|:---|
| `gets()` | Reads until newline regardless of buffer size |
| `strcpy()` | Copies without length verification |
| `scanf("%s")` | No size limit |

```c
char buffer[SIZE];
gets(buffer);  // Will overflow if input > SIZE
```

---

## Code Injection Attacks

### Attack Structure

1. **Exploit Code:** Malicious machine code placed at the buffer start
2. **Padding:** Filler bytes to reach the return address
3. **Address Overwrite:** Replace the return address with the buffer's address

### Attack Flow

1. Attacker crafts input: exploit code + padding + new return address
2. Buffer overflow overwrites the stored return address
3. `ret` jumps to the buffer instead of the legitimate return target
4. Exploit executes with the program's privileges

---

## Address Calculation

If the buffer is N bytes below the return address:
- Total bytes to overwrite the return address = **N + 8 bytes** (on 64-bit)

---

## Stack Frame Layout During Attack

```
Higher Addresses
├─ Previous Stack Frame Data
├─ Return Address (8 bytes) ← TARGET
├─ Local Variables
├─ Buffer (vulnerable)      ← OVERFLOW START
└─ Lower Addresses (stack grows down)
```

---

## Return Address Manipulation

- `ret` pops the value at `%rsp` into `%rip`
- A modified return address redirects execution
- Can cause segfaults, unexpected behavior, or controlled code execution

---

## Prevention

- Stack smashing detection (**stack canaries**)
- Non-executable stack (NX bit)
- Address Space Layout Randomization (ASLR)
- Use bounds-safe functions (`fgets` instead of `gets`, `strncpy` instead of `strcpy`)

---

## Related
- [[CSE351/Procedures and Stack/Stack Frames|Stack Frames]]
- [[CSE351/Procedures and Stack/Calling Conventions|Calling Conventions]]
- [[CSE351/Data Structures/Arrays|Arrays]]
- [[CSE351/Memory Fundamentals/Words and Memory|Words and Memory (Endianness)]]
- [[CSE351/Memory Management/Page Tables|Page Tables (memory protection)]]
- [[CSE484/Memory Exploits/Memory Layout|Memory Layout (CSE484)]]
- [[CSE451/Processes/CPUState/Stack Pointer|Stack Pointer (CSE451)]]
