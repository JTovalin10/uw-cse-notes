# CSE 333: Makefiles

**Makefiles** are used to automate the build process, ensuring that only modified files and their dependents are recompiled.

## Concept: Dependency Graph
`make` builds a directed acyclic graph of dependencies. A file is rebuilt if any of its dependencies have a newer timestamp than the target.

## Syntax
A Makefile consists of **Rules**:
```makefile
target: sources
    command
```
- **target**: The file to be generated.
- **sources**: The files the target depends on.
- **command**: The shell command to generate the target. **Must be indented with a TAB.**

## Variables
Variables allow for easy configuration and reuse:
```makefile
CC = gcc
CFLAGS = -Wall -g -std=c11

myprog: main.o util.o
    $(CC) $(CFLAGS) -o myprog main.o util.o
```

## Automatic Variables
- `$@`: The name of the target.
- `$^`: The names of all sources.
- `$<`: The name of the first source.

## Phony Targets
Targets that don't represent actual files (e.g., `clean`, `all`).
```makefile
.PHONY: clean
clean:
    rm -f *.o myprog
```

Related: [[GCC Workflow]], [[C Fundamentals/Linkage and Visibility]]
