# CSE391: The PATH Variable

The **$PATH** variable is one of the most important environment variables in Unix/Linux. It tells the shell which directories to search for executable programs when you type a command.

## How it Works
When you type a command like `ls`, the shell does the following:
1. It looks at the `$PATH` variable, which is a colon-separated list of directories (e.g., `/usr/bin:/bin:/usr/sbin`).
2. It searches each directory in order for an executable file named `ls`.
3. If found, it executes that file.
4. If it reaches the end of the list without finding the file, it prints "command not found."

## Modifying the PATH
You can add new directories to your path in your `.bashrc` or `.bash_profile`.
- **Prepend** (search first): `export PATH=/new/dir:$PATH`
- **Append** (search last): `export PATH=$PATH:/new/dir`

## Security Note
Never add `.` (the current directory) to the beginning of your `$PATH`, as this can allow malicious programs in your current directory to "shadow" standard system commands.

## Related/See-also
- [[Users Groups and Permissions/Shell Customization|Shell Customization]]
- [[Linux Fundamentals/Basic Commands|Basic Commands]]
