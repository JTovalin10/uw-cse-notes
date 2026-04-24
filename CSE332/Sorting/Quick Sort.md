# CSE 332: Quick Sort

**[[Quick Sort]]**: A divide and conquer sorting algorithm that selects a "pivot" element and partitions the array into two sublists—elements less than the pivot and elements greater than the pivot—before sorting them recursively.

## Procedure
* **Divide**: Select a **[[Pivot]]** element $p$ and **[[Partition]]** the array. This is the "hard" part.
* **Conquer**: Recursively sort the left and right sublists.
* **Combine**: Nothing! The array is sorted in place.

## Partitioning
Given an array and a pivot $p$, the goal is to place all elements $< p$ on the left, and elements $> p$ on the right.
1. Put $p$ at the beginning of the list.
2. Initialize pointers `Begin` (just after $p$) and `End` (at the end of the list).
3. While `Begin < End`:
   * If `Begin` value $< p$, move `Begin` right.
   * Else, swap `Begin` value with `End` value, and move `End` left.
4. When pointers meet:
   * If element $< p$, swap $p$ with the pointer position.
   * Else if element $> p$, swap $p$ with the value to the left.

The partition step runs in $\Theta(n)$ time.

## Pivot Selection
A "good" pivot creates a roughly even split between left and right (ideally the median).
* In practice, we pick a random value or the **Median of 3** random values as the pivot.

## Properties
* **Running Time**:
  * Best Case (balanced splits): $T(n) = 2T(n/2) + n \implies \Theta(n \log n)$
  * Worst Case (pivot is always extreme): $T(n) = T(n-1) + n \implies \Theta(n^2)$
  * Average Case: $\Theta(n \log n)$. It is typically faster than merge sort in practice due to smaller constant factors.
* **In-place**: Kinda. The swaps happen within the given array, but it requires $\Theta(\log n)$ space for the recursion call stack.
* **Adaptive**: No.
* **Online**: No.
* **Stable**: No. The partition procedure can rearrange tied elements.

## Implementation
```java
public static void quickSort(int[] arr) {
    quickSort(arr, 0, arr.length - 1);
}

private static void quickSort(int[] arr, int low, int high) {
    if (low < high) {
        int pivotIndex = partition(arr, low, high);
        quickSort(arr, low, pivotIndex - 1);
        quickSort(arr, pivotIndex + 1, high);
    }
}

private static int partition(int[] arr, int low, int high) {
    int pivot = arr[low];
    int begin = low + 1;
    int end = high;

    while (begin <= end) {
        if (arr[begin] < pivot) {
            begin++;
        } else {
            swap(arr, begin, end);
            end--;
        }
    }
    // Swap pivot into place
    swap(arr, low, end);
    return end;
}

private static void swap(int[] arr, int i, int j) {
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}
```

## Related
* [[Divide And Conquer Sorting]]
* [[Merge Sort]]
* [[Introduction To Sorting]]
