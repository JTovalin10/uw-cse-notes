# Buffer Overflow

**Related:** [[The Stack]], [[Stack Frames]], [[Arrays]], [[Endianness]]

---

## Core Concepts

### Buffer
A region of memory (usually an array) used to temporarily store data.

### Buffer Overflow
Writing data past the end of a buffer, overwriting adjacent memory locations.

- Possible in C because there's **no automatic bounds checking**
- Outcomes range from innocuous to crashes to malicious exploitation

---

## Stack Smashing

A specific type of buffer overflow targeting **local arrays on the stack**.

### Memory Layout Behavior
- Array elements: increasing address order (`&a[i+1] > &a[i]`)
- Stack growth: **downward** (toward lower addresses)
- Overflow direction: toward **higher** addresses
- Eventually overwrites return address and previous stack frames

**Related:** [[Stack Pointer]], [[Memory Layout]]

---

## Little-Endian Impact

In [[Endianness|little-endian]] systems:
- Least significant byte at lowest address
- During stack smashing, **lowest byte overwritten first**
- Example: Return address `0x4011b1` → `b1` byte overwritten first

---

## Vulnerable Code Patterns

### Dangerous Functions (No Bounds Checking)

| Function | Risk |
|----------|------|
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

1. **Exploit Code:** Malicious machine code at buffer start
2. **Padding:** Filler bytes to reach return address
3. **Address Overwrite:** Replace return address with buffer address

### Attack Flow

1. Attacker crafts input: exploit code + padding + new return address
2. Buffer overflow overwrites stored return address
3. `ret` jumps to buffer instead of legitimate return
4. Exploit executes with program privileges

**Related:** [[Calling Conventions]], [[Program Counter]]

---

## Address Calculation

If buffer is N bytes below return address:
- Total bytes to overwrite return address = **N + 8 bytes** (64-bit)

---

## Stack Frame Layout During Attack

```
Higher Addresses
├─ Previous Stack Frame Data
├─ Return Address (8 bytes) ← TARGET
├─ Local Variables
├─ Buffer (vulnerable) ← OVERFLOW START
└─ Lower Addresses (stack growth)
```

---

## Return Address Manipulation

- `ret` pops value at `%rsp` into `%rip`
- Modified return address redirects execution
- Can cause segfaults, unexpected behavior, or controlled execution

**Related:** [[Stack Pointer]], [[Program Counter]]

---

## Prevention

- Modern stack protection mechanisms
- Stack smashing detection (stack canaries)
- Secure coding practices
- Bounds checking

**Related:** [[Virtual Memory]]
