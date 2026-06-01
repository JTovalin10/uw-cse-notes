# CSE 332: Introduction to Sorting

**Sorting**: The rearrangement of a list of items into a defined sequence, usually from smallest to largest according to some metric. It enables faster searching (like binary search) and improves data organization.

**Formal Definition**: Given an array $A$ of items and a comparison function, output a permutation of $A$ such that if $i \le j$ then $A[i] \le A[j]$.

## Properties to Consider
No singular sorting algorithm is perfectly best in all scenarios. We analyze algorithms based on:

* **Worst case running time**: Asymptotic bound like $\Theta(n^2)$ or $\Theta(n \log n)$.
* **In-Place Sorting**: The algorithm requires no extra data structures and only uses $\Theta(1)$ extra space, sorting items by swapping things within the same array (sometimes informally called "sorting in-line").
* **Adaptive Sorting**: The running time improves as the given list is closer to being sorted.
* **[[Online Algorithm|Online Sorting]]**: Can start sorting the sequence before having the entire list available.
* **Stable Sorting**: "Tied" elements (elements with the same value) keep their original relative order from the input.

## Related
* [[Insertion Sort|Insertion Sort]]
* [[Heap Sort|Heap Sort]]
* [[Divide And Conquer Sorting|Divide And Conquer Sorting]]
* [[Merge Sort|Merge Sort]]
* [[Quick Sort|Quick Sort]]
* [[Linear Time Sorting|Linear Time Sorting]]
* [[Induction|Math: Induction]]
* [[Permutation|Math: Permutations]]
