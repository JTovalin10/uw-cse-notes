# CSE 333: GCC Workflow

The **GNU Compiler Collection (gcc)** handles the transformation of C source code into machine-executable binaries through several distinct stages.

## Compilation Stages
1. **Preprocessing (`cpp`)**:
   - Handles directives (`#include`, `#define`, `#ifdef`).
   - Removes comments.
   - Result: Post-processed C source code.
   - Manual run: `gcc -E foo.c`
2. **Compilation (`cc1`)**:
   - Translates C code into **Assembly Language** specific to the target architecture (e.g., x86-64).
   - Manual run: `gcc -S foo.c` (generates `foo.s`)
3. **Assembly (`as`)**:
   - Translates assembly code into **Machine Code** (binary).
   - Result: An **Object File** containing machine code and a symbol table.
   - Manual run: `gcc -c foo.c` (generates `foo.o`)
4. **Linking (`ld`)**:
   - Combines multiple object files and libraries (e.g., `libc`) into a single executable binary.
   - Resolves symbol references between files.

## Common GCC Flags
- `-Wall`: Enable all standard warnings (highly recommended).
- `-g`: Include debugging information for `gdb`.
- `-std=c11`: Use the C11 language standard.
- `-o <name>`: Specify the output filename.
- `-c`: Compile but do not link (generates `.o` file).

Related: C Fundamentals/Preprocessor, [[Makefiles]]
