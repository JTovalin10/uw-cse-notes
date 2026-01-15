When we need dynamic memory we use malloc as it uses the heap [[heap]]
# General
```c
int main() {
	type* name = (type*) malloc(sizeof(type));
}
```
# Array
```c
int main() {
	// n is the number of elements of the array
	type* name = (type*) malloc(n * sizeof(type));
	name[0];
	name[1];
	...
}
```
# Copying a char* (string)
```c
int main() {
	char* word = {...};
	// gets the size of the char* then adds 1 to the end for the
	// null character ('\0')
	(char*) mallocedWord = (char*) malloc(strlen(word) + 1);
}
```

[[Free]]