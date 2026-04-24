# CSE391: Find and Replace with Sed

The most common use of **[[Sed Commands\|sed]]** is for finding and replacing text using the substitution command.

## Substitution Syntax
`sed 's/pattern/replacement/flags' file`

- `s`: The substitute command.
- `pattern`: The regular expression to search for.
- `replacement`: The text to replace it with.
- `flags`: Optional modifiers (e.g., `g` for global replacement).

### Examples
- **Basic replace:** `sed 's/UW/University of Washington/' file` (replaces the first occurrence of "UW" on each line).
- **Global replace:** `sed 's/cat/dog/g' file` (replaces all occurrences of "cat" on every line).
- **Using Backreferences:** `sed -E 's/([a-z]+)@uw.edu/\1@cs.washington.edu/' emails.txt` (changes the domain while keeping the username).

## Workflow Tips
1. **Test first:** Run `sed` without the `-i` flag to see the output in the console.
2. **Use grep:** Use `grep -E` to verify your regex matches the right lines before using it in `sed`.
3. **Regex delimiters:** You can use characters other than `/` as delimiters if your pattern contains slashes (e.g., `sed 's|/usr/bin|/usr/local/bin|'`).

## Related/See-also
- [[Sed Commands\|Detailed Sed Reference (Flags & Examples)]]
- [[Sed Basics\|Sed Basics]]
- [[Regular Expressions/Advanced Regex|Advanced Regex and Backreferences]]
