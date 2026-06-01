# CSE461: Web Proxies

A **web proxy** is an intermediary placed between a pool of clients and external web servers. It acts as both a client (to the server) and a server (to the client).

## Benefits

- **Caching** — clients benefit from a larger, shared cache. One client's fetch populates the cache for all subsequent clients on the same network
- **Security checking** — the proxy can inspect or filter traffic
- **Organizational access policies** — enforce rules about which resources clients may access

## Proxy Caching Limitations

- Benefits are limited by **secure/dynamic content** — HTTPS content cannot be cached by a transparent proxy; dynamically generated responses are often not cacheable
- **Long-tail problem** — the majority of web content is accessed only rarely (the "long tail"), so much content in the cache is never reused

## Related
- [[Web Caching]] — the mechanics of cache validation
- [[World Wide Web - HTTP Evolution and Caching]] — forward, reverse, and transparent proxy architectures
- [[Content Distribution Networks (CDN)]] — large-scale proxy-like infrastructure
- [[Page Load Time (PLT)]] — proxies can reduce PLT via caching
