# CSE391: Regex Tools and Applications

Common tools that support [[Regex Basics|regular expressions]] in the Unix environment.

## grep

The most common tool for searching text using regular expressions. See the full reference at **[[grep|grep]]**.

Key flags for regex use:
- `-E`: Enable Extended Regular Expressions (ERE).
- `-i`: Case-insensitive matching.
- `-v`: Invert match (print non-matching lines).
- `-n`: Show line numbers with matches.

```bash
grep -E "^[0-9]{3}-[0-9]{4}$" phone_numbers.txt
```

## sed

A **stream editor** for filtering and transforming text using regex substitutions. See the full reference at **[[Sed Commands|sed]]**.

Key regex use case — the substitution command:
```bash
sed -E 's/([a-z]+)@uw\.edu/\1@cs.washington.edu/g' emails.txt
```

## Related
- [[Regex Basics|Regex Basics and Syntax]]
- [[Advanced Regex|Advanced Regex and Backreferences]]
- [[grep|grep Command]]
- [[Sed Commands|Detailed Sed Reference]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| grep | GNU grep — Global Regular Expression Print |
| sed | GNU sed — Stream EDitor |
| ERE | Extended Regular Expression |
