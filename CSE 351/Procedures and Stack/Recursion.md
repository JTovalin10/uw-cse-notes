# Recursion

Recursion works seamlessly with stack frames and calling conventions - no special considerations needed!

**Related:** [[Stack Frames]], [[Register Saving Conventions]], [[Calling Conventions]]

---

## How It Works

- Each recursive call creates a **new stack frame**
- Each instance has its **own local context**
- Register saving prevents **data corruption** between instances

---

## Dual Role Challenge

Recursive procedures are **both caller and callee**:
- As callee: Receives parameters, returns values
- As caller: Makes recursive calls with new parameters
- Same registers used, so values must be preserved

---

## Factorial Example

### C Code
```c
int fact(int n) {
    if (n <= 1) return 1;
    return n * fact(n-1);
}
```

### Assembly
```assembly
fact:
  mov    $0x1,%eax        # Return value = 1
  cmp    $0x1,%rdi        # Compare n with 1
  ja     recursive        # Jump if n > 1
  retq                    # Return 1 (base case)
recursive:
  push   %rbx             # Save old %rbx
  mov    %rdi,%rbx        # Save n in %rbx
  lea    -0x1(%rdi),%rdi  # Compute n-1
  callq  fact             # Recursive call
  imul   %rbx,%rax        # n * fact(n-1)
  pop    %rbx             # Restore old %rbx
  retq                    # Return result
```

---

## Stack Frame Growth for `fact(3)`

```
┌─────────────────┐
│     main        │
├─────────────────┤
│ <ret to main>   │ ← fact(3) frame
│ <main's %rbx>   │
├─────────────────┤
│   0x40113f      │ ← fact(2) frame
│       3         │   (saved n)
├─────────────────┤
│   0x40113f      │ ← fact(1) frame
├─────────────────┤ ← %rsp
```

---

## Execution Trace

1. `fact(3)`: n=3 > 1, save %rbx, save n=3, call fact(2)
2. `fact(2)`: n=2 > 1, save %rbx=3, save n=2, call fact(1)
3. `fact(1)`: n=1, return 1 (base case)
4. `fact(2)`: compute 2*1=2, return 2
5. `fact(3)`: compute 3*2=6, return 6

---

## Key Observations

- Base case frame is smaller (doesn't reach `pushq`)
- All recursive calls return to `imul` instruction
- Each `n` saved in `%rbx` and restored for multiplication

**Related:** [[The Stack]], [[Stack Pointer]]
