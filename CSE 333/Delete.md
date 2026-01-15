# General
```c++
Template <typename T>
int main() {
	T* temp = new T(n);
	// to free all we do is
	delete temp;
}
```
# Arrays
```c++
Template <typename T>
int main() {
	T* temp = new T[n];
	delete [] temp;
}
```

[[new]]