# CSE331: Facts

**Facts**: Things we know to be true about the variables.

- Hold for all inputs (no matter what value the variable has).
- Typically use `=` or $\leq$.
- Don't repeat things that are done by the type checker (e.g. $n : \mathbb{Z}$).

# Collecting Facts

- Saw how to collect facts in code consisting of:
    - **final** variable declarations
    - **if** statements
- Collect facts reading top to bottom.
- These elements cover all code without mutation.
    - Covers everything describable by our math notation.
    - We can calculate interesting values with recursion.

## Related
- [[CSE331/Part I - Software Specifications/Software Specifications/Floyd Logic|Floyd Logic]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Propositions|Propositions]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Pre and Post Conditions|Pre and Post Conditions]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Stronger Assertions|Stronger Assertions]]
