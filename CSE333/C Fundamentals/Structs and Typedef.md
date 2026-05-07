# CSE 333: Structs and Typedef

**Structs** are the most object-like feature in C, allowing for the collection of multiple fields into a single data type.

## Defining Structs
A struct is a **tag**, not a first-class type name on its own. 
```c
struct Point {
    float x, y;
};
struct Point origin = {0.0, 0.0};
```

## Using Typedef
**typedef** allows the creation of synonyms for types, making them easier to use.
```c
typedef struct point_st {
    float x, y;
} Point, *PointPtr;

Point p1;       // same as struct point_st
PointPtr p1_ptr = &p1;
```
**Warning**: Be careful with pointers in `typedef`. The `*` becomes part of the new type name.

## Accessing Fields
- **Dot operator (`.`)**: Access a field from a struct variable.
- **Arrow operator (`->`)**: Access a field from a struct pointer (shorthand for `(*p).field`).

## Self-Referential Structs
Structs can contain pointers to their own type, which is essential for building data structures like linked lists. Note that you must use the **struct tag** (e.g., `struct node`) inside the definition because the `typedef` name isn't available until the definition is complete.

```c
typedef struct node_st {
    int data;
    struct node_st* next;
} Node;
```

## Memory Behavior
- **Copy by Assignment**: Assigning one struct to another (e.g., `p2 = p1`) copies the **entire contents**.
- **Pass by Value**: Structs are passed by value to functions, meaning the entire struct is copied onto the stack. For large structs, it is more efficient to pass a pointer.
- **Returning Structs**: Can return structs by value. Small structs are often returned in registers (`%rax`, `%rdx`), while larger ones are returned via memory.

## Memory Alignment and Padding
The size of a struct is at least the sum of the sizes of its fields, but it is often larger due to **padding**. Compilers align fields to addresses that are multiples of their size (e.g., an `int` at a 4-byte boundary) to improve CPU access efficiency.

- **32-bit systems**: Typically align to 4-byte boundaries.
- **64-bit systems**: Typically align to 8-byte boundaries.
- **Rule of thumb**: The struct itself is aligned to the requirement of its largest member.

## C++ Structs
In C++, `struct` and `class` are nearly identical. The only difference is the default access level:
- **`struct`**: Public by default.
- **`class`**: Private by default.

## Related
- [[Introduction to C]]
- [[Memory Management/Heap Management|Heap Management]]
- [[Data Structures/LinkedList|LinkedList]]
- [[Pointers]]
