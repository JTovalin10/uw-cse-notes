**Definition:** For functions f: ℕ → ℝ and g: ℕ → ℝ,

f(n) ∈ O(g(n)) means:

- There exist positive constants c and n₀ such that
- f(n) ≤ c · g(n) for all n ≥ n₀

**In plain English:** f(n) is in O(g(n)) if f(n) grows no faster than g(n) asymptotically. We can find some constant c and starting point n₀ where f(n) is always bounded above by c times g(n).

**Key points:**

- c is a positive real number (constant multiplier)
- n₀ is a natural number (starting point)
- n is a natural number (input size)
- We only care about behavior for large n (n ≥ n₀)

**Example:** If f(n) = n and g(n) = n², then f(n) ∈ O(g(n)) because:

- We can choose c = 1 and n₀ = 1
- Then n ≤ 1 · n² for all n ≥ 1 ✓

**Intuition:** Big-O gives us an upper bound on how fast a function can grow.