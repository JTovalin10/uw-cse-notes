# RAID (Redundant Array of Independent Disks)

RAID is a technology that combines multiple physical disk drive components into one or more logical units for the purposes of data redundancy, performance improvement, or both.

## RAID Levels

| Level | Name | Description | Redundancy |
| :--- | :--- | :--- | :--- |
| **RAID 0** | **Striping** | Data is split across disks. | **None**. One disk failure loses all data. |
| **RAID 1** | **Mirroring** | Data is duplicated on two disks. | **High**. Can survive one disk failure. |
| **RAID 4** | **Dedicated Parity** | Blocks are striped; one disk is dedicated to parity. | **Medium**. Can survive one disk failure. |
| **RAID 5** | **Distributed Parity** | Parity is rotated across all disks. | **Medium**. Can survive one disk failure. |
| **RAID 10** | **Stripe of Mirrors** | Combines RAID 1 and RAID 0. | **High**. Can survive multiple failures if they are in different mirrors. |

## RAID 4 vs RAID 5: The Parity Bottleneck

### RAID 4
In RAID 4, every write to any data disk requires updating the single **dedicated parity disk**.
- **The Problem**: The parity disk becomes a throughput bottleneck because it must be accessed for every single write operation in the array.
- **Performance**: Sequential reads are fast, but random writes are limited by the speed of the parity disk.

### RAID 5
RAID 5 solves the bottleneck by using **Distributed Parity**. The parity blocks are spread across all disks in the array.
- **The Benefit**: This allows multiple writes to occur in parallel if they happen to use different disks for their parity blocks.
- **Performance**: Better write throughput than RAID 4.

## RAID 5 Parity Math

### Calculation
Parity ($P$) is calculated using the **XOR** operation:
$P = D_1 \oplus D_2 \oplus D_3$

### Recovery
If a disk (e.g., $D_2$) fails, its data can be reconstructed by XORing the remaining data blocks and the parity block:
$D_2 = D_1 \oplus D_3 \oplus P$

## Comparison Summary
- **RAID 0**: Best performance, no safety.
- **RAID 1**: Highest safety, 50% storage overhead.
- **RAID 5**: Best balance of safety and efficiency; requires at least 3 disks.
- **RAID 10**: High performance and high safety; very expensive (requires 4+ disks, 50% overhead).
