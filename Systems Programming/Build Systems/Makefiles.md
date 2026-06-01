# CSE333: Makefiles

**Makefiles** are used to automate the build process, ensuring that only modified files and their dependents are recompiled. This is essential for large projects where recompiling everything from scratch after each change would be prohibitively slow.

## Concept: Dependency Graph

`make` builds a directed acyclic graph (DAG) of dependencies. A file is rebuilt only if any of its dependencies have a newer timestamp than the target. This is why `make` is efficient — it avoids redundant work.

## Syntax

A Makefile consists of **Rules**:

```makefile
target: sources
    command
```

- **target**: The file to be generated (or a phony label).
- **sources**: The files the target depends on.
- **command**: The shell command to generate the target. **Must be indented with a TAB character**, not spaces — `make` will fail if spaces are used.

## Variables

Variables allow for easy configuration and reuse across rules:

```makefile
CC = gcc
CFLAGS = -Wall -g -std=c11

myprog: main.o util.o
    $(CC) $(CFLAGS) -o myprog main.o util.o
```

## Automatic Variables

Automatic variables are set by `make` during rule execution and refer to parts of the rule:

- `$@`: The name of the target.
- `$^`: The names of all sources (dependencies).
- `$<`: The name of the first source.

Example using automatic variables:

```makefile
%.o: %.c
    $(CC) $(CFLAGS) -c $< -o $@
```

This pattern rule compiles any `.c` file into the corresponding `.o` file.

## Phony Targets

**Phony targets** are targets that do not represent actual files. They are used for utility actions like cleaning up or building everything.

```makefile
.PHONY: clean all

all: myprog

clean:
    rm -f *.o myprog
```

Declaring a target as `.PHONY` prevents `make` from confusing it with a file of the same name.

## Related

- [[GCC Workflow|GCC Workflow]]
- [[Linkage and Visibility|Linkage and Visibility]]
- [[Preprocessor|Preprocessor]]

## Industry Standard Terms

- **Makefile** — The original build automation tool; modern alternatives include CMake, Bazel, Ninja, and Meson, but Makefiles remain common in systems software
- **Dependency graph (DAG)** — The underlying data structure `make` constructs to determine the minimal set of files to rebuild
- **Phony target** — A build target with no corresponding output file; equivalent to a "task" in Gradle or a "target" in Bazel that produces no artifact
