
View only pointer. Must be changed to a shared pointer with **.lock** in order to make changes to it.
[[Shared Pointer]]
```c++
#include <iostream>
#include <memory>
#include <vector>

/*
WHAT MAKES std::weak_ptr DIFFERENT:

- Non-owning Observer: Observes a shared resource without affecting its lifetime
- No Reference Count Increase: Doesn't increase the shared_ptr reference count
- Prevents Circular References: Key solution to shared_ptr circular reference memory leaks
- Access Via Locking: Must be converted to shared_ptr via lock() before accessing the resource
- Can Detect Deletion: Can check if the observed resource has been deleted
- No Direct Access: Cannot directly dereference like shared_ptr or unique_ptr
- Temporary Ownership: Can temporarily take ownership via lock() only if resource still exists
- No Automatic Resource Management: Not responsible for resource deletion
*/

// 1. Defining weak_ptr
void defining_weak_ptr() {
    // A weak_ptr must be initialized from a shared_ptr
    auto shared = std::make_shared<int>(42);
    
    // Create a weak_ptr observing the shared resource
    std::weak_ptr<int> weak1 = shared;
    
    // Alternative syntax
    std::weak_ptr<int> weak2(shared);
    
    // Create from another weak_ptr
    std::weak_ptr<int> weak3(weak1);
    
    // Default constructor (empty weak_ptr)
    std::weak_ptr<int> empty_weak;
    
    // Note: Cannot initialize directly from raw pointer
    // std::weak_ptr<int> invalid(new int(42)); // Error!
}

// 2. Using weak_ptr
void using_weak_ptr() {
    auto shared = std::make_shared<int>(42);
    std::weak_ptr<int> weak = shared;
    
    // Check if weak_ptr is empty
    if (weak.expired()) {
        std::cout << "Resource no longer exists" << std::endl;
    } else {
        std::cout << "Resource still exists" << std::endl;
    }
    
    // Get reference count of observed shared_ptr
    std::cout << "Use count: " << weak.use_count() << std::endl;
    
    // IMPORTANT: Cannot directly access the pointed object with weak_ptr
    // *weak;      // Error! No operator*
    // weak->foo;  // Error! No operator->
    
    // Must lock() to get a shared_ptr first
    if (auto shared_lock = weak.lock()) {
        // Successfully acquired shared_ptr
        std::cout << "Value: " << *shared_lock << std::endl;
        
        // Modify the value
        *shared_lock = 100;
    } else {
        // Resource was already deleted
        std::cout << "Resource no longer exists" << std::endl;
    }
}

// 3. Solving circular references (key use case)
void solving_circular_references() {
    struct Person {
        std::string name;
        // Using shared_ptr here would create a reference cycle
        std::weak_ptr<Person> friend_ptr;  // Weak reference to friend
        
        Person(const std::string& n) : name(n) {
            std::cout << "Creating " << name << std::endl;
        }
        
        ~Person() {
            std::cout << "Destroying " << name << std::endl;
        }
        
        void befriend(const std::shared_ptr<Person>& friend_person) {
            friend_ptr = friend_person;
        }
        
        void greet() {
            if (auto friend_shared = friend_ptr.lock()) {
                std::cout << name << " says hello to " << friend_shared->name << std::endl;
            } else {
                std::cout << name << "'s friend no longer exists" << std::endl;
            }
        }
    };
    
    // Create persons
    auto alice = std::make_shared<Person>("Alice");
    auto bob = std::make_shared<Person>("Bob");
    
    // Create a friendship (circular reference but with weak_ptr)
    alice->befriend(bob);
    bob->befriend(alice);
    
    // They can still interact
    alice->greet();
    bob->greet();
    
    // If we reset one shared_ptr, its object gets destroyed properly
    // despite the circular reference
    bob.reset();
    
    // Alice's weak_ptr to Bob is now expired
    alice->greet();  // Will show that Bob no longer exists
    
    // When alice goes out of scope, it will be properly destroyed
}

// 4. Caching with weak_ptr
void caching_with_weak_ptr() {
    // A simple cache using weak_ptr
    std::map<int, std::weak_ptr<std::string>> cache;
    
    // Function to get a resource, using cache if available
    auto get_resource = [&cache](int id) -> std::shared_ptr<std::string> {
        // Try to get from cache
        if (auto it = cache.find(id); it != cache.end()) {
            // Try to lock the weak_ptr
            if (auto resource = it->second.lock()) {
                std::cout << "Cache hit for ID " << id << std::endl;
                return resource;
            } else {
                std::cout << "Expired cache entry for ID " << id << std::endl;
            }
        }
        
        // Create new resource
        std::cout << "Creating new resource for ID " << id << std::endl;
        auto resource = std::make_shared<std::string>("Resource " + std::to_string(id));
        
        // Store in cache
        cache[id] = resource;
        
        return resource;
    };
    
    // Usage example
    {
        auto r1 = get_resource(1);  // Creates new
        auto r2 = get_resource(1);  // Uses cache
        
        // Let all shared_ptrs to resource 1 go out of scope
    }
    
    // Now the cache entry for ID 1 is expired
    auto r3 = get_resource(1);  // Creates new again
}

// 5. Observer pattern implementation
void observer_pattern() {
    class Subject {
    private:
        std::vector<std::weak_ptr<class Observer>> observers;
        
    public:
        void register_observer(std::shared_ptr<Observer> observer) {
            observers.push_back(observer);
        }
        
        void notify_all();
    };
    
    class Observer {
    public:
        virtual void update() = 0;
        virtual ~Observer() = default;
    };
    
    // Implementation of notify_all
    Subject::notify_all = [this]() {
        // Remove expired observers while notifying active ones
        auto it = observers.begin();
        while (it != observers.end()) {
            if (auto observer = it->lock()) {
                observer->update();
                ++it;
            } else {
                // Remove expired observer
                it = observers.erase(it);
            }
        }
    };
}

// 6. Resetting and assignment
void resetting_and_assignment() {
    auto shared1 = std::make_shared<int>(42);
    auto shared2 = std::make_shared<int>(100);
    
    std::weak_ptr<int> weak1 = shared1;
    
    // Assign to another shared_ptr
    weak1 = shared2;
    
    // Reset to empty
    weak1.reset();
    
    // Check if empty
    if (weak1.expired()) {
        std::cout << "weak1 is expired" << std::endl;
    }
    
    // Swap two weak_ptrs
    std::weak_ptr<int> weak2 = shared2;
    weak1.swap(weak2);
}
```
[[Shared Pointer]]