# CSE391: Repositories

A **[[Repository]]** (or "repo") in Git is a location that stores a copy of all files and their entire revision history.

## Distributed Version Control
Git is **distributed**, meaning every developer working on the project has a complete version of the repository on their own machine. They communicate changes by sending them to each other or a central remote.

## What to include in a Repo
- **Source code** (e.g., `.java`, `.py`, `.c`).
- **Build and configuration files** (e.g., `Makefile`, `package.json`).
- **Assets and documentation**.

## What NOT to include
- **Generated files** (e.g., `.class`, `.o`, `.exe`).
- **Temporary files**.
- **Large dependencies** (depending on the build system).
- Use a **.gitignore** file to tell Git which files to ignore.

## Related/See-also
- [[Git/Git Fundamentals|Git Fundamentals]]
- [[Git/Remote Repositories|Remote Repositories]]
