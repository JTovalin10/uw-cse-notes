## Operations
```c
wait(S)    // also called P() or down()
signal(S)  // also called V() or up()
```

### wait(S) / P() / down()
```c
void wait(semaphore *S) {
    S->value--;
    if (S->value < 0) {
        // add this thread to S->waiting_queue
        block();
    }
}
```

### signal(S) / V() / up()
```c
void signal(semaphore *S) {
    S->value++;
    if (S->value <= 0) {
        // remove a thread T from S->waiting_queue
        wakeup(T);
    }
}
```
