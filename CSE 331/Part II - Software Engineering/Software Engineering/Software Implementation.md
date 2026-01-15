![[Screenshot 2025-09-29 at 1.03.42 PM.png]]
Of course! Here are your notes with corrected spelling, improved grammar, and a more organized format.

---

## The Software Development & Verification Process

- **Coding:** Translating the design into source code using a programming language.
    
- **Type Checking:** Verifying that the code always produces values of the correct type.
    
    - Checks all possible inputs (even invalid ones) but only for simple properties.
        
    - It is 100% reliable, as long as you don't use type casting to override it.
        
- **Reasoning:** Thinking through what the code does on all allowed inputs.
    
    - This is the only technique that confirms the code produces the _correct_ output for _all_ valid inputs.
        
    - It's often done informally, but for critical or complex problems, it's done formally.
        
- **Testing:** Checking for the correct output on a selection of allowed inputs.
    
    - It verifies the exact answer but only for a small handful of inputs.
        
    - Tests can also be flawed, so it's important to think carefully about each test case.
        
- **Debugging:** Searching backward from a failure to find the mistake in the code.
    
    - This becomes much more difficult as the amount of code involved grows.
        
    - It requires a full understanding of all the code that was executed.
        

---

## Why Is This Process Necessary?

A common question is, "Why not just send the first version that compiles to all users?"

- **Users hate bugs.** If a user encounters a bug, they are unlikely to use the program again. This can permanently damage your software's reputation.
    
- **Beta testers** are an exception. They are specifically warned that they are using an unfinished product, so they are more understanding about failures.
    
- Some bugs only appear at scale, when you have a large number of users. To avoid reputation damage, you must find these bugs before the public release.
    
- The primary method for catching subtle bugs is **reasoning via code review**, where a second programmer thinks through the code to make sure no rare cases have been missed.
    

---

## Debugging Techniques

Debugging is the search from a failure—something visible to the user—back to the bug that caused it.

**Key Point:** Both testing and debugging require a complete understanding of how the program is **supposed** to work.

- **Binary Search:** If you can look at the state of the program halfway through its execution and confirm that the failure has (or has not) occurred by that point, you can cut the search space in half. Repeating this process can quickly pinpoint the bug's location.
    
- **Scientific Method:** Come up with a hypothesis about the bug's location. Create an experiment, such as changing part of the code or adding a print statement, that would prove or disprove your hypothesis. Performing that experiment and observing the result helps you systematically reduce the search space.