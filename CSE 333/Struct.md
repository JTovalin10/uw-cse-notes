A struct is a collection of variables
```c
typedef struct struct_name {
	type name;
	type name2;
	...
} name;

int main() {
...
}
```
The size of the struct depends on all the types inside: char, int, double would be 13 bytes

It is important to note that structs can point to another struct (like a linked-list)
```c
typedef struct linked_list {
    char* name;
    struct linked_list* next;  // Must use the struct tag name here
} linkedlist, *linkedlist_ptr; // this creates two typedef's one 
// for the struct and one for a pointer to the struct
```
# Padding
## 32-bit system
In a 32-bit system it would pad to the nearest 4x byte
```
	3-byte struct $\rightarrow$ 4 bytes
	5-byte struct $\rightarrow$ 8 bytes
	13-byte struct $\rightarrow$ 16 bytes
```
## 64-bit System
In a 64-bit system it will pad to the nearest 8x byte
[[Data Type Bytes]]