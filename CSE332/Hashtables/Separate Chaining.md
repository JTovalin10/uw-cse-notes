# CSE 332: Separate Chaining

**[[Separate Chaining]]**: A collision resolution strategy where each index in the hash table acts as a "bucket" that holds a secondary data structure (e.g., a linked list) containing the items that hashed to that index.

## Operations
* **Insert `k, v`**:
  * Compute the index using $i = h(k) \pmod{\text{table.length}}$.
  * Add the key-value pair to the data structure at `table[i]`.
* **Find `k`**:
  * Compute the index $i = h(k) \pmod{\text{table.length}}$.
  * Call `find` with the key on the data structure at `table[i]`.
* **Delete `k`**:
  * Compute the index $i = h(k) \pmod{\text{table.length}}$.
  * Call `delete` with the key on the data structure at `table[i]`.

## Formal Running Time Analysis
Assuming we use a linked-list for separate chaining and the **[[Load Factor]]** is $\lambda = \frac{n}{\text{length}}$:
* Expected number of comparisons in an unsuccessful find: $\lambda$
* Expected number of comparisons in a successful find: $\frac{\lambda}{2}$

To achieve expected $\Theta(1)$ running time, we pick a constant value and perform **[[Rehashing]]** whenever $\lambda$ exceeds that constant. For separate chaining, typically we want $\lambda < 2$.

## Implementation
```java
public V get(K key) {
    int index = Math.abs(key.hashCode()) % table.length;
    if (table[index] == null) return null;
    for (Entry<K, V> entry : table[index]) {
        if (entry.key.equals(key)) return entry.value;
    }
    return null;
}

public void put(K key, V value) {
    int index = Math.abs(key.hashCode()) % table.length;
    if (table[index] == null) {
        table[index] = new LinkedList<>();
    }
    for (Entry<K, V> entry : table[index]) {
        if (entry.key.equals(key)) {
            entry.value = value;
            return;
        }
    }
    table[index].add(new Entry<>(key, value));
    size++;
}
```

## Related
* [[Introduction To Hashtables]]
* [[Open Addressing]]
