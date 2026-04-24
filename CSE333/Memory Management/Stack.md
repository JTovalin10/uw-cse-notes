# CSE 333: Stack

The **Stack** is used to store data associated with function calls.

## Stack Frames
A **Stack Frame** (or procedure activation record) contains:
- **Return Address**: Where to go back after the function returns.
- **Saved Registers**: Values of registers that need to be restored.
- **Local Variables**: Variables defined within the function scope.
- **Arguments**: Parameters passed to the function (specifically those beyond the first 6 in x86-64, which are passed in registers).

## Automatic Management
Memory on the stack is allocated and freed automatically via calling conventions (e.g., `push`, `pop`, `mov` instructions).
- **Lifetime**: Local variables "disappear" when a function returns.
- **Dangling Pointers**: Returning a pointer to a local variable is a bug, as it points to "abandoned" memory that will be reused.

Related: [[C Memory Model]], [[C Fundamentals/Arrays#Arrays as Parameters]]
