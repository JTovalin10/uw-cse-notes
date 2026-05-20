# CSE391: Find and Replace with Sed

The most common use of **[[CSE391/Sed/Sed Commands|sed]]** is for finding and replacing text using the substitution command.

## Substitution Syntax

`sed 's/pattern/replacement/flags' file`

- `s`: The substitute command.
- `pattern`: The [[CSE391/Regular Expressions/Regex Basics|regular expression]] to search for.
- `replacement`: The text to replace it with.
- `flags`: Optional modifiers (e.g., `g` for global replacement).

### Examples

- **Basic replace:** `sed 's/UW/University of Washington/' file` (replaces the first occurrence of "UW" on each line).
- **Global replace:** `sed 's/cat/dog/g' file` (replaces all occurrences of "cat" on every line).
- **Using backreferences:** `sed -E 's/([a-z]+)@uw.edu/\1@cs.washington.edu/' emails.txt` (changes the domain while keeping the username captured in `\1`).

## Workflow Tips

1. **Test first:** Run `sed` without the `-i` flag to see the output in the console.
2. **Use grep:** Use `grep -E` to verify your regex matches the right lines before using it in `sed`.
3. **Regex delimiters:** You can use characters other than `/` as delimiters if your pattern contains slashes (e.g., `sed 's|/usr/bin|/usr/local/bin|'`).

## Related
- [[CSE391/Sed/Sed Commands|Detailed Sed Reference (Flags & Examples)]]
- [[CSE391/Sed/Sed Basics|Sed Basics]]
- [[CSE391/Regular Expressions/Advanced Regex|Advanced Regex and Backreferences]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Substitution command (`s`) | sed `s` command — POSIX stream substitution |
| Global flag (`g`) | Global replace modifier |
| Backreference (`\1`) | Regex backreference — captured group |
