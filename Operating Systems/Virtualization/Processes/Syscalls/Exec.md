# CSE451: Exec

```c
int exec(char* prog, char* argv[]) { ... }
```

The **`exec()`** syscall replaces the program currently running inside a [[Process|process]] with a different program, without creating a new process. This is the second half of the standard "run a new program" pattern described in [[exec vs fork|exec vs fork]] — first [[Fork|fork]] a new process, then `exec()` inside the child to load the actual target program.

## Steps

1. Stops the current [[Process|Process]]'s execution.
2. Loads the new program's image ('proc') into the address space, overwriting the existing process image entirely — the old code, data, heap, and stack contents are discarded.
3. Initializes the hardware context (registers, [[CPU State#Program Counter (PC)|Program Counter]]) and sets up the arguments (`argv`) for the new program.
4. Places the process's [[Process Control Block|proc]] onto the ready queue (see [[State Queues|State Queues]]) so the [[Scheduling|scheduler]] can dispatch it.

## Key Properties

- **Does not create a new process**: the [[Process#Process Identification (PID)|PID]] and process identity are unchanged — only the program running inside that process changes.
- **`exec` should never return**: since the calling program's code has been entirely overwritten, there is no code left to return to. If `exec()` does return to the caller, it means the call failed (e.g., the program couldn't be found or loaded).

## Related
- [[Fork|Fork]]
- [[exec vs fork|exec vs fork]]
- [[Process|Process]]
- [[Process Creation|Process Creation]]
- [[State Queues|State Queues]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| exec() | `execve()` family (POSIX) |
