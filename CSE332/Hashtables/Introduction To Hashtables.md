# CSE 332: Introduction to Hashtables

**[[Dictionary ADT]]**: A map containing sets of key-value pairs where keys must be unique and have a hash function. Operations include `insert`, `find`, and `delete`.

**[[Hash Table]]**: A data structure that uses a small array to store information and a **[[Hash Function]]** to convert a key into an index. The hash function scatters the keys as if randomly assigned.

## Hash Functions
A hash function maps objects to integers. A "good" hash function has the following properties:
* **Consistent**: Objects considered "equal" should hash to the same value. The function is deterministic.
* **Uniform**: Should use every index in a fixed-size array at roughly equal rates.
* **Effective**: Difficult to find two objects that hash to the same value. A small change in the object should yield large changes in the hash value (Avalanche effect).
* **Efficient**: Time to calculate the hash should be $\Theta(1)$.

## Collision Resolution
A **[[Collision]]** occurs when we want to insert something into an already-occupied position in the hash table. Two main strategies exist:
* **[[Separate Chaining]]**: Use a secondary data structure (like a linked list) to contain the items at each index.
* **[[Open Addressing]]**: Use a different spot in the table instead (Linear Probing, Quadratic Probing, Double Hashing).

## Load Factor and Rehashing
**[[Load Factor]]** ($\lambda$): Represents the average number of items per bucket in the hash table.
$$ \lambda = \frac{n}{\text{length}} $$

**[[Rehashing]]**: If $\lambda$ gets too large, create a new, larger array (roughly double the size, usually prime) and re-insert all items by reapplying the hash function modulo the new length.
* For [[Separate Chaining]], we typically want $\lambda < 2$.
* For [[Open Addressing]], we typically want $\lambda < \frac{1}{2}$.

## Related
* [[Separate Chaining]]
* [[Open Addressing]]
* [[CSE484/Cryptography/Hashing + Ciphertext Integrity|Security: Cryptographic Hashing]]
* [[CSE444/Data Storage, indexing, and buffer mgmt/Indexing|Databases: Indexing]]
* [[CSE444/Data Storage, indexing, and buffer mgmt/B+ Tree|Databases: B+ Trees]]
