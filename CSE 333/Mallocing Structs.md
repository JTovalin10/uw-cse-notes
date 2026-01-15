# Linked Lists and Dynamic Memory Allocation

## Building a Linked List Node by Node

When creating a linked list, we must allocate memory for each node individually as we build or traverse the list.

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
    // We must allocate a new node for the "next" pointer
    head->next = (Node*)malloc(sizeof(Node));
    head->next->data = 20;
    head->next->next = NULL;
    
    // Add third node - another separate allocation
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

A cleaner approach uses a helper function to create nodes:

```c
// Function to create a new node
Node* createNode(int value) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    if (newNode == NULL) {
        printf("Memory allocation failed\n");
        exit(1);
    }
    newNode->data = value;
    newNode->next = NULL;
    return newNode;
}

// Function to append node to end of list
void appendNode(Node** headRef, int value) {
    Node* newNode = createNode(value);
    
    // If list is empty
    if (*headRef == NULL) {
        *headRef = newNode;
        return;
    }
    
    // Find the last node
    Node* last = *headRef;
    while (last->next != NULL) {
        last = last->next;
    }
    
    // Append new node
    last->next = newNode;
}

int main() {
    Node* head = NULL;
    
    // Create a linked list with 3 nodes
    appendNode(&head, 10);
    appendNode(&head, 20);
    appendNode(&head, 30);
    
    // Traverse and print list
    Node* current = head;
    while (current != NULL) {
        printf("%d -> ", current->data);
        current = current->next;
    }
    printf("NULL\n");
    
    // Free all nodes
    current = head;
    while (current != NULL) {
        Node* temp = current;
        current = current->next;
        free(temp);
    }
}
```

## Common Operations and Memory Management

### Inserting a Node at the Beginning

```c
void insertAtBeginning(Node** headRef, int value) {
    Node* newNode = createNode(value);
    newNode->next = *headRef;  // Point to current head
    *headRef = newNode;        // Update head to new node
}
```

### Inserting a Node in the Middle

```c
void insertAfterNode(Node* prevNode, int value) {
    if (prevNode == NULL) {
        printf("Previous node cannot be NULL\n");
        return;
    }
    
    Node* newNode = createNode(value);
    newNode->next = prevNode->next;  // Link new node to next node
    prevNode->next = newNode;        // Link previous node to new node
}
```

### Deleting a Node (with Memory Management)

```c
void deleteNode(Node** headRef, int key) {
    Node* temp = *headRef;
    Node* prev = NULL;
    
    // If head node itself holds the key
    if (temp != NULL && temp->data == key) {
        *headRef = temp->next;  // Change head
        free(temp);             // Free old head
        return;
    }
    
    // Search for the key, keeping track of previous node
    while (temp != NULL && temp->data != key) {
        prev = temp;
        temp = temp->next;
    }
    
    // If key not found
    if (temp == NULL) return;
    
    // Unlink the node from list
    prev->next = temp->next;
    
    // Free memory
    free(temp);
}
```

## Key Points About Linked List Memory Management

1. **Individual Allocation**: Each node requires a separate `malloc()` call
    
2. **Traversal Order**: When traversing to add nodes, you must allocate new memory for each new node:
    
    ```c
    // INCORRECT - This causes undefined behavior!
    Node node1;             // Stack allocation
    node1.data = 10;
    node1.next = &node2;    // Pointing to another stack variable
    
    // CORRECT - Each node on heap with malloc
    Node* node1 = (Node*)malloc(sizeof(Node));
    Node* node2 = (Node*)malloc(sizeof(Node));
    node1->next = node2;
    ```
    
3. **Memory Leaks**: Losing the reference to a node (e.g., by overwriting a pointer) without freeing it first causes memory leaks:
    
    ```c
    // LEAK - Lost reference to original node
    head = (Node*)malloc(sizeof(Node));
    head->data = 10;
    head = (Node*)malloc(sizeof(Node));  // Lost first node!
    ```
    
4. **Free Order**: When deallocating a linked list, you must keep track of the next node before freeing the current one:
    
    ```c
    // INCORRECT - Accessing freed memory
    while (current != NULL) {
        free(current);              // Free current node
        current = current->next;    // Error! Accessing freed memory
    }
    
    // CORRECT - Save next node before freeing
    while (current != NULL) {
        Node* temp = current;
        current = current->next;
        free(temp);
    }
    ```
    
5. **Dangling Pointers**: After freeing a node, any pointers to it become dangling pointers and should not be used:
    
    ```c
    Node* node = (Node*)malloc(sizeof(Node));
    free(node);
    node->data = 5;  // Undefined behavior! Accessing freed memory
    ```
    

By understanding these principles, you can effectively manage memory when working with linked lists, avoiding leaks and undefined behavior.

[[malloc]]
[[Struct]]
[[Free]]
[[Double Free (Delete)]]