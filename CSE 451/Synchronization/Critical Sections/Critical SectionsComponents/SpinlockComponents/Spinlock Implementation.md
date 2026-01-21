## How it works
```c
void acquire(lock_t *lock) {
    while (test_and_set(&lock->flag) == 1)
        ; // spin - keep trying
}

void release(lock_t *lock) {
    lock->flag = 0;
}
```
