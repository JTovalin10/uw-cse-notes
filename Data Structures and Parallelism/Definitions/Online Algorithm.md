# Online Algorithm

An **Online Algorithm** is one that can process its input piece by piece in a serial fashion, i.e., in the order that the input is fed to the algorithm, without having the entire input available from the start.

In the context of **Sorting**, an online sort can maintain a sorted list as new elements are added one at a time (e.g., [[Insertion Sort|Insertion Sort]] is an online algorithm).

### Formal Definition
An algorithm is online if it makes a sequence of decisions $d_1, d_2, \dots, d_n$ based on input $x_1, x_2, \dots, x_n$ such that each $d_i$ depends only on $x_1, \dots, x_i$.
