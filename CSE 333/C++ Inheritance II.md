Abstract Class [[C++ Inheritance I]]
- Create a function in a class but only use it in subclasses
- A class that contains only virtual methods it is a "abstract" class
```c++
	virtual string noise() = 0;
```
Constructors and inheritance
- subclasses does not inherit constructor so it must create its own
- If not constructor given it will call the default constructor of its superclass
```c++
	class Base {
		public:
			Base(int y) {}
	}

	Class temp : public Base {
		// wont compile because no default constructor in Base
	}

	Class Base2 {
		public:
			Base() {...}
	}

	Class temp2 {
		public: 
			// this will compile since there is a default constructor
	}
```