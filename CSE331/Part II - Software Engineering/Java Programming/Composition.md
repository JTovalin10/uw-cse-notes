# CSE 331: Composition

**Composition** means making one class *contain* another class rather than extending it ("has-a" instead of "is-a"). It is the primary alternative to **[[CSE331/Part II - Software Engineering/Java Programming/Subtypes|inheritance]]** for reusing behavior between classes.

```java
class Properties {
    private Hashtable tbl;  // "has-a" Hashtable

    public void setProperty(String key, String val) {
        tbl.put(key, val);
    }

    public String getProperty(Object key) {
        return (String) tbl.get(key);
    }
}
```

## Why Use This Over Inheritance?

- **Controls the interface** — clients cannot call the Hashtable API directly
- **Prevents misuse** — clients cannot call functions that could break the object's state
- **More flexible** — you can swap the internal implementation without affecting clients

## Related

- [[CSE331/Part II - Software Engineering/Java Programming/Subtypes|Subtypes]]
- [[CSE331/Part II - Software Engineering/Software Engineering/Abstract Function|Abstract Function]]
- [[CSE331/Part II - Software Engineering/Software Engineering/Abstract Data Type|Abstract Data Type]]

## Industry Standard Terms

| CSE 331 Term | Industry-Standard Equivalent |
| --- | --- |
| Composition ("has-a") | Object composition / aggregation |
| Inheritance ("is-a") | Subclassing / extension |
| Controlling the interface | Encapsulation / information hiding |
