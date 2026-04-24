# CSE391: The Four Phases of Git

Git manages changes through four distinct areas or "phases."

| Phase | Description | Key Command |
|---|---|---|
| **Working Directory** | Your actual files on disk where you make changes. | |
| **Staging Area** (Index) | Changes you are preparing to include in the next commit. | `git add` |
| **Local Repository** | Your local copy of the history with committed changes. | `git commit` |
| **Remote Repository** | A shared copy of the repository (e.g., on GitHub or GitLab). | `git push` |

## Basic Commands
- `git status`: Shows which files are in which phase.
- `git add <file>`: Moves changes from the Working Directory to the Staging Area.
- `git commit -m "message"`: Moves changes from the Staging Area to the Local Repository.
- `git push`: Sends committed changes from the Local Repository to the Remote Repository.
- `git pull`: Fetches and merges changes from the Remote Repository to your Local Repository.

## Related/See-also
- [[Git/Git Fundamentals|Git Fundamentals]]
- [[Git/Remote Repositories|Remote Repositories]]
