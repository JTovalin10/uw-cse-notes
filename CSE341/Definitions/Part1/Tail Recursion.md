**[[CSE341/Definitions/Part1/Tail Recursion|Tail Recursion]]**: A form of recursion where the recursive call is the very last action performed by the function.
### Formal Definition
A recursive function where all recursive calls are in **tail position**. Such functions can be optimized to use $O(1)$ stack space.
### Simplified Explanation
A special kind of recursion that is just as efficient as a loop and won't cause a "stack overflow."
