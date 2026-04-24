# CSE351: Side Channel Attacks

**Side channel attacks** exploit physical side effects of a system's implementation — such as timing or memory access patterns — to infer secret information without breaking the underlying cryptography.

## Timing Attacks

Consider a password checker that returns early on the first mismatched character:

```c
int check_password(char* input, char* real) {
    for (int i = 0; input[i] != 0 && real[i] != 0; i++) {
        if (input[i] != real[i]) return 0;
    }
    return 1;
}
```

An attacker can brute-force one character at a time by measuring how long each guess takes: a longer execution time means more characters matched before the early return, leaking information about the correct password.

## Cache Timing

By measuring how long a memory access takes, an attacker can determine whether a given address is in the cache (fast = cache hit, slow = cache miss).

### Flush + Reload

1. **Flush**: Evict the target address from the cache.
2. **Wait**: Let the victim program run — it may load its data into the cache.
3. **Reload**: Access the target address and measure the time. A fast access means the victim loaded it; a slow access means it did not.

## Spectre and Meltdown

### Speculative Execution and Branch Prediction

Modern CPUs **pipeline** instructions, beginning work on future instructions before the current one completes. At a conditional branch, the CPU uses **branch prediction** — it observes past program behavior and makes an educated guess about which path to take. If the guess is correct, time is saved; if wrong, the CPU rolls back and executes the correct path.

### Spectre Attack

Spectre combines cache timing with speculative execution:

1. **Train** the branch predictor to take a particular branch.
2. Cause the CPU to speculatively execute that branch so it reads a memory location the attacker normally cannot access — this loads the secret data into the cache.
3. Even after the CPU detects the misprediction and rolls back the execution, the data **remains in the cache**.
4. Use **Flush + Reload** to determine what was loaded, recovering the secret.

### Mitigations

| Approach | Cost |
|:---|:---|
| Virtual memory isolation | Already in use; limits inter-process access |
| Disabling speculative execution for vulnerable code | ~30% performance penalty |
| Flushing branch predictor state on context switch | Moderate overhead; prevents cross-program training |

Most performance-costly mitigations are not widely deployed because a real-world Spectre attack already requires the attacker to have code running on the victim's machine, making the threat model narrow.

## Related
- [[CSE351/Cache/Program Optimizations via Cache|Program Optimizations via Cache]]
- [[CSE351/Cache/Cache Organization|Cache Organization]]
- [[CSE351/Security/Buffer Overflow|Buffer Overflow]]
