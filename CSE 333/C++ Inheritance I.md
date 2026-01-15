``` c++
class DividendedStock : public Stock {...}
```
the ":" is the same as extends as in Java, you can extend multiple classes but focus on a single one

``` c++
public: "shown to all classes"
protected: "visible to current and subclasses"
private: "only visible to current class"
// optional
virtual: "enables dynamic dispatch - tells the compiler to determine             which 
          function to call at runtime based on the actual object type,           not 
         the pointer type. Creates a vtable entry allowing the                  function to be 
         properly overridden in derived classes."
override: "tells the compiler that the method should be overriding an
         inherited virtual function"
```

Derived Classes (sub-class)
```C++
inherits: "Behavior and specs from the superclass"
overrides: "some of the base class's member functions"
Extends: "the base class with new member functions and variables"
```

Most Derived (Dynamic-Dispatch)
The most-derived function accessible to the object's visible type is invoked

```c++
class A {
	virtual void Foo() {}
}

Class B : public A {
	void Foo() override {}
}

Class C : public B {

}
```
If we call ```C c->Foo()``` it will use the closest superclass with that function so in this case it will call B, if C has its own Foo() it will call C::Foo()