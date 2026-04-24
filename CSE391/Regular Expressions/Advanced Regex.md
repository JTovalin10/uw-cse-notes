# CSE391: Advanced Regex and Backreferences

Advanced regular expression features allow for matching more complex patterns and reusing parts of a match.

## Grouping and Capturing
Parentheses `()` are used to group parts of a regex together. This allows you to apply quantifiers to the entire group or refer back to the group later.
- Example: `(ab)+` matches "ab", "abab", "ababab", etc.

## Backreferences
**Backreferences** allow you to match the exact same text that was previously matched by a capturing group.
- Syntax: `\1`, `\2`, etc. (referring to the 1st, 2nd, ... capturing group).
- Example: `^(\w).*\1$` matches lines that start and end with the same character.
- Example: `([a-zA-Z]+) \1` matches repeated words (e.g., "the the").

## Limits of Regular Expressions
Regular expressions can only recognize "regular languages." They cannot:
- Check for balanced parentheses.
- Match patterns requiring counting (e.g., n occurrences of 'a' followed by n occurrences of 'b').
- Parse complex programming languages like Java or Python.

## Related/See-also
- [[Regular Expressions/Regex Basics|Regex Basics and Syntax]]
- [[Regular Expressions/Regex Tools|Regex Tools and Applications]]
