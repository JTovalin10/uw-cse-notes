## Union: The "Or" Type 🧺

A **union** combines types by saying a value can be **one type _OR_ another**.

- **Formal Definition:** A∪B is a value that is either in set A or in set B.
    
- **Simple Analogy:** Imagine you have a basket that can hold either an **apple** or a **banana**. The basket's type is `Apple ∪ Banana`. A single item in the basket will be one or the other.
    
- **Example:** A variable that could store either a number (`Integer`) or an error message (`String`) would have a union type.
    

---

## Tuple: The "Ordered Pair" Type ➡️

A **tuple** combines types into a **fixed-size, ordered list**. The position of each item is what identifies it.

- **Formal Definition:** A×B is a pair (a,b) where the first item _must_ be from type A and the second _must_ be from type B.
    
- **Simple Analogy:** Think of a 2D coordinate like **(10, 20)**. The order is crucial; **(10, 20)** is a different point from **(20, 10)**. You know the first number is always the x-coordinate and the second is always the y-coordinate based on its position.
    
- **Accessing Parts:** Since there are no names, you "unpack" it or access by index. If you have a tuple `t = (10, 20)`, the expression `let (a, b) := t` assigns `a = 10` and `b = 20`.
    

---

## Record: The "Named Pair" Type 🏷️

A **record** also combines types, but each item is identified by a **name or label**, not its position.

- **Formal Definition:** `{x: A, y: B}` is an object where the field named "x" has a value from type A, and the field named "y" has a value from type B.
    
- **Simple Analogy:** Think of a contact card: `{name: "Alex", age: 30}`. You access the data by its label. You ask for the "name" to get "Alex". The order doesn't matter; `{age: 30, name: "Alex"}` is the exact same record.
    
- **Accessing Parts:** You use the names (often with "dot notation"). If your record is `f = {x: 10, y: 20}`, you get the number 10 by writing `f.x`.
    

---

## Expanded: Tuple vs. Record — Position vs. Name

Both tuples and records bundle multiple values together. The choice between them comes down to a trade-off between conciseness and clarity. The core difference is **how you access and interpret the data** 
####  1. Method of Access

- **Tuple:** Access is **positional**. You refer to elements by their index (e.g., the 1st element, 2nd element).
    
    - `let my_tuple = ("Alice", 30)`
        
    - To get the values, you must unpack them based on order: `let (name, age) = my_tuple`.
        
- **Record:** Access is by **name**. You refer to elements by their label.
    
    - `let my_record = {name: "Alice", age: 30}`
        
    - To get a value, you use its name: `let name = my_record.name`.
        

#### 2. Readability and Self-Description

This is the most important practical difference.

- **Tuple:** A tuple is **anonymous**. Looking at the type `(String, Integer)`, you don't inherently know what it represents. Is it a name and an age? A city and a zip code? A product and its inventory count? You need external context to understand its meaning.
    
- **Record:** A record is **self-describing**. The type `{name: String, age: Integer}` makes its purpose immediately obvious. The names `name` and `age` act as documentation, making the code easier to read and understand.
    

####  3. Rigidity and Order

- **Tuple:** **Order is everything.** The type `(String, Integer)` is completely different from `(Integer, String)`. Swapping the elements creates a new, distinct value.
    
- **Record:** **Order is irrelevant.** A record defined as `{name: String, age: Integer}` is identical to one defined as `{age: Integer, name: String}`. As long as the names and their corresponding types are the same, the records are equivalent.
    

####  4. Use Cases

- **When to use a Tuple:**
    
    - For short-lived, temporary data where the context is obvious.
        
    - When returning a small, fixed number of values from a function. For example, a function might return `(result, error_code)`.
        
    - For data where the position has a universally understood meaning, like 2D/3D coordinates `(x, y, z)`.
        
- **When to use a Record:**
    
    - For most other cases, especially for data that represents a clear concept.
        
    - When defining the structure of data that will be used in many places (like a User, Product, or Settings object).
        
    - When the data structure might change in the future (adding a new named field to a record is much safer than adding a new element in the middle of a tuple).
        

In summary, while a tuple `("Alice", 30)` and a record `{name: "Alice", age: 30}` hold the same raw data, the record is far more explicit, readable, and maintainable in the long run.

[[Data Types]]