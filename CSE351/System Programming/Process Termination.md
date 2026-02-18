# Process Termination

**Related:** [[Processes]], [[Fork-Exec Model]], [[CSE351/System Programming/Exceptions]]

---

## Ways Processes Terminate

### 1. Normal Termination
```c
int main() {
    return 0;  // Status code 0 (success)
}
```

### 2. Explicit Exit
```c
exit(0);  // Status code 0
// Code after exit() never executes
```

### 3. Exception Abort
- Terminated by exception handler
- Usually due to unrecoverable error
- Examples: segfault, illegal instruction

---

## Status Codes

| Source | Status Code |
|--------|-------------|
| Return from main | Return value |
| `exit()` | Argument |
| Abort | None (abnormal) |

**Convention:** 0 = success, non-zero = error

---

## Zombie Processes

**Definition:** Terminated process whose resources haven't been cleaned up.

**Why zombies exist:**
- Process resources persist after termination
- Status code must be readable by parent
- System tracks process until reaped

---

## Process Reaping

**Definition:** Reading status code and deallocating resources.

**Responsibility:** Parent process must reap children.

### Explicit Reaping
```c
pid_t child_pid = wait(&status);      // Any child
pid_t child_pid = waitpid(pid, &status, 0);  // Specific child
```

### Implicit Reaping
Occurs automatically when parent terminates.

---

## Orphaned Processes

**Scenario:** Parent terminates before child.

**Solution:** Orphaned child adopted by `init` process (PID 1).

### The `init` Process
- PID always 1 (first process by kernel)
- Modern systems: often `systemd`
- Automatically reaps orphaned processes

---

## Examples

### Normal Lifecycle
```c
int main() {
    pid_t child = fork();
    if (child == 0) {
        exit(0);       // Child terminates → zombie
    } else {
        wait(NULL);    // Parent reaps → zombie cleaned
    }
    return 0;
}
```

### Zombie Creation
```c
if (child == 0) {
    exit(0);           // Child becomes zombie
} else {
    sleep(10);         // Parent doesn't reap
    wait(NULL);        // Finally reap after 10s
}
```

---

## Best Practices

1. **Always reap children:** Use `wait()` or `waitpid()`
2. **Handle signals:** Set up handlers for child termination
3. **Avoid zombies:** Don't let children accumulate
4. **Error handling:** Check return values

**Related:** [[Fork-Exec Model]], [[Context Switching]]
