**Extended Stack Pointer**

- Points to the **top of the stack** (current virtual position)
- Automatically modified by `push` (decrements ESP) and `pop` (increments ESP)
- Changes constantly during function execution as you push/pop values
- **Callee-saved** - functions must restore ESP before returning

**ESP vs EBP:**

- **ESP**: Moves around (top of stack) - dynamic
- **EBP**: Stays fixed (base of frame) - stable reference point