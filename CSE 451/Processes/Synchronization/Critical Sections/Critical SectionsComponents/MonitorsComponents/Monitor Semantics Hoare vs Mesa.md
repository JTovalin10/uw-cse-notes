## Semantics: Hoare vs Mesa
### Hoare Monitors (original)
- signal immediately transfers control to waiting thread
- signaling thread blocks
- condition guaranteed to hold when waiter runs

### Mesa Monitors (practical)
when a thread signals a waiting thread it is moved to the ready queue and doesnt run immediately. THe signaling thrread continues executing and by the time the woken thread actually runs the condition it was waitingf for might no longer be true so we need to recheck the condition in a while loop. 

THe reason its more practical is that its easier to implement, more flexiable, less overhead. only tradeoff is that waiters need a while loop to recheck
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
