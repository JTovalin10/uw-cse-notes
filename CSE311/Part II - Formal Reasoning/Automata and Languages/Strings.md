# CSE 311: Strings and Alphabets

#Definition An **alphabet** $\Sigma$ is any finite set of characters.

#Definition A **string** over $\Sigma$ is a finite sequence of characters drawn from $\Sigma$. The **empty string** $\varepsilon$ is the unique string of length zero and is a valid string over any alphabet.

The **length** of a string $w$, written $|w|$, is the number of characters it contains.

The collection of *all* strings over $\Sigma$ forms the [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Set of Strings|set of strings]] $\Sigma^*$, and patterns over $\Sigma$ are described by [[CSE311/Part II - Formal Reasoning/Automata and Languages/Regular Expressions|regular expressions]].

## Related

- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Set of Strings|Set of Strings]]
- [[CSE311/Part II - Formal Reasoning/Automata and Languages/Regular Expressions|Regular Expressions]]
- [[CSE311/Part I - Mathematical Foundations/Functions/Functions on a Set of Strings|Functions on a Set of Strings]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Alphabet ($\Sigma$) | Character set |
| String | String / sequence |
| $\varepsilon$ (empty string) | `""` |
| Length ($|w|$) | `.length` / `len()` |