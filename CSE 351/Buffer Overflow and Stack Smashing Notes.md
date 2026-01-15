## Core Concepts

### Buffer Overview

- **Buffer**: A region of memory (usually an array) used to temporarily store data
- **Buffer Overflow**: Writing data past the end of a buffer, overwriting adjacent memory locations
- In C, this is possible because there's no automatic bounds checking
- Outcomes can range from innocuous to program crashes to malicious exploitation

### Stack Smashing

- **Stack Smashing**: A specific type of buffer overflow targeting local arrays in the stack
- **Memory Layout Behavior**:
    - Array elements are laid out in increasing address order (`&a[i+1] > &a[i]`)
    - Stack grows _downward_ (toward lower addresses)
    - Buffer overflow moves toward _higher_ addresses
    - Eventually overwrites return address and data in previous stack frames

### Little-Endian Impact

- In little-endian systems, the least significant byte is stored at the lowest address
- During stack smashing, the **lowest byte gets overwritten first**
- Example: Return address `0x4011b1` → the `b1` byte gets overwritten first

## Vulnerable Code Patterns

### Dangerous Functions

Functions that don't perform bounds checking:

- `gets()` - reads user input until newline/EOF, regardless of buffer size
- `strcpy()` - copies strings without length verification
- `scanf()` with `%s` format specifier

### Example Vulnerability

```c
char buffer[SIZE];
gets(buffer);  // Will write past buffer if input > SIZE
```

**Compiler Warning**: Modern compilers warn about `gets()` usage due to security risks.

## Code Injection Attacks

### Attack Structure

A successful code injection attack involves three components:

1. **Exploit Code**: Malicious instructions compiled to machine code, placed at buffer start
2. **Padding**: Filler bytes to reach the stored return address location
3. **Address Overwrite**: Replace return address with buffer's starting address

### Attack Flow

1. Attacker crafts input with exploit code + padding + new return address
2. Buffer overflow overwrites the stored return address
3. When `ret` instruction executes, it jumps to buffer address instead of legitimate return
4. Exploit code executes with program privileges

### Address Calculation

- If buffer start is N bytes below return address
- Total bytes needed to overwrite return address = N + 8 bytes (on 64-bit systems)
- Example: Buffer 8 bytes below return address requires 16 total bytes to fully overwrite

## Security Implications

### Ethical Considerations

- Buffer overflow exploitation can cause massive real-world damage
- Financial and destructive consequences are significant
- Using such knowledge maliciously violates ethical responsibilities
- Knowledge should be used for defensive purposes (understanding vulnerabilities to prevent them)

### Detection and Prevention

- Modern systems include stack protection mechanisms
- Stack smashing detection can identify some attacks
- However, small overflows may go undetected
- Secure coding practices and bounds checking are essential defenses

## Key Technical Details

### Stack Frame Layout

```
Higher Addresses
├─ Previous Stack Frame Data
├─ Return Address (8 bytes on 64-bit)
├─ Local Variables
├─ Buffer (vulnerable to overflow)
└─ Lower Addresses (stack growth direction)
```

### Return Address Manipulation

- `ret` instruction pops value at `%rsp` into `%rip`
- Modifying stored return address redirects program execution
- Can cause segfaults, unexpected behavior, or controlled execution transfer