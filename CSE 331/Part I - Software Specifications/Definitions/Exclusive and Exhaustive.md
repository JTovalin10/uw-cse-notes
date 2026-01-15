**When defining functions with pattern matching, we want to ensure our patterns are well-behaved. We can describe them with two key properties: **exclusivity** and **exhaustiveness**.

- **Exclusive**: A set of patterns is **exclusive** if for any given input, **at most one** pattern can match. The patterns don't overlap. This prevents ambiguity. 🤔
    
- **Exhaustive**: A set of patterns is **exhaustive** if for any possible valid input, **at least one** pattern will match. This ensures the function is defined for every case and has no "gaps". This prevents runtime errors for unhandled cases. ✅
    

The ideal function definition is **both exclusive and exhaustive**.

---

## Examples

Let's consider a function `check(n: Integer)` that checks an integer.

### Both Exclusive and Exhaustive (✅ Ideal)

These patterns cover every possible integer exactly once. There is no ambiguity and no case is missed.

```
check(0) := "Zero"
check(n) if n > 0 := "Positive"
check(n) if n < 0 := "Negative"
```

- **Exclusive**: An integer cannot be, for example, both `0` and positive.
    
- **Exhaustive**: Every integer is either zero, positive, or negative.
    

### Exclusive but Not Exhaustive (❌ Has Gaps)

These patterns are not overlapping, but they fail to account for one or more valid inputs.

```
check(0) := "Zero"
check(n) if n > 0 := "Positive"
// What happens if n is negative? It's undefined.
```

- **Exclusive**: An integer cannot be both `0` and positive.
    
- **Not Exhaustive**: The function is not defined for negative integers (e.g., `check(-5)` would fail).
    

### Exhaustive but Not Exclusive (❌ Ambiguous)

These patterns cover all cases, but at least one case is covered by multiple patterns, creating ambiguity.

```
check(n) if n >= 0 := "Non-negative"
check(n) if n % 2 == 0 := "Even"
```

- **Not Exclusive**: The input `4` matches both patterns. Which result should be returned? "Non-negative" or "Even"?
    
- **Not Exhaustive**: This is also not exhaustive, as an input like `-3` matches neither pattern. A better example of "Exhaustive but Not Exclusive" would be:
    
    ```
    check(n) if n >= 0 := "Non-negative"
    check(n) := "Any Integer"
    ```
    
    Here, every integer is covered, but `4` still matches both rules.
    

### Neither Exclusive nor Exhaustive (❌ Worst Case)

These patterns have both gaps and overlaps. This is the most problematic design.

```
check(n) if n > 10 := "Large"
check(n) if n is even := "Even"
```

- **Not Exclusive**: The input `12` matches both patterns.
    
- **Not Exhaustive**: The input `7` matches neither pattern.