# CSE 311: Nondeterministic Finite Automata

A **Nondeterministic Finite Automaton (NFA)** is a generalization of a [[Deterministic Finite Automata|DFA]] that drops two restrictions:
- It is not required to have exactly 1 edge out of each state labeled by each symbol (can have 0 or $>1$).
- It can have edges labeled by the empty string $\varepsilon$ (called **$\varepsilon$-moves**).

A string $x$ is in the language recognized by an NFA if and only if **some** valid execution of the machine gets to an accept state.

## Three ways to think about NFAs
1. **Perfect guesser:** The NFA has input $x$ and whenever there is a choice of what to do, it magically guesses a good one (if one exists).
2. **Outside observer:** Is there a path labeled by $x$ from the start state to some accepting state?
3. **Parallel exploration:** The NFA computation runs all possible computations on $x$ step-by-step at the same time in parallel.

## NFAs vs DFAs
Every DFA is an NFA. However, NFAs cannot recognize more languages than DFAs. 
**Theorem:** For every NFA, there is a DFA that recognizes exactly the same language.
- NFAs can be converted to DFAs using the **subset construction** algorithm, where each state in the DFA represents a subset of states that the NFA could be in.

## Regular Languages
**Theorem:** A language is recognized by a DFA (or NFA) if and only if it has a [[Regular Expressions|regular expression]].
Languages represented by DFAs, NFAs, or regular expressions are called **Regular Languages**.

$$REs \equiv DFAs \equiv NFAs \subset CFGs$$

This hierarchy says all three regular-language models have identical recognition power, while [[Context-Free Grammars|context-free grammars]] strictly exceed them.

## Related
- [[Deterministic Finite Automata|Deterministic Finite Automata]]
- [[Regular Expressions|Regular Expressions]]
- [[Context-Free Grammars|Context-Free Grammars]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Nondeterministic Finite Automaton (NFA) | Nondeterministic finite state machine |
| $\varepsilon$-move | Epsilon transition / silent transition |
| Subset construction | Powerset construction / NFA-to-DFA conversion |
