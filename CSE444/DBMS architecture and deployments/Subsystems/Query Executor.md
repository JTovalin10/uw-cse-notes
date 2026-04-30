# DBMS Architecture: Query Executor

### Push vs. Pull Execution
- **Pull-based**: child operator answers "can I have a tuple?" with "here is a tuple" — the parent drives execution
- **Push-based**: child operator sends "here is a tuple" unprompted — the child drives execution
- Many modern databases (especially distributed ones) implement push-based execution because it reduces network round-trips

### Iterator Interface
Every operator implements an iterator interface (e.g., `OPIterator.java` in the labs):

| Method | Description |
|--------|-------------|
| `open()` | Initializes operator state; sets parameters like selection predicates |
| `next()` | Returns one tuple; recursively calls `next()` on child operators |
| `close()` | Cleans up operator state |

Each operator holds a reference to its child operator and can call `child.open()`, `child.next()`, etc.

![[Screenshots/Query Execution.png]]
