# CSE 333: Introduction to C

C was created in 1972 by **Dennis Ritchie** at Bell Labs. It was designed for creating **system software** and remains highly portable across machine architectures.

## Characteristics of C
- **Low-level language**: Allows exploitation of underlying architecture features.
- **Easy to fail**: While powerful, it is "easy to fail spectacularly" due to lack of safety nets.
- **Procedural**: Not object-oriented.
- **Typed but unsafe**: It is possible to bypass the type system (e.g., via casting).
- **Small standard library**: Much smaller compared to Java or C++.

## Generic Program Layout
A typical C program follows this structure:
```c
#include <system_files>
#include "local_files"

#define macro_name macro_expr

/* Function Declarations (Prototypes) */
int sumTo(int max);

/* External Variable & Struct Declarations */

int main(int argc, char* argv[]) {
    /* Implementation */
    return 0;
}

/* Function Definitions */
int sumTo(int max) {
    // ...
}
```

## Compilation Workflow
The process of turning source code into an executable involves several stages managed by **gcc**:
1. **Edit**: Create `.c` and `.h` files.
2. **Compile**: `gcc -c` produces **object files** (`.o`).
3. **Link**: `ld` (or `gcc`) combines object files and libraries (like `libc`) into an **executable**.
4. **Execute/Debug**: Run the program and use tools like `gdb` or `valgrind`.

## Execution Results
- **Exit Codes**: Processes return an integer exit code on termination (e.g., `EXIT_SUCCESS` or `EXIT_FAILURE`).
- **Crashes**: Bad operations often result in a **Segmentation Fault**, which is the "good" option compared to silent memory corruption.

Related: [[GCC Workflow]], [[Preprocessor]], [[Linkage and Visibility]]
