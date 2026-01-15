
# General Formula for upcasting
```c++
baseClass *name = &subClass
```

# Important
Take for example
```c++
Class One {
void m1() ...
virtual void m2()
}

Class Two : public One {
virtual void m1();
void m2();
}

int main() {
One* name1 = &Two; //upcasts one to two

name1->m1(); // calls One::m1

name1->m2(); // calls Two::m2
}
```
During upcasting the compiler will first read the pointer types functions and if a function that is being called is not virtual then it will call the pointers function. If it is virtual then it will look at the object types function and call that
# example

```c++
#include <iostream>
using namespace std;

class Animal {
public:
    virtual void Eat() { cout << "Animal eating" << endl; }
    virtual void Move() { cout << "Animal moving" << endl; }
    void Speak() { cout << "Animal making sound" << endl; }
};

class Dog : public Animal {
public:
    void Eat() override { cout << "Dog eating meat" << endl; }  // Virtual inherited from base
    void Move() override { cout << "Dog running" << endl; }     // Virtual inherited from base
    void Speak() { cout << "Dog barking" << endl; }            // Not virtual - hides base version
    void Fetch() { cout << "Dog fetching stick" << endl; }     // Dog-specific method
};

class Cat : public Animal {
public:
    void Eat() override { cout << "Cat eating fish" << endl; }  // Override virtual method
    // No Move() override - will use Animal::Move()
    // No Speak() override - will use Animal::Speak()
    void Purr() { cout << "Cat purring" << endl; }            // Cat-specific method
};

int main() {
    // Create objects
    Animal* animal = new Animal();
    Dog* dog = new Dog();
    Cat* cat = new Cat();
    
    cout << "=== Direct calls with correct pointer types ===" << endl;
    dog->Eat();    // Calls Dog::Eat()
    dog->Move();   // Calls Dog::Move()
    dog->Speak();  // Calls Dog::Speak()
    dog->Fetch();  // Calls Dog::Fetch()
    
    cat->Eat();    // Calls Cat::Eat()
    cat->Move();   // Calls Animal::Move() - not overridden in Cat
    cat->Speak();  // Calls Animal::Speak() - not virtual, so uses pointer type
    cat->Purr();   // Calls Cat::Purr()
    
    cout << "\n=== Calls after 
    upcasting to Animal* ===" << endl;
    // Upcasting
    Animal* animalDog = dog;    // Upcast Dog to Animal
    Animal* animalCat = cat;    // Upcast Cat to Animal
    
    animalDog->Eat();     // Calls Dog::Eat() - virtual function
    animalDog->Move();    // Calls Dog::Move() - virtual function
    animalDog->Speak();   // Calls Animal::Speak() - not virtual
    // animalDog->Fetch(); // Error: Animal has no member 'Fetch'
    
    animalCat->Eat();     // Calls Cat::Eat() - virtual function
    animalCat->Move();    // Calls Animal::Move() - Cat didn't override
    animalCat->Speak();   // Calls Animal::Speak() - not virtual
    // animalCat->Purr();  // Error: Animal has no member 'Purr'
    
    // Clean up
    delete animal;
    delete dog;
    delete cat;
    
    return 0;
}
```
