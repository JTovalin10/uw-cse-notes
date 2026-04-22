# CSE333: Pointers

A **pointer** is a variable that stores the memory address of another object.

```c
int main(int argc, char** argv) {
    int b = 5;
    int* a = &b; // 'a' points to the memory address of 'b'
    
    // int* c = 5; // ERROR: cannot point to a literal value
    
    *a = 10; // Changes the value at memory address &b to 10
}
```

## Dereferencing a Pointer

When **dereferencing** a pointer, you gain access to the value stored at the address it points to using the `*` operator.

```c
int main() {
    int num = 5;
    int* ptr = &num; // Points to the address of 'num'
    printf("%d", *ptr); // Prints 5
}
```

### Benefits: Cross-Function Modification

Pointers allow us to change the value of a variable across function boundaries without needing to return a new value.

```c
void changeValue(int* ptr2) {
    *ptr2 = 20; // Changes the value at the pointed address to 20
}

int main() {
    int num = 5;
    changeValue(&num); // num is now 20
}
```

## Related
- [[CSE333/Memory Management/Malloc|Malloc]]
- [[CSE333/Memory Management/Free|Free]]
- [[CSE333/Memory Management/Heap|Heap]]
- [[CSE333/Memory Management/Stack|Stack]]
