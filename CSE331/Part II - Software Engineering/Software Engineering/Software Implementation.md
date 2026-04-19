# CSE331: Software Implementation

![[Screenshot 2025-09-29 at 1.03.42 PM.png]]

## The Software Development and Verification Process

- **Coding** — translating the design into source code using a programming language.
- **Type checking** — verifying that the code always produces values of the correct type.
  - Checks all possible inputs (even invalid ones) but only for simple properties.
  - 100% reliable, as long as you don't use type casting to override it.
- **Reasoning** — thinking through what the code does on all allowed inputs.
  - The only technique that confirms the code produces the *correct* output for *all* valid inputs.
  - Often done informally, but for critical or complex problems it is done formally (see [[Floyd Logic]], [[Hoare Triples]]).
- **[[Testing]]** — checking for the correct output on a selection of allowed inputs.
  - Verifies the exact answer but only for a small handful of inputs.
  - Tests can also be flawed, so think carefully about each test case.
- **[[Debugging]]** — searching backward from a failure to find the mistake in the code.
  - Becomes much more difficult as the amount of code involved grows.
  - Requires a full understanding of all the code that was executed.

---

## Why Is This Process Necessary?

A common question is: "why not just send the first version that compiles to all users?"

- **Users hate bugs.** If a user encounters a bug, they are unlikely to use the program again. This can permanently damage your software's reputation.
- **Beta testers** are an exception. They are specifically warned that they are using an unfinished product, so they are more understanding about failures.
- Some bugs only appear at **scale**, when you have a large number of users. To avoid reputation damage, you must find these bugs *before* the public release.
- The primary method for catching subtle bugs is **reasoning via code review**, where a second programmer thinks through the code to make sure no rare cases have been missed.

## Related

- [[Testing]]
- [[Types of Tests]]
- [[Debugging]]
- [[The Need for Software Design]]
- [[Floyd Logic]]
- [[Hoare Triples]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Kinds of Specifications|Kinds of Specifications]]
