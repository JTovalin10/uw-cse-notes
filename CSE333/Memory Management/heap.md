# The Heap and Dynamic Memory Allocation

Unlike the stack, the heap is used for dynamic memory allocation that persists beyond function calls and local scope.

## Basic Heap Operations

```c
int main() {
    // Stack allocation
    int stackVar = 5;
    
    // Heap allocation
    int* heapVar = (int*)malloc(sizeof(int));
    *heapVar = 10;
    
    // More heap allocation
    char* str = (char*)malloc(50 * sizeof(char));
    strcpy(str, "Hello World");
    
    // Cleanup
    free(heapVar);
    free(str);
}
```

## Memory Visualization

|Stack Variables|Value|Points To|
|---|---|---|
|stackVar|5|N/A|
|heapVar|0x7A24|(address in heap)|
|str|0x8B36|(address in heap)|

|Heap Address|Value|Notes|
|---|---|---|
|0x7A24|10|Int allocated by malloc|
|0x8B36|'H'|Start of string|
|0x8B37|'e'|Character in string|
|0x8B38|'l'|Character in string|
|...|...|...|

## Multiple Allocations Example

```c
int main() {
    int* numbers = (int*)malloc(3 * sizeof(int));
    numbers[0] = 100;
    numbers[1] = 200;
    numbers[2] = 300;
    
    char** names = (char**)malloc(2 * sizeof(char*));
    names[0] = (char*)malloc(10 * sizeof(char));
    names[1] = (char*)malloc(10 * sizeof(char));
    
    strcpy(names[0], "Alice");
    strcpy(names[1], "Bob");
    
    // Cleanup
    free(numbers);
    free(names[0]);
    free(names[1]);
    free(names);
}
```

## Complex Heap Visualization

|Stack Variables|Value|Points To|
|---|---|---|
|numbers|0x5000|(address in heap)|
|names|0x6000|(address in heap)|

|Heap Address|Value|Notes|
|---|---|---|
|0x5000|100|First int in array|
|0x5004|200|Second int in array|
|0x5008|300|Third int in array|
|0x6000|0x7000|Pointer to first string|
|0x6008|0x7100|Pointer to second string|
|0x7000|'A'|Start of "Alice"|
|0x7001|'l'|Character in string|
|...|...|...|
|0x7100|'B'|Start of "Bob"|
|...|...|...|

## Linked List Example

```c
typedef struct Node {
    int data;
    struct Node* next;
} Node;

int main() {
    // Create first node
    Node* head = (Node*)malloc(sizeof(Node));
    head->data = 1;
    head->next = NULL;
    
    // Add second node
    head->next = (Node*)malloc(sizeof(Node));
    head->next->data = 2;
    head->next->next = NULL;
    
    // Add third node
    head->next->next = (Node*)malloc(sizeof(Node));
    head->next->next->data = 3;
    head->next->next->next = NULL;
    
    // Cleanup
    Node* current = head;
    while (current != NULL) {
        Node* temp = current;
        current = current->next;
        free(temp);
    }
}
```

## Linked List Visualization

|Stack Variables|Value|Points To|
|---|---|---|
|head|0xA100|(address in heap)|
|current|varies during cleanup|varies|
|temp|varies during cleanup|varies|

|Heap Address|Value/Structure|Points To|
|---|---|---|
|0xA100|{data: 1, next: 0xA200}|0xA200|
|0xA200|{data: 2, next: 0xA300}|0xA300|
|0xA300|{data: 3, next: NULL}|NULL|

## Key Points

1. Stack variables (including pointers) are automatically managed
2. Heap memory must be explicitly allocated (malloc) and freed (free)
3. Pointers connect stack variables to heap memory
4. The value of a pointer is an address in the heap
5. Forgetting to free heap memory causes memory leaks
6. Using freed memory causes undefined behavior
7. Heap memory persists until explicitly freed, regardless of scope

[[CSE333/Memory Management/stack]]