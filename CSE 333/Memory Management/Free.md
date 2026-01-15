After we malloc memory and we are done with it we must free the malloc in order for others to use the memory address or unexpected things can occur
# General
```c
int main() {
	int* ptr = (int*) malloc(sizeof(int));
	...
	free(ptr);
}
```
# Array
```c
int main() {
	type* ptr = (type*) malloc(n * sizeof(int));
	free(ptr);
} 
```

[[malloc]]