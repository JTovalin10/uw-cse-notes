# CSE 332: Heap Sort

**[[Heap Sort]]**: A sorting algorithm that works by inserting all items into a max heap, then repeatedly extracting the largest element to fill a sorted list from right-to-left.

## In-Place Heap Sort
By default, creating a new heap takes $O(n)$ space. However, Heap Sort can be made in-place.
1. Build a max heap in the array itself using **[[Floyd's BuildHeap]]** algorithm in $O(n)$ time.
2. When "removing" an element from the heap, swap it with the last item of the heap.
3. Then "pretend" the heap is one item shorter.
4. Call `percolateDown(root)` to restore the heap property.
5. The extracted elements will accumulate at the end of the array, resulting a sorted sequence.

## Properties
* **Running Time**:
  * Worst Case: $\Theta(n \log n)$
  * Best Case: $\Theta(n \log n)$
* **In-place**: Yes (using the trick above).
* **Adaptive**: No. Running time is similar regardless of the original list's order.
* **Online**: No. We need all elements in the heap before we can start extracting.
* **Stable**: No. 

## Related
* [[Introduction To Sorting]]
