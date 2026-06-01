# CSE331: Types of Tests

Two top-level categories:

- **Unit test** — checks one function in isolation.
  - Some functions might be too big to unit-test cleanly.
    - Not being able to see what happens in the middle is a problem.
    - **Multiple loops often should be multiple functions.**
- **Integration test** — checks whether pieces work correctly together.

## Rules for Tests

- Only need to test inputs **allowed by specs** (see [[Pre and Post Conditions]]).
- Test each function individually.
- Test code should be **simple** — a complex test is itself suspect.
- If there are fewer than **10** allowed inputs, test them all.

# Coverage Metrics

## Statement Coverage

- Simplest metric: what percentage of the statements in the code are executed by at least one test.
- Should be **nearly 100%**, aside from `throw` paths (we don't test disallowed inputs).

## Branch Coverage

- What percentage of conditionals have **both** branches covered by tests.
- Must test all branches on allowed inputs.
- Can ignore branches that are unreachable.

## Loop Coverage

- What percentage of loops are executed **0, 1, and many (2+)** times by some test case.
- The same idea applies to **recursion** — you might not see an error until ≥ 2 calls.

# Summary

- At least **two tests** for any (non-UI) function.
- Must have full coverage of all reachable code:
  - **Loops / recursion:** must run 0, 1, and n iterations.
  - **Branches:** must execute all branches.
  - **Statements:** must all be executed.

## Related

- [[Testing]]
- [[Debugging]]
- [[Software Implementation]]
- [[Pre and Post Conditions]]
