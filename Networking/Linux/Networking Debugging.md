# Linux: Networking Debugging

## 1. Essential Tools
- **ss**: Socket statistics.
  - `ss -ntlp`: List all listening TCP sockets with PIDs.
  - `ss -i`: Show detailed TCP internals (CWND, RTT, retransmits).
- **tcpdump**: Packet capture.
  - `tcpdump -ni eth0 'tcp port 443'`: Capture HTTPS traffic.
- **mtr**: Combines Ping and Traceroute. Helps identify packet loss at specific hops.
- **ip route / ip addr**: Modern replacements for `route` and `ifconfig`.

## 2. Advanced Observation
- **bpftrace**: Trace kernel functions.
  - `bpftrace -e 'kprobe:tcp_v4_do_rcv { @[comm] = count(); }'`: See which processes are receiving TCP packets.
- **strace**: See system calls.
  - `strace -e network -p <pid>`: Trace all network-related syscalls for a process.
- **Flame Graphs**: Use `perf` to capture stack traces and visualize "hot" code paths in the networking stack.

## 3. Troubleshooting Logic
1. **Connectivity**: Can I ping the host? (L3)
2. **Ports**: Is the port open? (`nc -zv <host> <port>`) (L4)
3. **TLS**: Is the certificate valid? (`openssl s_client -connect <host>:443`)
4. **Application**: Is the server returning a 5xx error? (L7)
5. **Kernel**: Is the server dropping packets due to full queues? (`netstat -s | grep dropped`)

### Related
- [[Advanced Linux Networking]]
- [[Socket Errors]]
