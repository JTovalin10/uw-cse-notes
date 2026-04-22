# CSE333: Free

After we allocate memory on the [[Heap]] using [[Malloc]], we must **free** that memory once we are done with it. This allows the operating system to reclaim the memory address for other uses. Failing to do so results in memory leaks.

## General Usage

```c
int main() {
    int* ptr = (int*)malloc(sizeof(int));
    // ... use ptr ...
    free(ptr); // Release the memory
}
```

## Freeing Arrays

```c
int main() {
    int* ptr = (int*)malloc(n * sizeof(int));
    // ... use ptr ...
    free(ptr); // Only one free() is needed for the entire block
} 
```

## Double Free Error

A **Double Free** occurs when `free()` (or `delete` in C++) is called more than once on the same memory address. This causes undefined and unexpected behavior (often a crash or security vulnerability). **Never do it.**

To prevent double frees, it is good practice to set pointers to `NULL` (or `nullptr`) immediately after freeing them:

```c
free(ptr);
ptr = NULL;
```

## Related
- [[CSE333/Memory Management/Malloc|Malloc]]
- [[CSE333/Memory Management/Heap|Heap]]
- [[CSE333/Smart Pointers/Dynamic Memory (new and delete)|Dynamic Memory (new and delete)]]