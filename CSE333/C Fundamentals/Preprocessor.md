# CSE 333: Preprocessor

The **C Preprocessor (cpp)** transforms source code before the compiler runs. It is a simple copy-and-replace text processor.

## Directives
Directives begin with `#` and are processed by `cpp`.
- **#include**: Replaced by the post-processed content of the specified file.
  - `<foo.h>`: Looks in system library directories.
  - `"foo.h"`: Looks in the current directory first, then system directories.
- **#define**: Defines a macro symbol.
  - Used for constants: `#define PI 3.14159`
  - Used for macros with arguments: `#define ODD(x) ((x) % 2 != 0)`
  - **Warning**: Always use parentheses in macros to avoid operator precedence issues.

## Conditional Compilation
Allows changing which code gets compiled based on defined symbols.
```c
#ifdef TRACE
    printf("Debug info\n");
#endif
```
Symbols can also be defined via `gcc` command line: `gcc -DTRACE ...`.
Defining `NDEBUG` disables `assert()` macros.

## Header Guards
Standard trick to prevent multiple definition errors when a header is included multiple times (directly or indirectly).
```c
#ifndef _FILENAME_H_
#define _FILENAME_H_

/* declarations */

#endif // _FILENAME_H_
```

## Compilation Scenarios
Understanding how includes and macros interact is key to debugging preprocessor issues.

### Scenario: Multiple Includes and Header Guards
Consider `foo.h` (defines `IT` and `MORE`) and `bar.h` (includes `foo.h`). If `main.c` includes both, header guards in `foo.h` ensure its contents are only processed once.

### Scenario: Undefined Macros
If `main.c` uses a macro defined in `foo.h` but only includes `bar.h` (which doesn't include `foo.h`), compilation will fail because the macro remains unexpanded and the compiler doesn't recognize it as valid C.

### Scenario: Macro Expansion
Macros are expanded recursively. If `#define IT 42` and `#define MORE IT + 1`, then `MORE` expands to `42 + 1`. Note that the expansion is literal text: `MORE * 2` expands to `42 + 1 * 2`, which is `44`, not `86`. This is why parentheses are critical: `#define MORE (IT + 1)`.

## Related
- [[Build Systems/GCC Workflow|GCC Workflow]]
- [[Linkage and Visibility]]
- [[Introduction to C]]
