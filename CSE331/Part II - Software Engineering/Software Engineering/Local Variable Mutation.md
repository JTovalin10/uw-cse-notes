# CSE331: Local Variable Mutation

Mutating a **local variable** is the simplest form of mutation: it changes only the value bound to a name inside the current method, never any object or argument outside.

## Reasoning

The reasoning we need here is ordinary **[[Floyd Logic]]** — we track how assertions change as statements execute.

![[Screenshot 2025-10-22 at 5.41.46 PM.png]]

## Mechanical Tools for Moving Facts Around

- **Forward reasoning** — how the facts change as we move **down** through the code (given `{{P}} S`, compute the strongest postcondition).
- **Backward reasoning** — how the facts change as we move **up** through the code (given `S {{Q}}`, compute the weakest precondition).

Both are mechanical rules for assignment: the only subtlety comes from [[Loops|loops]], which require an invariant.

## Related

- [[Mutation]]
- [[Mutations of Arguments]]
- [[Mutations in ADT]]
- [[Floyd Logic]]
- [[Hoare Triples]]
