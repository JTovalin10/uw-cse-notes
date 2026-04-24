# CSE 332: Insertion Sort

**[[Insertion Sort]]**: A sorting algorithm that maintains a sorted list prefix and extends that prefix by "inserting" the next element into its correct position within the prefix.

## Properties
* **Running Time**:
  * Worst Case: $\Theta(n^2)$
  * Best Case: $\Theta(n)$ (when the array is already sorted)
* **In-place**: Yes. It only swaps items within the given array.
* **Adaptive**: Yes. The only elements that move are the elements that are out of position.
* **Online**: Yes. Each time an item arrives, it can be inserted into the sorted prefix.
* **Stable**: Yes. If the item we're inserting has a tie with its left neighbor, we do not swap them.

## Summary
Except for its asymptotic running time on large lists, it has excellent properties. It is often the fastest way of sorting a small list ($\le 50$ elements) due to very small constants.

## Implementation
```java
public static void insertionSort(int[] arr) {
    for (int i = 1; i < arr.length; i++) {
        int temp = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > temp) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = temp;
    }
}
```

## Related
* [[Introduction To Sorting]]
