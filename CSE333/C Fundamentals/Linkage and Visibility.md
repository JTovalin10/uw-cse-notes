# CSE 333: Linkage and Visibility

Linkage determines whether symbols (variables and functions) are visible across different translation units (files).

## Linkage Types
- **External Linkage**: The symbol is visible to other files. This is the **default** for global variables and functions.
- **Internal Linkage**: The symbol is restricted to the file in which it is defined.

## Keywords
- **extern**: Declares a symbol that is defined elsewhere (usually in another `.c` file).
  - Used in header files to make globals available to modules that include them.
- **static**: When used in a global context, it forces **internal linkage**.
  - **Good Practice**: Use `static` to "defend" globals and functions, hiding internal implementation details from other modules.

## Module Conventions
- **.h files**: Should contain only declarations (prototypes, `extern` variables, `typedefs`), never definitions.
- **.c files**: Should contain definitions. Prototype declarations for exported functions belong in the `.h` file.
- **Inclusion**: NEVER `#include` a `.c` file.
- **Consistency**: A `.c` file should include its own `.h` file so the compiler can check for consistency between declarations and definitions.

Related: [[Preprocessor]], [[Build Systems/GCC Workflow]]
