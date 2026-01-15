
Wildcards (`?`) are a more concise way to write some generic methods. They represent an **anonymous type variable**.

### Basic Syntax

|Wildcard|Meaning|
|---|---|
|`?`|Any type (shorthand for `? extends Object`)|
|`? extends E`|E or any subtype of E|
|`? super E`|E or any supertype of E|

### Example: Equivalent Forms

This generic method:

```java
<T extends E> void addAll(Collection<T> c)
```

Can be written with a wildcard:

```java
void addAll(Collection<? extends E> c)
```

The wildcard is automatically transformed into an anonymous type variable.

---

### `? extends` vs `? super` (PECS Rule)

**Producer Extends, Consumer Super**

```java
<T> void copyTo(List<? super T> dest,    // consumer (receives values)
                List<? extends T> src) {  // producer (gives values)
    for (T t : src)
        dest.add(t);
}
```

- **`? extends T`** — use when you **get** values out (producer)
- **`? super T`** — use when you **put** values in (consumer)

---

### What's Legal?

Given:

```java
List<? extends Integer> list;
```

|Operation|Legal?|Why|
|---|---|---|
|`list = new ArrayList<Integer>()`|✓|Integer extends Integer|
|`list = new ArrayList<PosInteger>()`|✓|PosInteger extends Integer|
|`list = new ArrayList<Number>()`|✗|Number doesn't extend Integer|
|`Integer i = list.get(0)`|✓|Produces at least Integer|
|`list.add(someInteger)`|✗|Can't consume (might be List<PosInteger>)|

Given:

```java
List<? super Integer> list;
```

|Operation|Legal?|Why|
|---|---|---|
|`list = new ArrayList<Number>()`|✓|Number is super of Integer|
|`list = new ArrayList<Object>()`|✓|Object is super of Integer|
|`list = new ArrayList<PosInteger>()`|✗|PosInteger isn't super of Integer|
|`list.add(someInteger)`|✓|Can consume Integer|
|`Integer i = list.get(0)`|✗|Might return Object|

---

### `?` vs `Object`

Don't confuse them:

```java
List<?>       // accepts List<Integer>, List<String>, etc.
List<Object>  // only accepts List<Object> (invariance!)
```

---

### When You Can't Use Wildcards

When you need the same type in multiple places:

```java
// Need both T's to be the same — can't use wildcard
<T> T choose(Collection<T> c)

// Need T in the bound — can't use wildcard  
<T extends Comparable<T>> T max(Collection<T> c)
```