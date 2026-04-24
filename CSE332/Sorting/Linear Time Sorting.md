# CSE 332: Linear Time Sorting

Standard sorting algorithms based on comparisons cannot be asymptotically faster than $\Theta(n \log n)$. However, if we can make additional assumptions about the contents of the list, we can achieve "Linear Time" sorting without direct comparisons.

## BucketSort
**BucketSort**: Assumes the array contains integers between $0$ and $k-1$ (or another small known range).
* **Idea**:
  * Use each value as an index into an array of size $k$ (buckets).
  * Add the item into the bucket at that index (e.g., a linked list).
  * Get the sorted array by appending all the buckets.

**Running Time**:
* Create array of $k$ buckets: $\Theta(k)$
* Insert $n$ things into buckets: $\Theta(n)$
* Empty buckets into array: $\Theta(n+k)$
* **Overall**: $\Theta(n + k)$. This is better than merge sort when $k$ is $O(n \log n)$.

**Properties**: Not In-Place, Not Adaptive, but it is **Stable**.

## RadixSort
**RadixSort**: Uses a base (radix) number system (e.g., base 10) to sort elements.
* **Idea**: Perform BucketSort by each digit, one at a time, starting from the least significant digit to the most significant digit.

**Running Time**:
* Suppose the largest value is $m$, and we choose radix $b$.
* We BucketSort $n$ things using $b$ buckets, taking $\Theta(n+b)$.
* We repeat this $\log_b m$ times (number of digits).
* **Overall**: $\Theta(n \log_b m + b \log_b m)$.
* By optimizing the base $b$, this can achieve highly efficient running times.

## Related
* [[Introduction To Sorting]]
