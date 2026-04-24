# CSE391: Variables and Arithmetic

Bash variables are dynamic and weakly typed, but they require specific syntax for common operations.

## Variables
- **Assignment**: `VAR=value` (Crucially, **no spaces** around the `=` sign).
- **Access**: Use the `$` symbol to retrieve a variable's value: `echo $VAR`.
- **Naming**: Typically uppercase by convention (e.g., `$PATH`, `$HOME`), but not required.

## Quoting
- **Double Quotes (`"")**: Performs **variable expansion** (e.g., `"$name"`) and handles some special characters.
- **Single Quotes (`''`)**: Literal interpretation; no expansion occurs.

## Arithmetic
Bash treats variables as strings by default. To perform calculations, use one of these methods:
- **`let` command**: `let a="$b / 2"`
- **Arithmetic Expansion**: `$(( expression ))` (e.g., `result=$(( 5 + 2 ))`)

## Related
- [[Bash Scripting Basics]]
- [[Comparisons]]
- [[Control Flow]]
