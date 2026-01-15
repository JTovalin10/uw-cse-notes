# Structs in C

**Related:** [[Arrays]], [[Struct Alignment]], [[Pointers]]

---

## Definition and Declaration

```c
struct struct_tag {
    type_1 field_1;
    ...
    type_N field_N;
};

struct struct_tag my_struct_var;  // Instance
```

- `struct_tag` is user-chosen name
- Full type name is `struct struct_tag` (two-part)
- Must define before use

---

## Alternative Styles

```c
// Unnamed struct
struct {int x; int y;} var;

// Combined definition + declaration
struct point {
    int x;
    int y;
} pt, *ptr;
```

---

## Usage Rules

Compiler needs to know **size** and **layout**.

- Struct **cannot contain instance of itself** (infinite size!)
- Struct **can contain pointer to itself** ✓

---

## Field Access

```c
pt.x         // Instance access
ptr->y       // Pointer access
(*ptr).y     // Equivalent to above
```

---

## Size Calculation Example

```c
struct rec {
    int a[4];         // 16 bytes
    long i;           // 8 bytes
    struct rec* next; // 8 bytes (pointer)
};
// Total: 32 bytes
```

---

## Typedef Patterns

```c
// Method 1: typedef after definition
struct point_st {
    int x;
    int y;
};
typedef struct point_st Point;

// Method 2: combined
typedef struct {
    int x;
    int y;
} Point;

Point pt1;  // Cleaner usage
```

**Related:** [[Struct Alignment]], [[Memory Layout]]
