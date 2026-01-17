# Heisenbug
a software bug that seems to disappear or alter its behavior when you try to observe or debug it

named after Heisenberg's uncertainty principle

## Why They Occur in Concurrent Programs
- adding debug output changes timing
- running in debugger changes scheduling
- the observation affects the system being observed

## Example
```c
// Bug: race condition on shared_data
void buggy_function() {
    if (shared_data != NULL) {
        use(shared_data);  // crash here sometimes
    }
}

// "Fixed" version that hides the bug
void debugging_function() {
    printf("shared_data = %p\n", shared_data);  // this printf changes timing!
    if (shared_data != NULL) {
        use(shared_data);  // now it never crashes
    }
}
```

## Why Debugging Changes Behavior
- **printf/logging**: adds delay, allows other threads to complete
- **debugger breakpoints**: stops one thread, lets others run
- **debug builds**: different optimization, different timing
- **additional checks**: code runs slower, changes race window

## Strategies for Finding Heisenbugs
### Stress Testing
- run with many threads
- run many iterations
- vary timing artificially

### Tool-Based Detection
- ThreadSanitizer (TSan)
- Helgrind (Valgrind tool)
- Intel Inspector

### Code Review
- look for unprotected shared data
- check lock discipline
- review happens-before relationships

### Systematic Approaches
- model checking
- controlled scheduling (e.g., CHESS)

## Related
- [[Race Condition]]
- [[Interleaved Schedules]]
