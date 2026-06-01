# CSE341: Promise

A data structure that represents a delayed computation that is performed at most once and cached.

### Formal Definition

A **Promise** (or Lazy Value) is a stateful object that initially contains a **[[Thunk|Thunk]]**. Upon being "forced", it evaluates the thunk, stores the result, and returns that result for all subsequent force operations.

### Simplified Explanation

A "lazy" box that only does its work if you ask for the value, and then remembers the answer so it doesn't have to work again.

See: [[Delayed Evaluation|Delayed Evaluation]]
