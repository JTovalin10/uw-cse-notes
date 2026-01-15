## Arrays in C (Review)

### Basic Array Declaration

- Declaring an array `T ar[N];` allocates enough **contiguous** space for `N` elements of size `sizeof(T)`
- Separate array declarations are **not guaranteed** to be adjacent or in any specific order
- Array subscript operator (`ar[i]`) uses **pointer arithmetic** to access memory

### Arrays in Assembly

#### Array Names

- Array name (`ar`) is just a **label/placeholder** for the starting address
- Example: `int uw_zip[] = {9, 8, 1, 9, 5};` becomes:

```assembly
uw_zip: .long 9
        .long 8  
        .long 1
        .long 9
        .long 5
```

- `.long` directive = 4 bytes wide (corresponds to `l` instruction width)

#### Subscript Operator

- `ar[i]` is syntactic sugar for: `*(ar+i)` ↔ `Mem[ar + i*sizeof(T)]`
- Two x86-64 memory operand formats:
    1. `(Rb, Ri, S)` - `Reg[Rb]` = address, `Reg[Ri]` = index, `S` = `sizeof(T)`
    2. `D(,Ri,S)` - `D` = array label, `Reg[Ri]` = index, `S` = `sizeof(T)`
- Example: `int eax = uw_zip[i];` translates to:
    - `movl (%rdi,%rsi,4), %eax` OR
    - `movl uw_zip(,%rsi,4), %eax`
- **No bounds checking** in C because memory operand doesn't know array size!

### Array Memory Layout Example

```c
int x = 351;
int uw_zip[] = {9, 8, 1, 9, 5};  
int ucb_zip[] = {9, 4, 7, 2, 0};
```

- `uw_zip[4]` returns `5` ✅
- `*(uw_zip + 4)` returns `5` ✅
- `*(&x + 5)` and `ucb_zip[-1]` are **undefined** - no guaranteed adjacency ❌

## Multidimensional vs Multilevel Arrays

### Multidimensional Arrays

- **Contiguous** chunk of memory for all elements
- Uses **row-major ordering** (consecutive row elements are adjacent)
- `N`-dimensional array needs `N` subscripts for individual element
- Fewer subscripts return **addresses** of larger elements:
    - `ar[r][c]` → element
    - `ar[r]` → address of row `r`
    - `ar` → address of matrix
- Access = address calculation + **single** memory access

### Multilevel Arrays

- Arrays of pointers to arrays
- Each level guaranteed contiguous, but **more total space** required
- **Extra memory access per level**

## Structs in C

### Definition and Declaration

```c
struct struct_tag {
    type_1 field_1;
    ...
    type_N field_N;
};

struct struct_tag my_struct_var;  // declare instance
```

- `struct_tag` is user-chosen name
- Full type name is `struct struct_tag` (two-part name)
- Must define before use (scope rules apply)

### Alternative Declaration Styles

```c
// Unnamed struct (not recommended)
struct {int x; int y;} var;

// Combined definition + declaration  
struct point {
    int x;
    int y;
} pt, *ptr;
```

### Usage Rules

- Compiler needs to know **size** and **layout**
- Struct **cannot contain instance of itself** (infinite size!)
- Struct **can contain pointer to itself** ✅
- Field access:
    - Instance: `pt.x`
    - Pointer: `ptr->y` or `(*ptr).y`

### Size Calculation Example

```c
struct rec {
    int a[4];     // 16 bytes
    long i;       // 8 bytes  
    struct rec* next;  // 8 bytes (pointer)
};
// Total: 32 bytes
```

## Typedef in C

### Basic Typedef

```c
typedef unsigned int uint;  // typedef <data_type> <alias>;
```

### Struct Typedef Patterns

```c
// Method 1: typedef after definition
struct point_st {
    int x; 
    int y;
};
typedef struct point_st Point;
Point pt1;

// Method 2: typedef combined with definition  
typedef struct {     // tag now optional
    int x;
    int y; 
} Point;
Point pt1;
```

## Alignment and Struct Layout

### Alignment Rule

- Object of size `K` bytes is **aligned** if address is multiple of `K`

### Struct Layout Rules

1. **Field ordering** follows definition order
2. **Padding inserted** between fields for alignment
3. **Internal fragmentation** = unused space between fields
4. **External fragmentation** = padding at end of struct

### Internal Fragmentation Example

```c
struct ex1 {
    short s;  // 2B
    int i;    // 4B  
} instance1;
// Layout: [s ][__][i ] (2 bytes padding)
```

```c
struct ex2 {
    char c;       // 1B
    int i_ar[3];  // 12B (array alignment = element size = 4B)
} instance2;  
// Layout: [c][___][i_ar| | ] (3 bytes padding)
```

### External Fragmentation

- Overall struct size must be multiple of **largest field alignment** (`K_max`)
- Ensures proper alignment in arrays of structs

### Complete Example

```c
struct frag {
    char c;        // K=1, offset 0
    int i[3];      // K=4, offset 4  
    struct frag *p; // K=8, offset 16 (6B internal padding)
    short s;       // K=2, offset 24
} f;
```

- `K_max = 8` (from pointer)
- Current end: offset 26
- Need multiple of 8 → add 6 bytes external padding
- **Total size: 32 bytes**

### Struct Size Calculation Practice

```c
struct q1 {
    int i;      // 4B at offset 0, ends at 4
    short s[3]; // 2B alignment at offset 4, ends at 10  
    char* c;    // 8B alignment at offset 16 (6B internal padding), ends at 24
    float f;    // 4B at offset 24, ends at 28
};
```

- `K_max = 8`, so pad to 32 bytes (4B external padding)
- **Total: 32 bytes**

### Memory Layout Visualization

```
 4B    6B     6B      8B     4B    4B
[i  ][s   ][______][c    ][f  ][____]
      ^internal     ^external
      fragmentation fragmentation
```