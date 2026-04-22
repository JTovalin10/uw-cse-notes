The virtual keyword is what allows C++ to have polymorphism and inheritance. It enables:

- **Enables Function overriding**: Signals that this method can be overridden in derived classes
- **Enables Dynamic Dispatch**: The function call is resolved at runtime based on the actual type of the object and not just the pointer type or reference type
- **Creates a v-table**: The compiler creates a virtual function table that keeps track of which implementation should be called for each object

When a class contains virtual functions, the compiler creates a hidden v-table (virtual table) for that class. Each object of the class contains a hidden pointer to this v-table. When a virtual function is called through a pointer or reference, the program looks up the correct function implementation in the v-table.

Virtual functions have a slight performance overhead due to this runtime lookup, but this cost is minimal compared to the flexibility they provide. The virtual mechanism is the foundation of polymorphic behavior in C++.

[[Vector]]
[[override]]