# CSE333: Linked Lists

**Linked Lists** are dynamic data structures where each element (node) is a separate object allocated on the heap. Unlike arrays, nodes are not stored in contiguous memory but are linked together using pointers.

## Building a Linked List Node by Node

When creating a linked list in C, we must allocate memory for each node individually using `malloc()`.

```c
typedef struct Node {
    int data;
    struct Node* next;
} Node;

int main() {
    Node* head = NULL;  // Start with an empty list
    
    // Add first node
    head = (Node*)malloc(sizeof(Node));
    head->data = 10;
    head->next = NULL;
    
    // Add second node
    head->next = (Node*)malloc(sizeof(Node));
    head->next->data = 20;
    head->next->next = NULL;
    
    // Add third node
    head->next->next = (Node*)malloc(sizeof(Node));
    head->next->next->data = 30;
    head->next->next->next = NULL;
    
    // Free all nodes
    Node* current = head;
    while (current != NULL) {
        Node* temp = current;      // Save current node
        current = current->next;   // Move to next node before freeing
        free(temp);                // Free the saved node
    }
}
```

## Memory Visualization for Linked List

|Stack Variables|Value|Points To|
|---|---|---|
|head|0xA100|(first node on heap)|
|current|varies during traversal|varies|
|temp|varies during cleanup|varies|

|Heap Address|Structure Contents|Points To|Notes|
|---|---|---|---|
|0xA100|{data: 10, next: 0xA200}|0xA200|First node (malloc #1)|
|0xA200|{data: 20, next: 0xA300}|0xA300|Second node (malloc #2)|
|0xA300|{data: 30, next: NULL}|NULL|Third node (malloc #3)|

## Better Approach: Function for Node Creation

A cleaner approach uses helper functions to manage the list:

```c
Node* createNode(int value) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    if (newNode == NULL) {
        exit(1);
    }
    newNode->data = value;
    newNode->next = NULL;
    return newNode;
}

void appendNode(Node** headRef, int value) {
    Node* newNode = createNode(value);
    if (*headRef == NULL) {
        *headRef = newNode;
        return;
    }
    Node* last = *headRef;
    while (last->next != NULL) {
        last = last->next;
    }
    last->next = newNode;
}
```

## Key Points About Linked List Memory Management

1. **Individual Allocation**: Each node requires a separate **malloc()** call.
2. **Traversal Order**: You must allocate new memory for each new node on the heap.
3. **Memory Leaks**: Losing the reference to a node without calling **[[Free|free()]]** causes memory leaks.
4. **Free Order**: When deallocating, save the `next` pointer before freeing the current node.
5. **Dangling Pointers**: After freeing a node, any pointers to it become dangling pointers and should not be used.

## Related
- [[CSE333/Memory Management/Malloc]]
- [[CSE333/Memory Management/Free]]
- [[CSE333/Data Structures/Struct]]
- CSE333/Memory Management/Double Free (Delete)
