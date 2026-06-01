# CSE391: Pipes

A **Pipe** (`|`) is an operator that redirects the **[[Standard Streams#(2) stdout (Standard Output) — File Descriptor 1|stdout]]** of one command into the **[[Standard Streams#(1) stdin (Standard Input) — File Descriptor 0|stdin]]** of another command. This allows for combining many small, specialized programs to solve complex problems — a core part of the **Unix Philosophy**.

## Basic Usage

`command1 | command2`

The output of `command1` becomes the input for `command2`.

### Examples

- **Removing duplicates:** `sort veggies.txt | uniq` (sorts the file first, then removes adjacent duplicates).
- **Counting specific occurrences:** `grep "a" berries.txt | grep "e" | wc -l` (finds lines with 'a', filters those for 'e', then counts the remaining lines).

## Pipe Flow Diagram

```mermaid
flowchart LR
    A[command1] -->|stdout| B["|  pipe"]
    B -->|stdin| C[command2]
    C -->|stdout| D["|  pipe"]
    D -->|stdin| E[command3]
    E -->|stdout| F[Terminal or File]
```

## Why Use Pipes?

- **Efficiency:** Solve complex data processing tasks in a single line.
- **Modularity:** Use existing tools instead of writing custom scripts.
- **Power:** Chain as many commands as needed.

## Related
- [[Standard Streams|Standard Streams]]
- [[Input Output Redirection|Input/Output Redirection]]
- [[System and Software Tools/Streams Redirection and Pipes/Common Shell Commands|Common Shell Commands]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Pipe (`|`) | Unix pipe — inter-process communication via stdout/stdin |
| Unix Philosophy | "Do one thing and do it well" — composable small tools |
