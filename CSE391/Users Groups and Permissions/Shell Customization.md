# Shell Customization

You can customize your shell environment by modifying configuration files that run automatically when you start a new shell session. This is the key to creating an efficient and personalized development environment.

## Configuration Files

### .bashrc (Non-login shell)
Executed for every new shell (e.g., when you open a new terminal window or run `bash`).
- **Best for:** Aliases, shell functions, custom prompt (`PS1`).

### .bash_profile (Login shell)
Executed only when you first log in (e.g., via `ssh`).
- **Best for:** Environment variables (like `PATH`), and commands that should run once per session.
- **Tip:** Many `.bash_profile` files contain a script to "source" (load) the `.bashrc` automatically.

---

## Aliases
Aliases allow you to create short nicknames for long or frequently used commands.
- **Syntax:** `alias name='command --options'`
- **Note:** Do NOT put spaces around the `=` sign.

### Useful Alias Examples
```bash
alias ll='ls -al'          # Long listing, including hidden files
alias ..='cd ..'           # Go up one directory
alias ...='cd ../..'       # Go up two directories
alias grep='grep --color'  # Highlight matches in grep
alias update='sudo apt update && sudo apt upgrade' # Shortcut for updates
```

To remove an alias temporarily, use `unalias name`.

---

## Environment Variables
Environment variables affect the behavior of your shell and other programs.
- **Setting:** `export VARIABLE_NAME=value`
- **Viewing:** `printenv` or `echo $VARIABLE_NAME`

### Common Environment Variables
- **$PATH**: List of directories to search for programs.
- **$EDITOR**: Default text editor (e.g., `vim`, `nano`).
- **$HOME**: Path to your home directory.
- **$USER**: Your current username.
- **$PS1**: Defines the look of your command prompt.

---

## Shell Functions (Advanced)
If a command is too complex for an alias (e.g., it needs arguments), use a function.
```bash
# A function to create a directory and immediately enter it
mkcd() {
    mkdir -p "$1"
    cd "$1"
}

# A function to search for a process by name
psgrep() {
    ps aux | grep -v grep | grep -i "$1"
}
```

---

## Applying Changes
After editing your `.bashrc`, the changes will not take effect in your current session unless you "source" the file:
```bash
source ~/.bashrc
# OR
. ~/.bashrc
```

## Related/See-also
- [[The PATH Variable\|The PATH Variable]]
- [[Linux Fundamentals/Text Editors\|Text Editors (Vim & Nano)]]
- [[Bash Scripting Basics\|Bash Scripting Basics]]
