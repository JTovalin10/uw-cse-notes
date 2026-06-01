## Semantics: Hoare vs Mesa
### Hoare Monitors (original)
- signal immediately transfers control to waiting thread
- signaling thread blocks
- condition guaranteed to hold when waiter runs

### Mesa Monitors (practical)
When a thread signals a waiting thread, it is moved to the ready queue and doesn't run immediately. The signaling thread continues executing, and by the time the woken thread actually runs, the condition it was waiting for might no longer be true, so we need to recheck the condition in a while loop.

The reason it's more practical is that it's easier to implement, more flexible, and has less overhead. The only tradeoff is that waiters need a while loop to recheck.
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
