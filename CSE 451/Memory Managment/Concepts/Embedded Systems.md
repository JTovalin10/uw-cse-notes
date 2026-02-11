they only run one program at a time
First, there was one job-at-a-time batch programming
- programs used physical addresses directly
- OS loads job (perhaps using a relocating loader to “offset” branch addresses), runs it, unloads it
- what if the program wouldn’t fit into memory? • manual overlays!