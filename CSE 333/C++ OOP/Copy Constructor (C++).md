# Creating a copy constructor
```c++
// we need the &Vector or it will fail
Vector(const Vector& other) {
	this.x_ = other.y_
	...
	...
}
```

# Default copy constructor
If no copy constructor is defined it will create a shallow copy which will make it so this points to the others memory address.

to add: a default copy constructor creates a shallow copy by copying each member variable's value. This becomes problematic when the class contains ***pointers***, as both objects will point to the same memory.

This is bad as it could cause mutations and if multiple frees which would cause undefined behavior
[[Pointers]]
[[Double Free (Delete)]]

# Calling copy constructor in main
```c++

// one when returning because we do not have &copyVal
Vector copyVal(Vector name) {
	return name;
}

// This calls copy constructor one as there is not Vector &copyVector
Vector copyVector(Vector &name) {
	return name;
}

// this does not call copy constructor as we have a reference to the
// copy
Vector &goodCopy(Vector &name) {
	return name;
}
```
