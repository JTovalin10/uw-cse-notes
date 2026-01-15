# Integer Overflow
when writing to a buffer and you create a check to see if the length of the buffer is smaller than the input what a attacker can do is maker the integer overflow and make it negative
```c
char buf[80]
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
	// implict cast will change a -1 to INT_MAX
	memcpy(buf, p, len);
}
```

# TOCTOU (race condition)
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

### Timing Attacks

A timing attack is a clever way for an attacker to extract secret information from a system, not by breaking its code or algorithms directly, but by **measuring how long it takes to perform certain operations**.

The key idea is that for some operations, the execution time can change based on the secret data being processed. This is called **input-dependent timing**.

Imagine you're trying to guess a password that's being checked one character at a time.

- If your guess is `b` and the password is `password`, the check might fail on the very first letter and stop immediately. This is **very fast**.
    
- If your guess is `passcode`, the check will validate `p`, `a`, `s`, `s` before failing on `c`. This takes slightly **longer**.
    

By carefully measuring these tiny time differences, an attacker can guess the secret one piece at a time. The fundamental vulnerability is that the program's execution time is leaking information about the secret it's processing.

As the slide notes, this type of attack can succeed even on well-designed software that has no common bugs like buffer overflows. It's difficult to protect against because almost every computer instruction takes a non-zero amount of time, and modern hardware has many complex optimizations that affect timing.

---

### Other Examples

The second slide provides more concrete examples of how timing variations can be exploited:

- **Timing cache misses:** The CPU has a small, super-fast memory called a **cache**. When the CPU needs data, it first checks the cache. If the data is there (a cache **hit**), it's very fast. If not (a cache **miss**), it has to fetch it from the much slower main memory (RAM). An attacker can manipulate the cache and then measure whether a victim's operation results in a hit or a miss, which can leak information about what memory addresses (and therefore what data) the victim is using.
    
    - **Spectre/Meltdown** were famous vulnerabilities that used this type of cache timing attack to read sensitive memory from other programs.
        
- **Duration of a rendering operation:** The time it takes a web browser to draw (render) a webpage can leak information about its contents. For example, an attacker could use this to determine if a user is logged into a specific site by measuring how long it takes to render a frame containing a known element that only appears for logged-in users.
    
- **Duration of a failed decryption attempt:** This is a classic cryptographic attack. In some encryption systems, the error message or the time it takes to report an error is different depending on _why_ the decryption failed. For example, a failure due to "incorrect padding" might return faster than one due to an "incorrect key." An attacker can use these differences in failure time to slowly decrypt a message without ever knowing the key. This is often called a **padding oracle attack**.
# General Principle that we can follow
- check interfae boundaries carefully
	- inputs, outputs, assumptions, simplify API, modular design
- Least Privilege
- failsafe defaults
- defense in depth
- open design? open Source? closed source?
	- diff perspective