# CSE391: Pipes

A **Pipe** (`|`) is an operator that redirects the **stdout** of one command into the **stdin** of another command.
 This allows for combining many small, specialized programs to solve complex problems, a core part of the **Unix Philosophy**.

## Basic Usage
`command1 | command2`
The output of `command1` becomes the input for `command2`.

### Examples
- **Removing duplicates:** `sort veggies.txt | uniq` (sorts the file first, then removes adjacent duplicates).
- **Counting specific occurrences:** `grep "a" berries.txt | grep "e" | wc -l` (finds lines with 'a', filters those for 'e', then counts the remaining lines).

## Why use Pipes?
- **Efficiency:** Solve complex data processing tasks in a single line.
- **Modularity:** Use existing tools instead of writing custom scripts.
- **Power:** Chain as many commands as needed.

## Related/See-also
- [[Streams Redirection and Pipes/Standard Streams|Standard Streams]]
- [[Streams Redirection and Pipes/Input Output Redirection|Input/Output Redirection]]
- [[Streams Redirection and Pipes/Common Shell Commands|Common Shell Commands]]
