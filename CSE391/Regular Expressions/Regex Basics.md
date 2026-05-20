# CSE391: Regex Basics and Syntax

**Regular Expressions** (or "regex") are a sequence of characters that define a search pattern. They are used for pattern matching and string search within text. In CSE391, we primarily use **Extended Regular Expressions (ERE)** via `grep -E`.

## Basic Anchor Syntax

| Syntax | Functionality | Example | Matches |
| :--- | :--- | :--- | :--- |
| `.` | Matches **any single character** (except newline). | `c.t` | cat, cot, c9t |
| `^` | Matches the **start** of a line. | `^Hello` | "Hello world" |
| `$` | Matches the **end** of a line. | `done$` | "Task is done" |
| `\<` | Matches the **start of a word**. | `\<cat` | "cat", but not "scat" |
| `\>` | Matches the **end of a word**. | `cat\>` | "cat", but not "cats" |
| `\|` | Logical **OR** (alternation). | `cat\|dog` | cat, dog |

## Quantifiers (Repetition)

| Syntax | Functionality | Example | Matches |
| :--- | :--- | :--- | :--- |
| `*` | **Zero or more** occurrences. | `ab*c` | ac, abc, abbc |
| `+` | **One or more** occurrences. | `ab+c` | abc, abbc (not ac) |
| `?` | **Zero or one** occurrence. | `ab?c` | ac, abc |
| `{n}` | Exactly **n** occurrences. | `a{3}` | aaa |
| `{n,}` | **n or more** occurrences. | `a{2,}` | aa, aaa, aaaa |
| `{n,m}` | Between **n and m** occurrences. | `a{2,4}` | aa, aaa, aaaa |

## Character Sets

| Syntax | Functionality | Example | Matches |
| :--- | :--- | :--- | :--- |
| `[abc]` | Any **one** of the characters inside. | `[Cc]at` | Cat, cat |
| `[^abc]` | Any character **except** those inside. | `[^0-9]` | Any non-digit |
| `[a-z]` | Any lowercase letter range. | `[a-m]` | a, b, ... m |
| `[A-Z]` | Any uppercase letter range. | `[A-G]` | A, B, ... G |
| `[0-9]` | Any digit range. | `[5-9]` | 5, 6, 7, 8, 9 |
| `[a-zA-Z0-9]` | Any alphanumeric character. | | |

---

## Formal Definition

### Formal Definition
An **Extended Regular Expression (ERE)** is a formal language defined inductively:
- A single character `c` matches itself.
- `.` matches any character except newline.
- `[abc]` matches any character in the set.
- `[^abc]` matches any character not in the set.
- `r*`, `r+`, `r?` are repetition quantifiers over an expression `r`.
- `r{n,m}` matches between `n` and `m` repetitions of `r`.
- `r1r2` (concatenation) matches `r1` followed by `r2`.
- `r1|r2` (alternation) matches either `r1` or `r2`.
- `(r)` groups `r` for precedence or backreference capture.

### Simplified Explanation
A regex is a mini-language for describing patterns in text. You build a pattern by stringing together characters, wildcards (`.`), character classes (`[a-z]`), and quantifiers (`*`, `+`) to match exactly what you are looking for.

---

## Practical Usage Examples

### (1) Finding specific words (case-insensitive)
Search for "apple" regardless of capitalization.
```bash
grep -Ei "apple" file.txt
```

### (2) Matching lines starting with a pattern
Find all lines that start with a digit.
```bash
grep -E "^[0-9]" data.log
```

### (3) Matching specific word lengths
Find words that are exactly 4 letters long.
```bash
grep -E "\<[a-zA-Z]{4}\>" text.txt
```

### (4) Matching phone numbers (simple)
Match a pattern like `555-555-5555`.
```bash
grep -E "[0-9]{3}-[0-9]{3}-[0-9]{4}" contacts.txt
```

### (5) Filtering out empty lines
Show only lines that contain at least one character.
```bash
grep -v -E "^$" file.txt
# OR
grep -E "." file.txt
```

### (6) Complex alternation
Find lines containing either "ERROR" or "CRITICAL".
```bash
grep -E "ERROR|CRITICAL" system.log
```

## Related
- [[CSE391/Regular Expressions/Advanced Regex|Advanced Regex and Backreferences]]
- [[CSE391/Regular Expressions/Regex Tools|Regex Tools and Applications]]
- [[CSE391/Linux Fundamentals/Commands/grep|grep Command]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Regular Expression (regex) | Regular expression — POSIX BRE or ERE |
| ERE | Extended Regular Expression (POSIX ERE) |
| grep -E | `egrep` or `grep --extended-regexp` |
