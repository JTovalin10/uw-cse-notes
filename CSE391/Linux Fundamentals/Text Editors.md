# Text Editors in Unix/Linux

Text editors are essential tools for developers and system administrators. They allow you to create and modify source code, configuration files, and documentation.

## Types of Editors
- **Terminal Editors:** These run directly inside the terminal window and do not require a mouse. They are extremely fast and can be used on remote servers via SSH. (e.g., **Vim**, **Nano**, **Emacs**)
- **GUI Editors:** These are standalone programs with a graphical interface. They are more user-friendly but less efficient for remote work. (e.g., **VS Code**, **Sublime Text**, **Gedit**)

---

## 1. Vim (Vi IMproved)
Vim is a highly powerful and ubiquitous editor, but it has a steep learning curve because it is **modal**. This means that keys do different things depending on which "mode" you are in.

### The Three Main Modes of Vim
| Mode | How to Enter | What it does |
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

## 2. Nano
Nano is a simple and straightforward editor that is much easier to learn for beginners. It is "modeless," meaning you can always type directly into the file.

### Essential Nano Commands
Commands are shown at the bottom of the screen using the `^` (Control) symbol.
- **Save:** `Ctrl + o` (Write Out)
- **Exit:** `Ctrl + x`
- **Search:** `Ctrl + w` (Where Is)
- **Cut line:** `Ctrl + k`
- **Paste line:** `Ctrl + u` (Uncut)

---

## Which one should I use?
- **Use Nano** if you need to make a quick change to a file and don't want to learn complex shortcuts.
- **Use Vim** if you plan to spend a lot of time working in a Linux terminal and want to become highly efficient at editing.

## Related/See-also
- [[Introduction to Linux\|Introduction to Linux]]
- [[Shell\|The Shell]]
- [[Shell Customization\|Shell Customization (Setting $EDITOR)]]
