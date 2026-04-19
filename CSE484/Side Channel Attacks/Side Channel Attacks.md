# CSE484: Side Channel Attacks

**Side channel attacks** exploit **information that can be learned from the physical or observable implementation of a system**, rather than breaking its theoretical properties (e.g., breaking the math of AES).

Side channels were initially discussed primarily in the context of cryptosystems, but they are prevalent in many other contexts as well.

## Methods

### Traffic Analysis

Analyzing the *pattern* of network traffic (size, timing, frequency) can reveal information about what a user is doing even when the content is encrypted.

![[Screenshot 2025-12-02 at 4.21.47 PM.png]]

### Keyboard Eavesdropping

The sounds or electromagnetic emissions produced by keystrokes can be analyzed to recover what was typed.

### Accelerometer / Gyroscope Eavesdropping

Sensors on a mobile device can pick up vibrations that correlate with keystrokes or spoken words nearby.

### Audio from Video

Analyzing the subtle vibrations of objects in a video recording can allow recovery of sound from a silent video.

### Power Analysis

Measuring the power consumption of a device during a cryptographic operation can leak information about the secret key.

- **Simple Power Analysis (SPA):** Directly reading off bits from the power trace.
- **Differential Power Analysis (DPA):** Looking for statistical differences in power traces across many measurements to guess a key bit.

![[Screenshot 2025-12-02 at 4.24.13 PM.png]]

### Key Extraction via Electrical Potential

Measuring the electrical potential (voltage) on a device can allow key extraction.

![[Screenshot 2025-12-02 at 4.24.38 PM.png]]

### Cache Timing Attacks

1. Manipulate the CPU cache to a known state.
2. Wait for the victim to perform an operation that accesses memory.
3. Examine what has changed in the cache to infer what memory address was accessed (and therefore what secret data was used).

This is the basis of the **Spectre** and **Meltdown** attacks. See [[Spectre]] for the full attack sketch.

## Related

- [[Spectre]] — cache timing attack exploiting speculative execution
- [[CSE484/Security Fundamentals/Other types of attacks|Other Types of Attacks]] — timing attacks at the software level
- [[CSE484/Anonymity and Privacy/Anonymity in networks & messaging|Anonymity in Networks and Messaging]] — traffic analysis in the context of anonymity
