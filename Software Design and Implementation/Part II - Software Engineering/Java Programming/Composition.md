# CSE 331: Composition

**Composition** means making one class *contain* another class rather than extending it ("has-a" instead of "is-a"). It is the primary alternative to **[[Subtypes|inheritance]]** for reusing behavior between classes.

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

- [[Subtypes|Subtypes]]
- [[Abstract Function|Abstract Function]]
- [[Abstract Data Type|Abstract Data Type]]

## Industry Standard Terms

| CSE 331 Term | Industry-Standard Equivalent |
| --- | --- |
| Composition ("has-a") | Object composition / aggregation |
| Inheritance ("is-a") | Subclassing / extension |
| Controlling the interface | Encapsulation / information hiding |
