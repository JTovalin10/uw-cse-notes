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

## Memory Behavior
- **Copy by Assignment**: Assigning one struct to another (e.g., `p2 = p1`) copies the **entire contents**.
- **Pass by Value**: Structs are passed by value to functions, meaning the entire struct is copied onto the stack. For large structs, it is more efficient to pass a pointer.
- **Returning Structs**: Can return structs by value. Small structs are often returned in registers (`%rax`, `%rdx`), while larger ones are returned via memory.

Related: [[C Fundamentals/Introduction to C]], [[Memory Management/Heap Management]]
