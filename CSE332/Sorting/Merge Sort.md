# CSE 332: Merge Sort

**[[Merge Sort]]**: A divide and conquer sorting algorithm that recursively splits the list in half, sorts the halves, and merges them back together.

## Procedure
* **Base Case**: If the list is of length 0 or 1, it's already sorted; return it.
* **Divide**: Split the list into two sublists of roughly equal length. ($0$ comparisons)
* **Conquer**: Sort both sublists recursively.
* **Combine**: **Merge** the two sorted sublists into one sorted list. ($n$ comparisons)
  * Uses 3 pointers (`L_next`, `R_next`, `M_next`). Iteratively compares the smallest unmerged elements from left and right, placing the smaller into a new merged array.

## Running Time Analysis
The recurrence relation for Merge Sort is:
$$ T(n) = 2T\left(\frac{n}{2}\right) + n $$
At each level of the recursion tree, the total work for merging is $n$. There are $\log_2 n$ levels of recursion. Therefore, the total running time is:
$$ T(n) = \sum_{i=1}^{\log_2 n} n = \Theta(n \log n) $$

## Properties
* **Running Time**: $\Theta(n \log n)$ in the worst, best, and average cases.
* **In-place**: No. It requires a second array to merge elements into.
* **Adaptive**: No. Running time is the same regardless of order.
* **Online**: No.
* **Stable**: Yes. When merging, if there is a tie, choosing the element from the left sublist preserves relative order.

## Implementation
```java
public static void mergeSort(int[] arr) {
    int[] temp = new int[arr.length];
    mergeSort(arr, temp, 0, arr.length - 1);
}

private static void mergeSort(int[] arr, int[] temp, int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        mergeSort(arr, temp, left, mid);
        mergeSort(arr, temp, mid + 1, right);
        merge(arr, temp, left, mid, right);
    }
}

private static void merge(int[] arr, int[] temp, int left, int mid, int right) {
    for (int i = left; i <= right; i++) {
        temp[i] = arr[i];
    }
    int i = left;
    int j = mid + 1;
    int k = left;
    while (i <= mid && j <= right) {
        if (temp[i] <= temp[j]) {
            arr[k++] = temp[i++];
        } else {
            arr[k++] = temp[j++];
        }
    }
    while (i <= mid) {
        arr[k++] = temp[i++];
    }
}
```

## Related
* [[Divide And Conquer Sorting]]
* [[Quick Sort]]
* [[Introduction To Sorting]]
