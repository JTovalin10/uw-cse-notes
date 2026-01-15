like the [[Global Descriptor Table]] but a per-process/thread instead of global

# what it was designed for
- Let each process have its own custom segments
- Useful in old segmented memory models where processes wanted isolated memory regions
- Could define process-specific code/data segments

## Modern reality
- **Rarely used** in modern OSes
- Linux doesn't use LDT by default
- Flat memory model makes it unnecessary
- Most systems just use GDT for everything