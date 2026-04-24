# Git Fundamentals

**Version Control** is software that keeps track of changes to a set of files. **Git** is the industry-standard distributed version control system used for software development.

## Core Concepts

### Repository (Repo)
A **Repository** is a location that stores all files and the entire history of changes. 
- **Local Repo:** Stored on your own machine (in the `.git` folder).
- **Remote Repo:** Stored on a server like **GitLab** or GitHub.

### Commit
A **Commit** is a group of changes saved to the repository's history. Each commit has a unique ID (a hash) and a message explaining the changes. Commits form a tree-like structure where each commit points to its parent.

### Branch
A **Branch* is a lightweight, moveable pointer to a specific commit. The default branch is usually named `main` or `master`. Branches allow multiple lines of development to exist simultaneously (e.g., one for a new feature, one for a bug fix).

### HEAD
**HEAD** is a special pointer that indicates your current location in the repository. It usually points to the latest commit on your current branch.

---

## Essential Commands & Usage

### 1. Initialize a Repository
Start tracking a project with Git.
```bash
git init
```

### 2. Check Status
See which files are modified, staged, or untracked.
```bash
git status
```

### 3. Stage Changes
Tell Git which changes you want to include in the next commit.
```bash
git add filename.txt    # Stage a specific file
git add .               # Stage all modified files
```

### 4. Create a Commit
Save your staged changes to the history.
```bash
git commit -m "Add descriptive message here"
```

### 5. View History
See a chronological list of all commits.
```bash
git log
git log --oneline --graph --all  # Visual tree representation
```

### 6. Create or Switch Branches
Manage different lines of development.
```bash
git branch feature-name       # Create a new branch
git checkout feature-name     # Switch to a branch
git checkout -b new-branch    # Create and switch in one step
```

## Why use Version Control?
- **Safety:** Revert to a last working version if code breaks.
- **Collaboration:** Multiple people can work on the same project without overwriting each other's work.
- **Traceability:** Track exactly who changed what, when, and why.
- **Experimentation:** Use branches to try new ideas without affecting the stable code.

## Related/See-also
- [[Four Phases of Git\|The Four Phases of Git]]
- [[Branching and Merging\|Branching and Merging]]
- [[Remote Repositories\|Remote Repositories]]
- [[Git Workflow\|Git Workflow]]
