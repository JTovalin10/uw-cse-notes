# CSE451: SSD

A **Solid State Drive (SSD)** uses electronic circuits (NAND flash) to store data, rather than moving mechanical parts. See [[Flash Storage]] for the full mechanics of pages, blocks, the Flash Translation Layer, and wear leveling.

## Performance

Erasing blocks on an SSD involves erasing an entire block at once, since flash memory's write mechanism can only push a cell's charge in one direction, so returning it to the erased state requires resetting the whole block rather than just the individual page being rewritten.

- Performance is improved if the SSD has a stockpile of clean, ready-to-use blocks, since a write to a clean page can happen immediately, whereas a write to a stale page requires first relocating any still-valid data in that block and erasing it, a much slower path.
- The SSD can occasionally garbage collect (via **[[Defragmentation and TRIM operations|TRIM]]**) blocks that are no longer in use by the file system, making them ready to use again ahead of time rather than waiting until write pressure forces an on-demand erase.
- **Defragmenting an SSD will only shorten its life** — since there is no seek time to save, defragmentation provides no performance benefit, and it consumes program/erase cycles that count against the drive's limited write endurance.

## Related
- [[Flash Storage]] — full mechanics detail
- [[Disk Drives]] — HDD vs SSD comparison
- [[Secondary Storage]] — broader storage device context
- [[HDD]] — the mechanical counterpart, useful for contrast
- [[Defragmentation and TRIM operations]] — full detail on the TRIM command

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| SSD | Solid state drive / flash storage / NAND storage |

