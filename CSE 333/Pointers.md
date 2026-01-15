# Pointer:
	- Points to an object in memory (memory address)
```c
	int main(int argc, char** argv) {
		int b = 5;
		int* a = &b; // points to the memory address b
		int aValue = *a // dereferences a and gets the value

		int* c = 5; // causes an error since it cannot point to a value

		*a = 10; // changes the value at memory address &b to 10
	}
```
[[malloc]]
[[Free]]
