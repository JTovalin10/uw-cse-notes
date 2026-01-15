# Static Cast
Casting between related types (leave to primitive types)
```c++
static_cast<type_to>(expression);
```
# Dynamic cast
Casting to pointers of similar types (only with inheritance)
used for upcasting
```c++
dynamic_cast<type_to>(expression);
Derived* a = dynamic_cast<Derived*>(b);
```
# Const cast
adding or removing const of a type
```c++
const_cast<type_to>(expression);
```
# Reinterpret cast
Casting between incompatible types of the same size (no float ocnversion)
```c++
reinterpret_cast<type_to>(expression);
```