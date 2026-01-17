# compare_and_swap
an atomic instruction that compares a memory location to an expected value and, only if they match, swaps in a new value

also known as: CAS, cmpxchg (x86), compare-and-exchange

## Semantics
```c
// Executed atomically by hardware
int compare_and_swap(int *ptr, int expected, int new_value) {
    int old = *ptr;
    if (old == expected)
        *ptr = new_value;
    return old;
}
```

## How It Works
1. Read the current value at the memory location
2. Compare it to the expected value
3. If they match, write the new value
4. Return the old value (regardless of whether swap occurred)
5. All steps happen atomically

## More Powerful than test_and_set
- TAS can only set to a fixed value (1)
- CAS can set to any value conditionally
- CAS enables lock-free algorithms

## Using for Spinlock
```c
void acquire(lock_t *lock) {
    while (compare_and_swap(&lock->flag, 0, 1) != 0)
        ; // spin until we successfully change 0 to 1
}

void release(lock_t *lock) {
    lock->flag = 0;
}
```

## Lock-Free Stack (Push)
```c
void push(stack *s, node *new_node) {
    node *old_top;
    do {
        old_top = s->top;
        new_node->next = old_top;
    } while (compare_and_swap(&s->top, old_top, new_node) != old_top);
}
```
- if another thread modified top, CAS fails and we retry
- no lock needed, but may need multiple attempts

## x86 Implementation
```asm
; CMPXCHG instruction
; Compares EAX with destination
; If equal, loads source into destination
; If not equal, loads destination into EAX

acquire:
    mov eax, 0         ; expected value
    mov ecx, 1         ; new value
spin:
    lock cmpxchg [lock], ecx
    jnz spin           ; ZF=0 means swap didn't happen
    ret
```

## ABA Problem
a pitfall with CAS-based algorithms:
1. Thread 1 reads value A
2. Thread 2 changes A to B, then back to A
3. Thread 1's CAS succeeds (sees A), but data structure may be corrupted

Solutions:
- version numbers / counters
- hazard pointers
- memory reclamation schemes

## Related
- [[Atomic]]
- [[test_and_set]]
- [[Spinlock]]
