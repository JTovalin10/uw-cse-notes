This slide explains why you **cannot create arrays of generic types** in Java.

### The Problem

```java
class Foo<E> {
    private E[] data;
    
    public Foo() {
        this.data = new E[10];  // ILLEGAL!
    }
}
```

### Why It's Illegal

Two things conflict:

1. **Type Erasure** — At compile time, Java erases all generic type info. `E` becomes `Object` in the compiled bytecode. So `new E[10]` would become `new Object[10]`.
    
2. **Arrays check types at runtime** — Unlike generics, arrays remember their element type and check every write operation at runtime. If you try to put a `String` into an `Integer[]`, you get an `ArrayStoreException`.
    

The conflict: If `new E[10]` became `new Object[10]`, the array would think it holds `Object` and allow anything to be stored — breaking type safety.

### Example of What Could Go Wrong

```java
Foo<String> foo = new Foo<>();
// If this worked, data would really be Object[]
// Then someone could sneak in an Integer
// And later: String s = data[0];  // ClassCastException!
```

### Solution

Just use `ArrayList<E>` instead:

```java
class Foo<E> {
    private ArrayList<E> data;
    
    public Foo() {
        this.data = new ArrayList<>();  // This works!
    }
}
```

`ArrayList` handles the ugly workarounds internally so you don't have to.