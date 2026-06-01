# CSE391: Repositories

A **repository** (or "repo") in Git is a location that stores a copy of all files and their entire revision history.

## Distributed Version Control

Git is **distributed**, meaning every developer working on the project has a complete version of the repository on their own machine. They communicate changes by sending them to each other or a central remote.

## What to Include in a Repo

- **Source code** (e.g., `.java`, `.py`, `.c`).
- **Build and configuration files** (e.g., `Makefile`, `package.json`).
- **Assets and documentation**.

## What NOT to Include

- **Generated files** (e.g., `.class`, `.o`, `.exe`).
- **Temporary files**.
- **Large dependencies** (depending on the build system).
- Use a **.gitignore** file to tell Git which files to ignore.

## Related
- [[Git Fundamentals|Git Fundamentals]]
- [[Remote Repositories|Remote Repositories]]
- [[Git Workflow|Git Workflow and .gitignore]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Repository (repo) | Git repository |
| Distributed VCS | Distributed Version Control System (DVCS) |
| .gitignore | `.gitignore` — file pattern exclusion list |
