# x86-64 Calling Conventions

**Calling conventions** are established rules for passing data and control between procedures.

**Related:** [[Stack Frames]], [[x86-64 Registers]], [[Register Saving Conventions]]

---

## Terminology

- **Caller:** Procedure doing the calling
- **Callee:** Procedure being called

---

## Return Address

Since procedures can be called from multiple locations, we store where to return after completion.

The `call` instruction pushes the address of the **next instruction** as the return address.

---

## Procedure Call (`call`)

```assembly
call label
```

**Steps:**
1. Push return address onto stack
2. Update `%rip` to label's address

---

## Procedure Return (`ret`)

```assembly
ret
```

**Steps:**
1. Pop return address from stack
2. Update `%rip` to popped address

**Critical:** `%rsp` must point to return address before `ret`!

---

## Argument Passing

### First 6 Arguments (Registers)

| Argument | Register | Mnemonic |
|----------|----------|----------|
| 1st | `%rdi` | **D**iane's |
| 2nd | `%rsi` | **S**ilk |
| 3rd | `%rdx` | **D**ress |
| 4th | `%rcx` | **C**ost |
| 5th | `%r8` | **$8** |
| 6th | `%r9` | **9** |

**Memory aid:** "Diane's Silk Dress Cost $8 9"

### Arguments 7+ (Stack)

Pushed in **reverse order** (7th argument closest to return address)

---

## Return Value

- **Location:** `%rax` register
- **Size limit:** 8 bytes
- **Large values:** Return pointer to data in `%rax`

---

## Example

```c
func(a, b, c, d, e, f, g, h);
```

```assembly
movq h, (%rsp)          # 8th argument
movq g, 8(%rsp)         # 7th argument
movq a, %rdi            # 1st argument
movq b, %rsi            # 2nd argument
movq c, %rdx            # 3rd argument
movq d, %rcx            # 4th argument
movq e, %r8             # 5th argument
movq f, %r9             # 6th argument
call func
```

**Related:** [[Stack Frames]], [[Register Saving Conventions]]
