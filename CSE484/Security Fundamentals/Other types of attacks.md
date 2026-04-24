# CSE484: Other Types of Attacks

## Integer Overflow

When writing to a buffer with a length check, an attacker can cause an **integer overflow** to make the length appear negative, bypassing the check.

```c
char buf[80];
void vulnerable() {
    // signed 4 bytes
    // if read int is 2,147,483,647
    // the user can pass in -1
    int len = read_int_from_network();
    char* p = read_string_from_network();
    // no check if the number is negative
    if (len > sizeof buf) {
        error("Length too large, nice try!");
        return;
    }
    // implicit cast will change a -1 to INT_MAX
    memcpy(buf, p, len);
}
```

The fix is to also check that `len >= 0` before using it in `memcpy`.

## TOCTOU (Time-of-Check to Time-of-Use) Race Condition

A **TOCTOU** vulnerability (also called a **race condition**) occurs when there is a gap between checking a condition and using the result of that check. An attacker can change the state of the system in that gap.

```c
// Time-of-Check (TOCTOU) Vulnerability Example

// --- THE CHECK ---
// The program checks if it has permission to write to "file".
// At this moment, "file" might be a safe, legitimate file or a symlink
// pointing to a safe file. The check passes.
if (access("file", W_OK) != 0) {
    exit(1);
}

// --- THE GAP ---
// !!! VULNERABILITY !!!
// A race condition exists here. In the tiny window of time between the 'access'
// check and the 'open' call below, an attacker can change what "file" is.
// For example, they could swap a symlink to point from a safe file
// (e.g., /tmp/ok.txt) to a critical system file (e.g., /etc/passwd).

// --- THE USE ---
// The program now opens "file". It *thinks* it's opening the file it just
// checked, but it could be opening the attacker's malicious file instead.
fd = open("file", O_WRONLY);

// This write operation will now write data to whatever file was opened,
// potentially corrupting a critical system file.
write(fd, buffer, sizeof(buffer));
```

## Timing Attacks

A **timing attack** is a way for an attacker to extract secret information from a system not by breaking its algorithms directly, but by **measuring how long it takes to perform certain operations**.

The key idea is that the execution time can change based on the secret data being processed — this is called **input-dependent timing**.

**Example — Password Checking:**
- If your guess is `b` and the password is `password`, the check fails on the very first letter and stops immediately. This is very fast.
- If your guess is `passcode`, the check validates `p`, `a`, `s`, `s` before failing on `c`. This takes slightly longer.

By carefully measuring these tiny time differences, an attacker can guess the secret one piece at a time. This type of attack can succeed even on software that has no common bugs like buffer overflows. It is difficult to protect against because almost every instruction takes a non-zero amount of time, and modern hardware has many complex optimizations that affect timing.

### Concrete Examples of Timing Attacks

- **Timing cache misses:** The CPU has a small, super-fast memory called a **cache**. A cache **hit** is very fast; a cache **miss** requires fetching from slower main memory (RAM). An attacker can manipulate the cache and measure whether a victim's operation results in a hit or miss, leaking information about what memory the victim accessed.
  - **Spectre/Meltdown** are famous vulnerabilities that used this type of cache timing attack to read sensitive memory from other programs. See [[CSE484/Side Channel Attacks/Spectre|Spectre]].

- **Duration of a rendering operation:** The time it takes a web browser to render a page can leak information about its contents. An attacker could determine if a user is logged into a specific site by timing how long it takes to render an element that only appears for logged-in users.

- **Duration of a failed decryption attempt:** In some encryption systems, the time or error message differs depending on *why* decryption failed. For example, "incorrect padding" might return faster than "incorrect key." This is often called a **padding oracle attack**.

## General Defensive Principles

- **Check interface boundaries carefully** — validate inputs, outputs, and assumptions; simplify APIs; use modular design
- **Least Privilege** — give each component only the access it needs
- **Failsafe defaults** — default to denying access, not allowing it
- **Defense in depth** — multiple independent layers of protection
- **Open design** — security should not depend on secrecy of the design (see [[Cryptography#Kerckhoff's Principle]])

## Related

- [[How Systems Fail]] — categories of system failures
- [[Bug, Vulnerabilities, and Exploits]] — buffer overflows and bounds checking
- [[CSE484/Side Channel Attacks/Side Channel Attacks|Side Channel Attacks]] — timing attacks in context of hardware
- [[CSE484/Side Channel Attacks/Spectre|Spectre]] — cache timing attack on CPUs