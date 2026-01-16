# Memory Protection
The MMU ensures that distinct processes (programs) run in isolation.

It prevents a malicious or buggy program from writing data into the memory space of another program or the operating system itself.

If a program tries to access memory it doesn't have permission for, the MMU raises a hardware exception (often called a "segmentation fault").
