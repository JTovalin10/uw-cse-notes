## Example: Bounded Buffer
```c
monitor BoundedBuffer {
    item buffer[N];
    int count = 0;
    condition not_full, not_empty;

    void insert(item x) {
        while (count == N)
            wait(not_full);
        buffer[count++] = x;
        signal(not_empty);
    }

    item remove() {
        while (count == 0)
            wait(not_empty);
        item x = buffer[--count];
        signal(not_full);
        return x;
    }
}
```
