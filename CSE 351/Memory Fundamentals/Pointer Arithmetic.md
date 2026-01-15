# Pointer Arithmetic

Pointer arithmetic automatically scales operations by the size of the data type being pointed to. Think of it as changing units from bytes to "elements."

**Related:** [[Pointers]], [[Arrays]], [[Memory Addressing Modes]]

---

## Adding an Integer to a Pointer

Calculates the memory address of an element a certain number of places away.

**Formula:** `New Address = Current Address + (Integer * sizeof(Data Type))`

### `int` Pointer (4 bytes)
```
Operation: p1 + 3
Address: 0x1000
Calculation: 0x1000 + (3 * 4) = 0x100c
```

### `char` Pointer (1 byte)
```
Operation: p1 + 3
Address: 0x1000
Calculation: 0x1000 + (3 * 1) = 0x1003
```

---

## Subtracting Two Pointers

Returns the **number of elements** between two addresses (not bytes).

**Formula:** `Element Difference = (Address2 - Address1) / sizeof(Data Type)`

### `int` Pointers Example
```
p1 Address: 0x1000
p2 Address: 0x1030
Byte Difference: 0x30 = 48 bytes
Element Difference: 48 / 4 = 12 elements (0xc in hex)
```

---

## Array Subscript Connection

The subscript operator `ar[i]` is syntactic sugar for pointer arithmetic:

```c
ar[i] == *(ar + i)
```

This is why arrays and pointers are closely related in C.

**Related:** [[Arrays]], [[x86-64 Memory Operands]]
