# CSE 332: Fork-Join

**[[Parallelism]]**: One task being completed by many threads/processors. Recruit several cooks to peel a lot of potatoes faster.

**Concurrency**: Parallel tasks using a shared resource. Several cooks are making their own recipes, but there is only 1 oven.

The **ForkJoin Framework** is a Java library for parallelism using divide and conquer. It utilizes a `ForkJoinPool` and `RecursiveTask<V>` or `RecursiveAction`.

To implement parallel divide and conquer:
1. **Base Case**: If the input is smaller than the **Sequential Cutoff** (typically 500 to 5000), compute sequentially.
2. **Divide**: Split the problem in half across two separate tasks.
3. **Conquer**: Use `fork()` to compute the left half in parallel, and `compute()` directly to compute the right half in the current thread (a small optimization over forking both).
4. **Wait**: Use `join()` to wait for the forked task to finish and get its result. Don't call `join()` immediately after `fork()`, as that defeats parallelism!
5. **Combine**: Combine the results.

Common parallel operations:
- **[[Reduction]]** / **Fold**: Reducing all elements in an array to a single item (e.g., sum, max). Requires the operation to be associative (e.g., $(x+y)+z = x+(y+z)$).
- **Map**: Applying a function to each element of an array independently.

## Implementation Example: Summing an Array
Below is an example of a `RecursiveTask` that computes the sum of an array in parallel.

```java
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveTask;

public class SumArray extends RecursiveTask<Long> {
    private static final int SEQUENTIAL_THRESHOLD = 1000;
    private int[] array;
    private int low;
    private int high;

    public SumArray(int[] array, int low, int high) {
        this.array = array;
        this.low = low;
        this.high = high;
    }

    @Override
    protected Long compute() {
        if (high - low <= SEQUENTIAL_THRESHOLD) {
            long sum = 0;
            for (int i = low; i < high; i++) {
                sum += array[i];
            }
            return sum;
        } else {
            int mid = low + (high - low) / 2;
            SumArray left = new SumArray(array, low, mid);
            SumArray right = new SumArray(array, mid, high);
            
            left.fork(); // Fork the left task
            long rightRes = right.compute(); // Compute the right task in current thread
            long leftRes = left.join(); // Wait for left task and get result
            
            return leftRes + rightRes;
        }
    }

    public static void main(String[] args) {
        int[] data = new int[10000];
        // Initialize data...
        ForkJoinPool pool = new ForkJoinPool();
        long totalSum = pool.invoke(new SumArray(data, 0, data.length));
        System.out.println("Sum: " + totalSum);
    }
}
```

## Related
- [[Work And Span]]
- [[Parallel Prefix]]
- [[Concurrency And Locks]]
