# CSE 332: Open Addressing

**[[Open Addressing]]**: A collision resolution strategy where, instead of using secondary data structures, items are placed in a different available spot within the hash table itself.

To maintain performance, open addressing typically requires a **[[Load Factor]]** $\lambda < \frac{1}{2}$.

## Linear Probing
**Linear Probing**: When a collision occurs, use the very next open space in the table (checking indices $i+1$, $i+2$, etc., wrapping around to 0).

* **Insert**: Try $i = h(k) \pmod{\text{length}}$. If occupied, try $i+1$, $i+2$, etc., until an empty spot is found.
* **Find**: Start at index $i$, check subsequent indices until $k$ is found or an empty index is reached (which means the find was unsuccessful).
* **Delete**: Deleting directly would break future `find` operations that relied on probing past the deleted spot.
  * **Tombstone**: Leave a special object indicating something was deleted. Tombstones act as occupied spaces during a `find` (so probing continues), but act as empty spaces during an `insert` (so they can be overwritten).

**Downsides**: As $\lambda$ approaches 1, contiguous blocks of items grow longer. This guarantees a feedback loop where larger blocks experience more collisions, known as **Primary Clustering**.

## Quadratic Probing
**Quadratic Probing**: To mitigate clustering, instead of checking the next index, check indices at quadratically increasing intervals: $(i+1^2)$, $(i+2^2)$, $(i+3^2)$, etc.

If `table.length` is prime and $\lambda < \frac{1}{2}$, you are guaranteed to find an open spot in at most $\text{table.length} / 2$ probes. This helps with the primary clustering problem of linear probing but does not help if many things hash to the same value (Secondary Clustering).

## Double Hashing
**Double Hashing**: Given two good hash functions $h$ and $g$, resolve collisions by probing at intervals defined by the second hash function.
* Try indices: $(i + g(k)) \pmod{\text{length}}$, $(i + 2 \cdot g(k)) \pmod{\text{length}}$, $(i + 3 \cdot g(k)) \pmod{\text{length}}$, etc.

## Related
* [[Introduction To Hashtables]]
* [[Separate Chaining]]
