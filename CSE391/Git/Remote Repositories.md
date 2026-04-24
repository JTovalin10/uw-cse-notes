# Remote Repositories in Git

A **Remote Repository** is a version of your project that is hosted on the Internet or some other network. This allows you to backup your work and collaborate with others.

## 1. Connecting to a Remote

### Clone a repository
The most common way to start working on a project. It downloads the entire repository and its history.
```bash
git clone https://gitlab.cs.washington.edu/username/project.git
```

### Add a remote to an existing project
Connect a local project to a new remote server.
```bash
git remote add origin https://gitlab.cs.washington.edu/username/project.git
```

### Check existing remotes
Lists the short names and URLs of the remotes you have connected.
```bash
git remote -v
```

---

## 2. Interacting with the Remote

### Push changes
Upload your local commits to the server.
```bash
git push origin main
```
*Note: `origin` is the default name for the remote server, and `main` is the name of the branch you are pushing.*

### Fetch changes
Download new data from the remote server, but **do not** merge it into your local files. This is safe and allows you to see what others have done before you merge.
```bash
git git fetch origin
```

### Pull changes
Download new data and **immediately** merge it into your current branch. This is equivalent to running `git fetch` followed by `git merge`.
```bash
git pull origin main
```

---

## 3. Remote Tracking Branches
When you clone a repository, Git creates "remote tracking branches" (e.g., `origin/main`). These are pointers to the state of the branches on the server as of the last time you communicated with it (`fetch` or `pull`).

### Viewing all branches (including remote ones)
```bash
git branch -a
```

## Related/See-also
- [[Git Fundamentals\|Git Core Concepts (Repo, Branch, Commit)]]
- [[Four Phases of Git\|The Four Phases of Git]]
- [[Git Workflow\|The Standard Git Workflow]]
