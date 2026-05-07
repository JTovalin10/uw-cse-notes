# CSE 333: OOP Principles

This file covers the four pillars of Object-Oriented Programming with practical C++ examples.

## 1. Encapsulation
**Encapsulation** is the bundling of data and the methods that operate on that data into a single unit (the class), while restricting direct access to some of the object's components.

```cpp
class BankAccount {
 public:
  void Deposit(double amount) {
    if (amount > 0) balance_ += amount; // Enforcing invariants
  }
  double get_balance() const { return balance_; }

 private:
  double balance_ = 0.0; // Information Hiding: users cannot modify directly
};
```

## 2. Abstraction
**Abstraction** is the process of hiding complex implementation details and showing only the necessary features of an object. In C++, this is often achieved via **Interfaces** (Pure Abstract Classes).

```cpp
// The Interface (Contract)
class Database {
 public:
  virtual ~Database() {}
  virtual void Connect() = 0; // "What" it does, not "How"
};

// The Implementation
class SQLDatabase : public Database {
 public:
  void Connect() override { /* Complex socket/handshake logic */ }
};
```

## 3. Inheritance
**Inheritance** allows a class to derive features from another class, establishing an "is-a" relationship.

```cpp
class Animal {
 public:
  void Eat() { std::cout << "Eating..." << std::endl; }
};

class Dog : public Animal { // Dog "is-a" Animal
 public:
  void Bark() { std::cout << "Woof!" << std::endl; }
};
```

## 4. Polymorphism
**Polymorphism** allows objects of different types to be treated as objects of a common base type, typically through **Dynamic Dispatch**.

```cpp
void Feed(Animal* a) {
    a->Eat(); // Behavior depends on the actual object type at runtime
}
```

## Related
- [[C++ Classes]]
- [[Inheritance]]
- [[Object Lifecycle]]
- [[C++ Casting]]
