# CSE 332: Merge Sort

**Merge Sort**: A divide and conquer sorting algorithm that splits an array in half, recursively sorts each half, and then **merges** the two sorted halves back together.

## Procedure
* **Divide**: Split the array into two roughly equal halves.
* **Conquer**: Recursively sort each half.
* **Combine**: Merge the two sorted halves into one sorted array. This is the "hard" part.

## Merging
The merge step works by comparing the front elements of the two sorted halves and placing the smaller one into an output array, then advancing that pointer. Repeat until both halves are exhausted.

The merge step takes $\Theta(n)$ time and $\Theta(n)$ extra space (a temporary array to hold the merged result).

## Recurrence Analysis
$$T(n) = 2T(n/2) + n$$
Using the tree method: the work at each level is $n$, the height of the tree is $\log_2 n$, giving:
$$T(n) = \Theta(n \log n)$$

## Properties
* **Running Time**: $\Theta(n \log n)$ worst case, best case, and average case.
* **In-place**: No. Requires $\Theta(n)$ extra space for the temporary merge buffer.
* **Adaptive**: No. The number of comparisons is similar regardless of how sorted the input is.
* **Online**: No. We must have the full array before we can begin.
* **Stable**: Yes. When two elements are equal, the merge procedure takes from the left half first, preserving relative order.

## Implementation
```java
public static void mergeSort(int[] arr, int low, int high) {
    if (high - low <= 1) return; // Base case: 0 or 1 elements
    int mid = low + (high - low) / 2;
    mergeSort(arr, low, mid);
    mergeSort(arr, mid, high);
    merge(arr, low, mid, high);
}

private static void merge(int[] arr, int low, int mid, int high) {
    int[] temp = new int[high - low];
    int left = low, right = mid, i = 0;
    while (left < mid && right < high) {
        if (arr[left] <= arr[right]) { // <= preserves stability
            temp[i++] = arr[left++];
        } else {
            temp[i++] = arr[right++];
        }
    }
    while (left < mid)  temp[i++] = arr[left++];
    while (right < high) temp[i++] = arr[right++];
    System.arraycopy(temp, 0, arr, low, temp.length);
}
```

## Related
* [[CSE332/Sorting/Divide And Conquer Sorting|Divide And Conquer Sorting]]
* [[CSE332/Sorting/Quick Sort|Quick Sort]]
* [[CSE332/Sorting/Introduction To Sorting|Introduction To Sorting]]
* [[CSE444/Query Evaluation/External Merge-Sort|Databases: External Merge-Sort]]
