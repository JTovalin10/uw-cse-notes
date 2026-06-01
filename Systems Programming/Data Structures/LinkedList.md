# CSE333: Linked Lists

**Linked Lists** are dynamic data structures where each element (node) is a separate object allocated on the heap. Unlike arrays, nodes are not stored in contiguous memory but are connected using pointers, making insertions and deletions efficient without shifting elements.

## Building a Linked List Node by Node

When creating a linked list in C, we must allocate memory for each node individually using `malloc()`. The self-referential [[Structs and Typedef|struct]] pattern is essential here.

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

    // Free all nodes (must save next pointer before freeing)
    Node* current = head;
    while (current != NULL) {
        Node* temp = current;      // Save current node
        current = current->next;   // Advance BEFORE freeing
        free(temp);                // Free the saved node
    }
}
```

## Memory Visualization

| Stack Variable | Value | Points To |
|---|---|---|
| `head` | `0xA100` | First node on heap |
| `current` | Varies during traversal | Varies |
| `temp` | Varies during cleanup | Varies |

| Heap Address | Structure Contents | Points To | Notes |
|---|---|---|---|
| `0xA100` | `{data: 10, next: 0xA200}` | `0xA200` | First node (malloc #1) |
| `0xA200` | `{data: 20, next: 0xA300}` | `0xA300` | Second node (malloc #2) |
| `0xA300` | `{data: 30, next: NULL}` | `NULL` | Third node (malloc #3) |

## Better Approach: Helper Functions

A cleaner approach uses dedicated helper functions to encapsulate node creation and list manipulation:

```c
Node* createNode(int value) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    if (newNode == NULL) {
        exit(1); // malloc failed
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

Note that `appendNode` takes a `Node**` (pointer to pointer) so it can modify the caller's `head` variable if the list is empty.

## Key Points About Memory Management

1. **Individual Allocation**: Each node requires a separate `malloc()` call.
2. **Traversal Order**: Allocate a new node on the heap for each new element; never point to stack memory.
3. **Memory Leaks**: Losing a reference to a node without calling [[Malloc and Free|free()]] causes a memory leak.
4. **Free Order**: When deallocating, always save the `next` pointer before freeing the current node — once freed, the memory may be overwritten.
5. **Dangling Pointers**: After freeing a node, any pointers to it become dangling pointers and must not be used.

## Related

- [[Malloc and Free|Malloc and Free]]
- [[Structs and Typedef|Structs and Typedef]]
- [[Systems Programming/Memory Management/Heap Management|Heap Management]]
- [[Vector|Vector]]

## Industry Standard Terms

- **Linked list** — A fundamental dynamic data structure; in C++ the standard library provides `std::list` (doubly-linked) and `std::forward_list` (singly-linked)
- **Singly-linked list** — Each node has only a `next` pointer; traversal is O(n), insertion at head is O(1)
- **Double pointer (`Node**`)** — Also called a "pointer to pointer" or "handle"; used in C to allow functions to modify a caller's pointer variable (e.g., reassigning `head`)
