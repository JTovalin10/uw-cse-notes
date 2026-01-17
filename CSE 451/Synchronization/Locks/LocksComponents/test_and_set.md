# test_and_set
an atomic instruction that reads a memory location, returns its value, and sets it to 1 in a single uninterruptible operation

## Semantics
```c
// Executed atomically by hardware
int test_and_set(int *ptr) {
    int old = *ptr;
    *ptr = 1;
    return old;
}
```

## How It Works
1. Read the current value at the memory location
2. Write 1 to that location
3. Return the old value
4. All three steps happen atomically

## Using for Spinlock
```c
typedef struct {
    int flag;
} lock_t;

void init(lock_t *lock) {
    lock->flag = 0;
}

void acquire(lock_t *lock) {
    while (test_and_set(&lock->flag) == 1)
        ; // spin - someone else has the lock
}

void release(lock_t *lock) {
    lock->flag = 0;
}
```

### Why This Works
- If lock is free (flag = 0): TAS returns 0, sets flag to 1, we have the lock
- If lock is held (flag = 1): TAS returns 1, flag stays 1, we keep spinning
- Only one thread can get 0 back, others all see 1

## x86 Implementation
```asm
; XCHG is always atomic on x86
acquire:
    mov eax, 1
spin:
    xchg eax, [lock]
    test eax, eax
    jnz spin
    ret

release:
    mov [lock], 0
    ret
```

## Problems
- no fairness guarantees - a thread could spin forever
- cache line bouncing on multiprocessors - every test_and_set invalidates other caches
- busy waiting wastes CPU cycles

## Improvements
- test-and-test-and-set: spin on read first, only do TAS when lock appears free
- ticket locks: provide fairness guarantees
- MCS locks: reduce cache contention

## Related
- [[Atomic]]
- [[Spinlock]]
- [[compare_and_swap]]
