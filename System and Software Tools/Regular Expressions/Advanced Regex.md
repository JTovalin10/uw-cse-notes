# CSE391: Advanced Regular Expressions

Advanced concepts in regular expressions including backreferences, building on the foundations in [[Regex Basics|Regex Basics and Syntax]].

## Backreferences

A **backreference** is used to match the same text as previously matched by a capturing group. A capturing group is created by wrapping part of a regex in parentheses `(...)`. The matched text is then referenceable as `\1`, `\2`, etc. (corresponding to the order of opening parentheses).

### Formal Definition

### Formal Definition
Given a regex `(r)\1`, where `(r)` is a capturing group matching expression `r`, the backreference `\1` asserts that the text at the current position must be identical to whatever `(r)` matched earlier in the same string.

### Simplified Explanation
A capturing group takes a "photo" of what it matched. A backreference says "I need the exact same text here that you photographed earlier."

### Example: Matching Repeated Characters
```bash
# Matches any two identical consecutive lowercase letters: aa, bb, cc, ...
grep -E "([a-z])\1" file.txt
```

### Example: Using Backreferences in sed
```bash
# Swap first and last name: "Justin Smith" → "Smith, Justin"
sed -E 's/([A-Z][a-z]+) ([A-Z][a-z]+)/\2, \1/' names.txt
```

In this example:
- `([A-Z][a-z]+)` captures the first name into `\1`.
- The space between the two groups is consumed but not captured.
- `([A-Z][a-z]+)` captures the last name into `\2`.
- The replacement `\2, \1` reverses them with a comma.

## Related
- [[Regex Basics|Regex Basics and Syntax]]
- [[Regex Tools|Regex Tools and Applications]]
- [[Sed Commands|Sed Command (Advanced search/replace)]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Backreference | Regex backreference (`\1`, `\2`, ...) |
| Capturing Group | Regex capturing group — `(pattern)` |
