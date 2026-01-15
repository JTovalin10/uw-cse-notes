When dereferencing a pointer you gain access to the value of the address
```c++
	int main() {
		int num = 5;
		int* ptr = &num; // points the the address of num
		printf('%d', *ptr) // prints 5
	}
```
# Benefits
This will allow us to change the value of a ptr across functions without returning
```c++
int main() {
	int num = 5;
	int* ptr = &num;
	change(&ptr);
}

void main(int* ptr2) {
	*ptr2 = 20; // changes the value of ptr to 20
}
```
[[Pointers]]