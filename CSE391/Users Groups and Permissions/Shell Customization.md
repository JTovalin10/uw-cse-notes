# CSE391: Shell Customization

You can customize your shell environment by modifying configuration files that run automatically when you log in or start a new shell session.

## Configuration Files
- **.bashrc**: Executed for every new non-login shell (e.g., when you open a new terminal window). This is the best place for aliases and shell functions.
- **.bash_profile**: Executed for login shells (e.g., when you first log in via SSH). It often calls `.bashrc`.

## Aliases
Aliases allow you to create short nicknames for long or frequently used commands.
- Example: `alias ll='ls -al'`
- Example: `alias ..='cd ..'`
Add these to your `.bashrc` to make them permanent.

## Shell Variables
You can set variables that affect the behavior of your shell and other programs.
- Example: `export EDITOR=vim` (sets the default text editor).
- Example: `PS1='[\u@\h \W]\$ '` (customizes the command prompt).

## Related/See-also
- [[Users Groups and Permissions/The PATH Variable|The PATH Variable]]
- [[Linux Fundamentals/Text Editors|Text Editors]]
