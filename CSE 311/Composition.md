Making one class contain another class rather than extending it
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
Why use this over inhertiance?
- Controls the interface
	- clients cannot call HashTable API
- Prevents misue
	- clients cannot call functions that could break the object
- more flexible
	- you can swap the internal implementaiton without affecting clients