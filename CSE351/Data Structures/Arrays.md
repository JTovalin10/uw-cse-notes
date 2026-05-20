# CSE351: Arrays in C

An array in C is a contiguous block of memory holding a fixed number of elements of the same type. The language provides no runtime bounds checking — the programmer is responsible for staying within bounds.

---

## Basic Array Declaration

```c
T ar[N];
```

- Allocates **contiguous** space for `N` elements, each of size `sizeof(T)` bytes.
- The total size is `N × sizeof(T)` bytes.
- Separate array declarations in the same function are **not** guaranteed to be adjacent in memory.
- The array name `ar` is a label for the starting address of the first element; it is not a pointer variable.

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

The `.long` directive reserves 4 bytes per element, matching the `l` (long word) size suffix for `int` operations.

---

## Subscript Operator

`ar[i]` is syntactic sugar for pointer arithmetic. The compiler and the C standard define them as identical:

```c
ar[i]  ==  *(ar + i)  ==  Mem[ar + i * sizeof(T)]
```

### x86-64 Memory Operand Formats

The scaled addressing mode maps directly onto array indexing:

1. `(Rb, Ri, S)` — base register `Rb` holds the array address, `Ri` the index, `S` = `sizeof(T)`
2. `D(,Ri,S)` — `D` is the array's label (linked in at assembly time), `Ri` is the index, `S` = `sizeof(T)`

```assembly
movl (%rdi,%rsi,4), %eax     # int ar[] in %rdi, i in %rsi (sizeof(int)=4)
movl uw_zip(,%rsi,4), %eax   # using the array label directly
```

---

## No Bounds Checking

C does **not** perform bounds checking. The memory operand has no knowledge of the array's declared size. Out-of-bounds access is undefined behavior:

```c
int x = 351;
int uw_zip[] = {9, 8, 1, 9, 5};
int ucb_zip[] = {9, 4, 7, 2, 0};

uw_zip[4];      // Returns 5 (valid)
*(uw_zip + 4);  // Returns 5 (valid — same thing)
*(&x + 5);      // UNDEFINED — no guaranteed adjacency between locals
ucb_zip[-1];    // UNDEFINED — negative index
```

This is the root cause of [[CSE351/Security/Buffer Overflow|buffer overflow]] vulnerabilities.

---

## Multidimensional Arrays

Multidimensional arrays use **row-major ordering** — consecutive elements within a row are adjacent in memory, and rows are laid out one after another.

```c
int matrix[3][4];  // 3 rows, 4 columns, 12 integers total
```

| Expression | Type | Returns |
|:---|:---|:---|
| `ar[r][c]` | `int` | Element value at row r, column c |
| `ar[r]` | `int*` | Address of the first element of row r |
| `ar` | `int(*)[4]` | Address of the entire matrix |

The address of `ar[r][c]` = `base + (r × 4 + c) × sizeof(int)` for a 4-column `int` matrix.

---

## Multilevel vs. Multidimensional Arrays

| Aspect | Multidimensional (`T ar[R][C]`) | Multilevel (`T* ar[R]`) |
|:---|:---|:---|
| Memory layout | Fully contiguous | Array of pointers; rows may be non-contiguous |
| Space | Efficient — no pointer overhead | Extra pointer storage per row |
| Access cost | Single memory access after address computation | Two memory accesses: load pointer, then load element |
| Use case | Fixed-size rectangular data | Variable-length rows (e.g., jagged arrays) |

---

```mermaid
flowchart LR
    A["ar (base address)"] -->|"+ i * sizeof(T)"| B["ar[i]: element address"]
    B -->|"dereference"| C["element value"]
    subgraph 2D [2D Row-Major: matrix[3][4]]
        R0["Row 0: [0][0] [0][1] [0][2] [0][3]"]
        R1["Row 1: [1][0] [1][1] [1][2] [1][3]"]
        R2["Row 2: [2][0] [2][1] [2][2] [2][3]"]
    end
```

---

## Related

- [[CSE351/Memory Fundamentals/Pointers|Pointers and Pointer Arithmetic]]
- [[CSE351/x86-64 Assembly/x86-64 Memory Operands|Memory Operands]]
- [[CSE351/Data Structures/Structs|Structs (including Alignment)]]
- [[CSE351/Security/Buffer Overflow|Buffer Overflow (no bounds checking)]]
- [[CSE351/Cache/Spatial Locality|Spatial Locality (row-major access)]]
- [[CSE333/Data Structures/Vector|Vector (CSE333)]]
- [[CSE484/Memory Exploits/Memory Layout|Memory Layout (CSE484)]]

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|:---|:---|
| Contiguous memory allocation | Linear memory layout; flat array |
| `ar[i]` = `*(ar + i)` | Array-pointer duality (C standard) |
| Row-major ordering | Row-major order; C-order; used in C, C++, NumPy by default |
| Column-major ordering | Fortran order; used in Fortran, MATLAB, Julia |
| No bounds checking | Unsafe array access; buffer over-read/over-write |
| Multilevel array | Array of pointers; jagged array; ragged array |
