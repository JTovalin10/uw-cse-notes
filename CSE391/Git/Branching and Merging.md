# CSE391: Branching and Merging

**Branching** allows you to depart from the main line of development and continue to work without affecting that main line.

## Why use Branches?
- **Isolation:** Keep the `main` branch stable while working on new features.
- **Parallelism:** Work on multiple features or bugs simultaneously.
- **Collaboration:** Team members can work on their own branches and merge them when ready.

## Key Commands
- `git branch <name>`: Creates a new branch.
- `git checkout <name>`: Switches to the specified branch.
- `git checkout -b <name>`: Creates and switches to a new branch in one step.
- `git merge <name>`: Combines the changes from the specified branch into the current branch.

## Merge Conflicts
A **Merge Conflict** occurs when Git cannot automatically resolve differences between two branches being merged (e.g., the same line was changed in both). You must manually edit the file to resolve the conflict and then commit the result.

## Related/See-also
- [[Git/Git Fundamentals|Git Fundamentals]]
- Git Workflow and Best Practices
