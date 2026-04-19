# CSE331: Debugging

**Debugging** is the search backward from a failure — something visible to the user — to the bug in the code that caused it.

- Debugging becomes much more difficult as the amount of code involved grows.
- It requires a full understanding of all the code that was executed.

**Key Point:** Both testing and debugging require a complete understanding of how the program is *supposed* to work. Without knowing the intended behavior you cannot tell whether you are looking at a bug.

Debugging is one of several techniques used during [[Software Implementation]]; it complements type checking, [[Reasoning]], and [[Testing]], each of which catches different kinds of bugs.

# Debugging Techniques

## Binary Search

If you can look at the state of the program halfway through its execution and confirm that the failure has (or has not) occurred by that point, you can cut the search space in half. Repeating this process can quickly pinpoint the bug's location.

## Scientific Method

Come up with a hypothesis about the bug's location. Create an experiment — such as changing part of the code or adding a print statement — that would prove or disprove your hypothesis. Performing that experiment and observing the result helps you systematically reduce the search space.

# Why Code Review Still Matters

The primary method for catching subtle bugs before they reach users is **reasoning via code review**, where a second programmer thinks through the code to make sure no rare cases have been missed. Debugging only starts once a failure has already occurred, so prevention via review catches bugs that would otherwise be expensive to chase down.

# Related

- [[Software Implementation]] — how debugging fits into the broader development and verification process
- [[Testing]]
- [[Types of Tests]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Pre and Post Conditions|Pre and Post Conditions]] — needed to know what the code is supposed to do
- [[CSE484/Debugging Tools/How to enter GDB|How to enter GDB]] — practical debugging with GDB
