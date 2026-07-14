# CSE451: Command Interpreter (shell)

A **command interpreter (shell)** is a particular program that handles the interpretation of user commands and helps to manage [[Process|processes]].
- User input may come from the keyboard (command-line interface, or CLI), from script files, or from the mouse (graphical user interface, or GUI).
- The shell allows users to launch and control new programs — for example, by starting a [[Process Creation|new process]] via a fork/exec sequence and waiting for it to finish, or backgrounding it to run concurrently.

## Where the Shell Lives
The shell's relationship to the OS varies across systems:
- On some systems, the command interpreter may be a standard, built-in part of the OS itself.
- On others, it's just non-privileged code (i.e., it runs in [[User Mode|User Mode]] like any other application) that provides an interface to the user — for example, `bash`, `csh`, `tcsh`, and `zsh` on UNIX-like systems are all ordinary user-level programs, not part of the kernel.
- On others still, there may be no command language at all — for example, macOS's default end-user experience is built around a GUI rather than a shell, even though a UNIX shell is available underneath it.

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Command Interpreter (shell) | Shell / command-line interpreter (CLI) |
| CLI | Command-line interface |

## Related
- [[Operating Systems/Virtualization/Architecture/Major OS Components|Major OS Components]] — the shell as one of the major OS-adjacent components
- [[Process|Process]] — what the shell launches and controls
- [[User Mode|User Mode]] — the privilege level the shell itself runs at