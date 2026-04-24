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

Related: [[GCC Workflow]], [[Linkage and Visibility]]
