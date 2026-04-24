# Spatial Locality

**Spatial Locality** is the tendency for a program to access memory locations that are near recently accessed locations.

## Principle
When a program accesses a specific memory address, there is a high probability it will access nearby addresses in the near future. 

## In Cache Systems
Caching exploits spatial locality by loading an entire **cache block** (or cache line) into the cache whenever a single byte is requested. This way, subsequent accesses to neighboring data result in a cache hit.

## Examples
- **Arrays**: Accessing elements of an array sequentially (`A[0], A[1], A[2]...`) demonstrates perfect spatial locality.
- **Sequential Instruction Execution**: Computers typically execute instructions one after another in memory, which has high spatial locality.
- **Disk I/O**: Hard disks read data in blocks or sectors. Loading an entire block at once takes advantage of the fact that data needed soon is often stored next to the current data.

## Importance
Understanding spatial locality allows for several optimizations:
- **Stride-1 Access**: Iterating through multi-dimensional arrays in a way that matches their memory layout (e.g., row-major order in C).
- **Blocking**: Restructuring algorithms (like matrix multiplication) to operate on sub-blocks that fit into the cache.

## Related
- [[CSE351/Cache/Cache Locality|Cache Locality]]
- [[CSE351/Cache/Program Optimizations via Cache|Program Optimizations via Cache]]
- [[CSE344/Database Design/Disk Storage|Disk Storage (Database context)]]
