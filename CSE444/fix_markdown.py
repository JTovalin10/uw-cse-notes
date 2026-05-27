import os
import re

files = [
    "Transactions/Recovery/RecoveryComponents/LoggingComponents/Redo Logging.md",
    "Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo-Redo Logging.md",
    "Transactions/Recovery/RecoveryComponents/LoggingComponents/Checkpointing.md",
    "Transactions/Recovery/RecoveryComponents/LoggingComponents/Log Abstraction Levels.md",
    "Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo Logging.md",
    "Transactions/Recovery/RecoveryComponents/ARIES.md",
    "Transactions/Recovery/Recovery and Logging.md",
    "Transactions/Recovery/RecoveryComponents/Logging Types.md",
    "Transactions/Recovery/Recovery.md",
    "Transactions/Recovery/RecoveryComponents/Buffer Management Policies.md",
    "Transactions/Recovery/RecoveryComponents/Write-Ahead Logging (WAL).md"
]

# Regex to find <...> that are not already enclosed in backticks
# This is a bit complex in pure regex, so we'll do it carefully in Python.
pattern = re.compile(r'(?<!`)(<[^>`\n]+>)(?!`)')

for file_path in files:
    if not os.path.exists(file_path):
        print(f"Skipping {file_path}, not found.")
        continue
    
    with open(file_path, 'r') as f:
        lines = f.readlines()
    
    new_lines = []
    in_code_block = False
    for line in lines:
        if line.strip().startswith("```"):
            in_code_block = not in_code_block
            new_lines.append(line)
            continue
        
        if in_code_block:
            new_lines.append(line)
        else:
            # Also skip lines that are likely LaTeX math blocks if they have $ at start/end
            if line.strip().startswith("$") or line.strip().endswith("$"):
                 new_lines.append(line)
            else:
                 # Replace <...> with `<...>`
                 new_line = pattern.sub(r'`\1`', line)
                 new_lines.append(new_line)
    
    with open(file_path, 'w') as f:
        f.writelines(new_lines)
    print(f"Fixed {file_path}")
