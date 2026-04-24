# CSE391: Regex Basics and Syntax

**[[Regular Expressions]]** (or "regex") are a sequence of characters that define a search pattern. They are used for pattern matching and string search within text.

## Basic Syntax
| Syntax | Functionality |
|---|---|
| `.` | Matches any single character. |
| `^` | Matches the start of a line. |
| `$` | Matches the end of a line. |
| `\<` | Matches the start of a word. |
| `\>` | Matches the end of a word. |
| `\|` | Logical OR (matches either the pattern before or after). |

## Quantifiers
| Syntax | Functionality |
|---|---|
| `*` | Matches zero or more occurrences of the preceding element. |
| `+` | Matches one or more occurrences of the preceding element. |
| `?` | Matches zero or one occurrence of the preceding element. |
| `{n}` | Matches exactly `n` occurrences. |

## Character Sets
| Syntax | Functionality |
|---|---|
| `[abc]` | Matches any one of the characters: a, b, or c. |
| `[^abc]` | Matches any character *except* a, b, or c. |
| `[a-z]` | Matches any lowercase letter. |
| `[A-Z]` | Matches any uppercase letter. |
| `[0-9]` | Matches any digit. |

## Grep and Regex
In this course, we primarily use **[[grep]]** with the `-E` flag (Extended Regular Expressions) to search for patterns.
- Example: `grep -E "[dD]ubs"` matches lines with "dubs" or "Dubs".
- Example: `grep -E "^[A-Z]"` matches lines starting with an uppercase letter.

## Related/See-also
- [[Regular Expressions/Advanced Regex|Advanced Regex and Backreferences]]
- [[Regular Expressions/Regex Tools|Regex Tools and Applications]]
- [[Streams Redirection and Pipes/Common Shell Commands|Common Shell Commands]]
