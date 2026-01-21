## Semantics: Hoare vs Mesa
### Hoare Monitors (original)
- signal immediately transfers control to waiting thread
- signaling thread blocks
- condition guaranteed to hold when waiter runs

### Mesa Monitors (practical)
- signal is a hint, waiter may not run immediately
- signaling thread continues
- waiter must recheck condition (use `while`, not `if`)

```c
// Mesa-style (correct)
while (!condition) {
    wait(cv);
}

// Hoare-style (would work but not in Mesa)
if (!condition) {
    wait(cv);
}
```
