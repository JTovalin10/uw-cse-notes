# CSE484: How to Use GDB for Exploit Debugging

**GDB (GNU Debugger)** is the primary tool used in this course to inspect program state and develop buffer overflow exploits.

## Launching GDB

```
gdb -e exploit0 -s ../targets/target0 -d ../target
```

- `-e`: specifies the executable to run
- `-s`: specifies the symbol file
- `-d`: specifies the directory to search for source files

## Setting Breakpoints and Running

| Command | Description |
|---|---|
| `catch exec` | Break when `exec` is called into a new process |
| `run` | Start the program |
| `break main` | Set a breakpoint at `main` |
| `continue` | Continue execution after a breakpoint |

## Useful GDB Commands

| Command | Description |
|---|---|
| `step` / `s` | Execute the next source code line (steps into function calls) |
| `next` / `n` | Step over function calls |
| `stepi` / `si` | Execute the next assembly instruction |
| `list` | Display source code |
| `disassemble` / `disas` | Disassemble a specified function |
| `info register` | Inspect current register values |
| `info frame` | Information about the current stack frame |
| `print` / `p` | Inspect a variable — e.g., `p &buf` (address) or `p buf` (value) |

## Examining Memory

Use `x` followed by `/` and a format specifier:

| Command | Description |
|---|---|
| `x/20xw 0xbffffcd4` | Print 20 words in hex starting at address `0xbffffcd4` |
| `x/20x 0xbffffcd4` | Same as above (shorthand) |
| `x/5i $eip` | Print 5 assembly instructions starting at `%eip` |

Format letters:
- `x` — hexadecimal
- `i` — instruction (assembly)
- `w` — word (4 bytes)

## Related

- [[Buffer Overflows]] — what GDB is used to debug and exploit
- [[Stack]] — registers visible in GDB (`%ebp`, `%esp`, `%EIP`)
- [[Memory Layout in a Program]] — memory regions you will inspect with GDB
