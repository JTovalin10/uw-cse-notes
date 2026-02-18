# Arrays in C

**Related:** [[Pointer Arithmetic]], [[x86-64 Memory Operands]], [[Structs]]

---

## Basic Array Declaration

```c
T ar[N];
```

- Allocates **contiguous** space for `N` elements of size `sizeof(T)`
- Separate declarations are **not guaranteed** adjacent
- Array name is just a **label** for the starting address

---

## Arrays in Assembly

```c
int uw_zip[] = {9, 8, 1, 9, 5};
```

```assembly
uw_zip: .long 9
        .long 8
        .long 1
        .long 9
        .long 5
```

`.long` directive = 4 bytes (matches `l` instruction width)

---

## Subscript Operator

`ar[i]` is syntactic sugar for: `*(ar+i)` = `Mem[ar + i*sizeof(T)]`

### x86-64 Memory Operand Formats

1. `(Rb, Ri, S)` - `Rb` = address, `Ri` = index, `S` = sizeof(T)
2. `D(,Ri,S)` - `D` = array label, `Ri` = index, `S` = sizeof(T)

```assembly
movl (%rdi,%rsi,4), %eax     # array in %rdi, index in %rsi
movl uw_zip(,%rsi,4), %eax   # using label directly
```

---

## No Bounds Checking

C has **no bounds checking** - memory operand doesn't know array size!

```c
int x = 351;
int uw_zip[] = {9, 8, 1, 9, 5};
int ucb_zip[] = {9, 4, 7, 2, 0};

uw_zip[4];      // Returns 5 ✓
*(uw_zip + 4);  // Returns 5 ✓
*(&x + 5);      // UNDEFINED - no guaranteed adjacency
ucb_zip[-1];    // UNDEFINED
```

---

## Multidimensional Arrays

- **Contiguous** memory for all elements
- Uses **row-major ordering** (consecutive row elements adjacent)

```c
int matrix[3][4];  // 3 rows, 4 columns
```

| Expression | Returns |
|------------|---------|
| `ar[r][c]` | Element value |
| `ar[r]` | Address of row r |
| `ar` | Address of matrix |

---

## Multilevel vs Multidimensional

| Aspect | Multidimensional | Multilevel |
|--------|------------------|------------|
| Memory | Contiguous | Arrays of pointers |
| Space | Efficient | Extra pointer overhead |
| Access | Single memory access | Multiple accesses |

**Related:** [[Pointer Arithmetic]], [[CSE484/Memory Exploits/Memory Layout]]
