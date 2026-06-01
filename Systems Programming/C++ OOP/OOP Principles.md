# CSE333: OOP Principles

This file covers the four pillars of Object-Oriented Programming with practical C++ examples. These principles are the conceptual foundation for [[C++ Classes|C++ Classes]] and [[Inheritance|Inheritance]].

## 1. Encapsulation

**Encapsulation** is the bundling of data and the methods that operate on that data into a single unit (the class), while restricting direct access to some of the object's components. This enforces **invariants** — conditions that must always be true about the object's internal state.

```cpp
class BankAccount {
 public:
  void Deposit(double amount) {
    if (amount > 0) balance_ += amount; // Enforcing invariant: balance never goes up by negative amount
  }
  double get_balance() const { return balance_; }

 private:
  double balance_ = 0.0; // Information Hiding: users cannot modify balance directly
};
```

Without encapsulation, external code could set `balance_` to any value, including negative or corrupted values.

## 2. Abstraction

**Abstraction** is the process of hiding complex implementation details and exposing only the necessary features of an object. In C++, this is most commonly achieved via **Interfaces** (Pure Abstract Classes). The caller knows *what* an object does, but not *how*.

```cpp
// The Interface (Contract) — the "what"
class Database {
 public:
  virtual ~Database() {}
  virtual void Connect() = 0;
  virtual void Query(const std::string& sql) = 0;
};

// The Implementation — the "how" (hidden from callers)
class SQLDatabase : public Database {
 public:
  void Connect() override { /* Complex TCP socket / authentication logic */ }
  void Query(const std::string& sql) override { /* SQL parsing and execution */ }
};
```

## 3. Inheritance

**Inheritance** allows a class to derive features from another class, establishing an "is-a" relationship. The derived class reuses the base class's interface and implementation.

```cpp
class Animal {
 public:
  void Eat() { std::cout << "Eating..." << std::endl; }
};

class Dog : public Animal { // Dog "is-a" Animal
 public:
  void Bark() { std::cout << "Woof!" << std::endl; }
};

Dog d;
d.Eat();  // Inherited from Animal
d.Bark(); // Dog-specific behavior
```

For a full treatment of inheritance mechanics, constructors, destructors, and abstract classes, see [[Inheritance|Inheritance]].

## 4. Polymorphism

**Polymorphism** allows objects of different types to be treated as objects of a common base type, with the correct behavior selected at runtime via **dynamic dispatch**.

```cpp
void Feed(Animal* a) {
    a->Eat(); // Calls the correct Eat() for whatever Animal type is passed
}

Dog dog;
Cat cat;
Feed(&dog); // Works for Dog
Feed(&cat); // Works for Cat
```

This is what enables writing a `Renderer` that renders any `Shape`, or a server that handles any `Request`, without knowing the specific subtype at compile-time.

## Related

- [[C++ Classes|C++ Classes]]
- [[Inheritance|Inheritance]]
- [[Object Lifecycle|Object Lifecycle]]
- [[C++ Casting|C++ Casting]]

## Industry Standard Terms

- **Encapsulation** — Also called "information hiding"; enforced via `private` and `protected` access specifiers in C++
- **Abstraction** — Hiding implementation complexity behind an interface; related to the "Dependency Inversion Principle" (the D in SOLID)
- **Inheritance** — "is-a" relationship; promotes code reuse but can increase coupling; contrasted with "composition" ("has-a"), which is often preferred
- **Polymorphism** — "Many forms"; enables writing code against abstractions rather than concrete implementations; the foundation of the Strategy, Observer, and Factory design patterns
