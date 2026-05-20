# CSE391: Text Editors

Text editors are essential tools for developers and system administrators. They allow you to create and modify source code, configuration files, and documentation.

## Types of Editors

- **Terminal Editors:** These run directly inside the terminal window and do not require a mouse. They are extremely fast and can be used on remote servers via SSH. (e.g., **Vim**, **Nano**, **Emacs**)
- **GUI Editors:** These are standalone programs with a graphical interface. They are more user-friendly but less efficient for remote work. (e.g., **VS Code**, **Sublime Text**, **Gedit**)

---

## Vim (Vi IMproved)

**Vim** is a highly powerful and ubiquitous editor, but it has a steep learning curve because it is **modal**. This means that keys do different things depending on which "mode" you are in.

### The Three Main Modes of Vim

| Mode | How to Enter | What It Does |
| :--- | :--- | :--- |
| **Normal** | Press `Esc` | Default mode. Used for navigation and deleting/moving text. |
| **Insert** | Press `i` | Used for typing and adding text to the file. |
| **Command** | Press `:` | Used for saving, quitting, and search-and-replace. |

### Essential Vim Commands

- **Save and Quit:** `:wq` (Write and Quit)
- **Quit without Saving:** `:q!` (Quit and force)
- **Search:** `/pattern` (Press `n` to go to the next match)
- **Delete current line:** `dd`
- **Undo:** `u`
- **Redo:** `Ctrl + r`

---

## Nano

**Nano** is a simple and straightforward editor that is much easier to learn for beginners. It is "modeless," meaning you can always type directly into the file.

### Essential Nano Commands

Commands are shown at the bottom of the screen using the `^` (Control) symbol.

- **Save:** `Ctrl + o` (Write Out)
- **Exit:** `Ctrl + x`
- **Search:** `Ctrl + w` (Where Is)
- **Cut line:** `Ctrl + k`
- **Paste line:** `Ctrl + u` (Uncut)

---

## Which Editor Should You Use?

- **Use Nano** if you need to make a quick change to a file and do not want to learn complex shortcuts.
- **Use Vim** if you plan to spend a lot of time working in a Linux terminal and want to become highly efficient at editing.

## Related
- [[CSE391/Linux Fundamentals/Introduction to Linux|Introduction to Linux]]
- [[CSE391/Linux Fundamentals/Shell|The Shell]]
- [[CSE391/Users Groups and Permissions/Shell Customization|Shell Customization (Setting $EDITOR)]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Terminal Editor | CLI text editor |
| Vim | Vi IMproved — modal text editor (vi-compatible) |
| Nano | GNU nano — non-modal terminal text editor |
