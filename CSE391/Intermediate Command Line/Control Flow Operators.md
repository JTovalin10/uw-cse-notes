# CSE391: Control Flow Operators

Control flow operators allow you to chain multiple commands together on a single line and control their execution based on the success or failure of previous commands.

## Semicolon (`;`)
The `;` operator runs commands sequentially, regardless of whether the previous command succeeded or failed.
- Example: `command1 ; command2` (runs `command1`, then runs `command2`).

## AND Operator (`&&`)
The `&&` operator runs the second command only if the first command **succeeded** (returned an exit status of 0).
- Example: `wget http://example.com/file.zip && unzip file.zip` (only unzips if the download was successful).

## OR Operator (`||`)
The `||` operator runs the second command only if the first command **failed** (returned a non-zero exit status).
- Example: `grep "pattern" file || echo "Pattern not found"` (prints message only if grep finds nothing).

## Related/See-also
- [[Streams Redirection and Pipes/Pipes|Pipes]]
- [[Intermediate Command Line/Xargs|Xargs]]
