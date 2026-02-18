a CPU exception that occurs when code violates protection rules
# Common Causes
- privilege violation: ring 3 code tries to execute a ring 0 instruction [[Privilege Level]]
- segment violation: access outside segment limits
- null pointer dereference: accessing address 0 (or low memory)
- invalid memory access: writing to read only memory, executing non-executable pages
