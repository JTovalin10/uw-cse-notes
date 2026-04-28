# CSE331: Defensive Programming

Even with type checking, reasoning, and testing, some bugs will inevitably get through. **Defensive programming** involves adding extra checks to your code to catch these bugs early, reducing the work of debugging.

## Strategies

1. **Check for invalid inputs:** Clients should not pass invalid inputs (violating the precondition). However, given enough clients, some will pass invalid inputs. Add checks for parameters for validity (EJ 49).
   - Check these if it's not too **expensive**. Only skip if it would cause asymptotic slowdown (e.g., binary search cannot check the array is sorted in $O(1)$ time).
   
2. **Check that the RI holds at the end of mutators:** Mutation could produce an invalid state. If un-caught, this would cause painful debugging because the code doesn't crash until the *next* method call (or later). 
   - We call this method `checkRep()` in 331.
   - Worth checking even if it is **expensive** (add a boolean flag to enable them when testing).

3. **Check that the RI holds at the start of mutators:** Why check at the start? Because of **rep exposure**. Mutation through an alias could break the RI between method calls. While it's likely still a bug because the abstract state was wrongly changed, catching it at the start prevents further corruption.

## Related
- [[Debugging]]
- [[Representation Invariants]]
- [[Mutations in ADT]]
- [[Aliasing]]