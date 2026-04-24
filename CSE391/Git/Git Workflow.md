# CSE391: Git Workflow and Best Practices

A typical Git workflow involves iterative cycles of development, staging, and committing.

## Standard Development Cycle
1. **Pull** latest changes: `git pull origin main`
2. Create a **Branch**: `git checkout -b my-feature`
3. **Work** on code in the Working Directory.
4. **Stage** changes: `git add <files>`
5. **Commit** changes: `git commit -m "Description of changes"`
6. **Push** to remote: `git push origin my-feature`
7. Open a **Pull Request** (or Merge Request) for review.
8. **Merge** into `main` after approval.

## Best Practices
- **Commit often:** Small, atomic commits are easier to understand and revert.
- **Write good messages:** Summarize *what* changed and *why*.
- **Keep main stable:** Do not commit broken code to the `main` branch.
- **Pull before you push:** Ensure you have the latest changes to avoid conflicts.
- **Don't alter shared history:** Avoid using `git reset --hard` or force-pushing on branches others are using. Use `git revert` instead.

## Related/See-also
- [[Git/Git Fundamentals|Git Fundamentals]]
- [[Git/Branching and Merging|Branching and Merging]]
