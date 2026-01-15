![[Screenshot 2025-11-28 at 12.33.46 AM.png]]

A **generic method** declares its own type parameter(s) that are separate from any class-level type parameters. This lets a single method work with different types.

### Syntax

```java
static <T> T choose(List<T> list) {
    int index = (int) (list.size() * Math.random());
    return list.get(index);
}
```

- `<T>` — declares the type parameter (comes before return type)
- The `T` after that is the return type
- `List<T>` uses `T` in the parameter

### Why Use Generic Methods?

**Problem:** Java generics are _invariant_ — you can't pass `List<Integer>` where `List<Number>` is expected.

```java
// This doesn't work!
static double sum(List<Number> list) { ... }

List<Integer> ints = ...;
sum(ints);  // ERROR: List<Integer> is not List<Number>
```

**Solution:** Use a generic method:

```java
static <T extends Number> double sum(List<T> list) {
    double result = 0;
    for (T n : list) {
        result += n.doubleValue();
    }
    return result;
}

sum(ints);  // Works! T is inferred as Integer
```

### Key Points

1. **Type parameters are inferred** — you don't specify them when calling:
    
    ```java
    String s = choose(stringList);  // T inferred as String
    ```
    
2. **Can have bounds** — just like class type parameters:
    
    ```java
    <T extends Comparable<T>> T max(Collection<T> c)
    ```
    
3. **Work around invariance** — the main reason to use them:
    
    ```java
    // Most general signature for addAll
    <T extends E> void addAll(Collection<T> c)
    ```