# CSE351: Process Termination

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
- Terminated by an exception handler
- Usually due to an unrecoverable error
- Examples: segfault, illegal instruction

---

## Status Codes

| Source | Status Code |
|:---|:---|
| Return from main | Return value |
| `exit()` | Argument |
| Abort | None (abnormal) |

**Convention:** 0 = success, non-zero = error

---

## Zombie Processes

**Definition:** A terminated process whose resources haven't been cleaned up yet.

**Why zombies exist:**
- Process resources persist after termination
- The status code must remain readable by the parent
- The system tracks the process until it is reaped

---

## Process Reaping

**Definition:** Reading the status code and deallocating a terminated process's resources.

**Responsibility:** The parent process must reap its children.

### Explicit Reaping
```c
pid_t child_pid = wait(&status);             // Any child
pid_t child_pid = waitpid(pid, &status, 0);  // Specific child
```

### Implicit Reaping
Occurs automatically when the parent terminates (children are adopted by `init`).

---

## Orphaned Processes

**Scenario:** Parent terminates before child.

**Solution:** Orphaned child is adopted by the `init` process (PID 1).

### The `init` Process
- PID is always 1 (first process started by kernel)
- Modern systems: often `systemd`
- Automatically reaps orphaned processes

---

## Examples

### Normal Lifecycle
```c
int main() {
    pid_t child = fork();
    if (child == 0) {
        exit(0);     // Child terminates → zombie
    } else {
        wait(NULL);  // Parent reaps → zombie cleaned
    }
    return 0;
}
```

### Zombie Creation
```c
if (child == 0) {
    exit(0);        // Child becomes zombie
} else {
    sleep(10);      // Parent doesn't reap immediately
    wait(NULL);     // Finally reap after 10s
}
```

---

## Best Practices

1. **Always reap children:** Use `wait()` or `waitpid()`
2. **Handle signals:** Set up handlers for child termination
3. **Avoid zombies:** Don't let children accumulate
4. **Error handling:** Check return values

---

## Related
- [[CSE351/System Programming/Processes|Processes]]
- [[CSE351/System Programming/Fork-Exec Model|Fork-Exec Model]]
- [[CSE351/System Programming/Context Switching|Context Switching]]
- [[CSE351/System Programming/Exceptions|Exceptions]]
- [[CSE451/Processes/Process/Process State|Process State (CSE451)]]
- [[CSE451/Processes/Process/States of a user process|States of a User Process (CSE451)]]
