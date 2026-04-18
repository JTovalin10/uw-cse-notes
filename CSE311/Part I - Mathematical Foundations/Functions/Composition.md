# CSE 311: Composition

**Composition** (in the object-oriented sense) means making one class *contain* another class rather than extending it ("has-a" instead of "is-a").

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

> Note: This covers object-oriented composition (CSE 331). For mathematical function composition, see [[Functions]].

## Related

- [[Functions]]
- [[Abstract Function]]
