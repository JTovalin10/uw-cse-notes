# CSE331: @effects

**`@effects`**: Lists the results of mutation.

- Promises about the state when the call returns.
- No `@effects` means any change is possible.
- Works together with [[@modifies]], which lists what may be changed.

```C
@modifies A
@effects all entries of A set to zero
void clear(int[] A)
```

## Related
- [[@modifies]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Postcondition|Postcondition]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Pre and Post Conditions|Pre and Post Conditions]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Writing Methods Specs in Java|Writing Methods Specs in Java]]
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutation|Mutation]]
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutations of Arguments|Mutations of Arguments]]
