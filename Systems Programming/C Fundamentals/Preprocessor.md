# CSE333: Preprocessor

The **C Preprocessor (cpp)** transforms source code before the compiler runs. It is a simple copy-and-replace text processor that operates purely on text — it has no understanding of C syntax or types.

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

Allows changing which code gets compiled based on defined symbols. This is useful for platform-specific code or enabling debug traces.

```c
#ifdef TRACE
    printf("Debug info\n");
#endif
```

Symbols can also be defined via the `gcc` command line: `gcc -DTRACE ...`. Defining `NDEBUG` disables `assert()` macros.

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

If `main.c` uses a macro defined in `foo.h` but only includes `bar.h` (which does not include `foo.h`), compilation will fail because the macro remains unexpanded and the compiler does not recognize it as valid C.

### Scenario: Macro Expansion

Macros are expanded recursively. If `#define IT 42` and `#define MORE IT + 1`, then `MORE` expands to `42 + 1`. Note that the expansion is literal text: `MORE * 2` expands to `42 + 1 * 2`, which evaluates to `44`, not `86`. This is precisely why parentheses are critical: `#define MORE (IT + 1)`.

## Related

- [[GCC Workflow|GCC Workflow]]
- [[Linkage and Visibility|Linkage and Visibility]]
- [[Introduction to C|Introduction to C]]

## Industry Standard Terms

- **Preprocessor** — Also called the "macro preprocessor"; modern IDEs expose preprocessor output via flags like `-E`
- **Header guard** — Also implemented via `#pragma once` in most modern compilers as a simpler alternative
- **Conditional compilation** — Widely used for cross-platform portability (e.g., `#ifdef _WIN32` vs. `#ifdef __linux__`)
