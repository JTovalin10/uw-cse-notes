# Stack Frames

**Stack frames** are conceptual divisions of the stack that hold the local state of each procedure.

**Related:** [[The Stack]], [[Calling Conventions]], [[Register Saving Conventions]]

---

## Why Stack Frames?

- **Enable recursion:** Multiple instances of same procedure
- **Organize memory:** Group related procedure data
- **Automatic management:** Created on call, destroyed on return

---

## Stack Discipline

**Key principle:** Space allocated during execution must be deallocated in **opposite order** before return.

This ensures:
- `ret` correctly pops return address
- Stack integrity for nested calls
- No stack corruption

---

## LIFO Consequences

For `main -> foo -> bar`:
- `bar` must return before `foo`
- `foo` must return before `main`
- Don't use data from deallocated frames!

---

## Stack Frame Layout

```
Higher addresses
┌─────────────────┐
│ Caller's frame  │
├─────────────────┤
│ Arguments 7+    │ ← Caller's build area
├─────────────────┤
│ Return address  │ ← Frame start (pushed by call)
├─────────────────┤
│ Old %rbp        │ ← Optional frame pointer
├─────────────────┤
│ Saved registers │ ← Callee-saved
├─────────────────┤
│ Local variables │
├─────────────────┤
│ Arguments 7+    │ ← For functions this frame calls
├─────────────────┤ ← Current %rsp
Lower addresses
```

---

## Frame Components

| Component | Purpose |
|-----------|---------|
| Return address | Where to return (pushed by `call`) |
| Frame pointer | Reference point (optional in x86-64) |
| Saved registers | Preserve values callee might modify |
| Local variables | Variables not in registers |
| Argument build | Arguments 7+ for called functions |

---

## Frame Pointer (`%rbp`)

Optional in x86-64. When used:

```assembly
pushq %rbp              # Save caller's frame pointer
movq %rsp, %rbp         # Set up new frame pointer
# ... function body ...
popq %rbp               # Restore caller's frame pointer
ret
```

**Related:** [[Recursion]], [[CSE351/Procedures and Stack/Memory Layout]]
