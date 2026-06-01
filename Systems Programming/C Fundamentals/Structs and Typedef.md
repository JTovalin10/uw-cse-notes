# CSE333: Structs and Typedef

**Structs** are the most object-like feature in C, allowing for the collection of multiple fields into a single data type.

## Defining Structs

A struct is a **tag**, not a first-class type name on its own. You must prefix it with the `struct` keyword each time you use it unless you apply `typedef`.

```c
struct Point {
    float x, y;
};
struct Point origin = {0.0, 0.0};
```

## Using Typedef

**typedef** allows the creation of synonyms for types, making them easier to use without repeating the `struct` keyword.

```c
typedef struct point_st {
    float x, y;
} Point, *PointPtr;

Point p1;           // same as struct point_st
PointPtr p1_ptr = &p1;
```

**Warning**: Be careful with pointers in `typedef`. The `*` becomes part of the new type name, so `PointPtr` is already a pointer type.

## Accessing Fields

- **Dot operator (`.`)**: Access a field from a struct variable.
- **Arrow operator (`->`)**: Access a field from a struct pointer. This is shorthand for `(*p).field`.

## Self-Referential Structs

Structs can contain pointers to their own type, which is essential for building data structures like linked lists. Note that you must use the **struct tag** (e.g., `struct node`) inside the definition because the `typedef` name is not available until the definition is complete.

```c
typedef struct node_st {
    int data;
    struct node_st* next;
} Node;
```

See [[LinkedList|LinkedList]] for a complete example of building a linked list with self-referential structs.

## Memory Behavior

- **Copy by Assignment**: Assigning one struct to another (e.g., `p2 = p1`) copies the **entire contents** — a shallow copy.
- **Pass by Value**: Structs are passed by value to functions, meaning the entire struct is copied onto the stack. For large structs, passing a pointer is more efficient.
- **Returning Structs**: Can return structs by value. Small structs are often returned in registers (`%rax`, `%rdx`), while larger ones are returned via memory (the caller passes a hidden pointer).

## Memory Alignment and Padding

The size of a struct is at least the sum of the sizes of its fields, but it is often larger due to **padding**. Compilers insert padding bytes to align fields to addresses that are multiples of their size (e.g., an `int` at a 4-byte boundary) to improve CPU access efficiency.

- **32-bit systems**: Typically align to 4-byte boundaries.
- **64-bit systems**: Typically align to 8-byte boundaries.
- **Rule of thumb**: The struct itself is aligned to the requirement of its largest member.

## C++ Structs

In C++, `struct` and `class` are nearly identical. The only difference is the default access level:

- **`struct`**: All members are public by default.
- **`class`**: All members are private by default.

## Related

- [[Introduction to C|Introduction to C]]
- [[Systems Programming/Memory Management/Heap Management|Heap Management]]
- [[LinkedList|LinkedList]]
- [[Systems Programming/C Fundamentals/Pointers|Pointers]]

## Industry Standard Terms

- **Struct** — Known as a "Plain Old Data" (POD) type or "aggregate" in C++ terminology
- **Alignment/Padding** — Controlled via `__attribute__((packed))` in GCC or `#pragma pack` on MSVC to eliminate padding when needed (e.g., network packet headers)
- **Shallow copy** — Copying only the struct's direct fields, not any heap data they point to; contrasted with a "deep copy" that recursively duplicates pointed-to data
