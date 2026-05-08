**[[CSE341/Definitions/Part1/Pattern Matching|Pattern Matching]]**: A powerful mechanism for testing a value against a pattern to deconstruct data and bind internal components to local variables.
### Formal Definition
The `match e with P1 -> e1 | ... | Pn -> en` expression. It evaluates $e$ and executes the branch corresponding to the first pattern $P_i$ that matches.
### Simplified Explanation
A super-powered version of a switch statement that can "look inside" complex data and pull out the pieces you need.
