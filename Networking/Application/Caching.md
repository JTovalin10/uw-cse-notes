# CSE461: DNS Caching

**DNS caching** reduces the latency of name resolution by storing query responses locally so future queries can be answered immediately.

## Key Points

- Resolution latency should be low, since DNS lookups add delay to every web request
- Clients and local nameservers cache query responses (including partial iterative answers) to answer future queries immediately
- Responses carry a **[[Time to Live (TTL)]]** field specifying how long the cached entry remains valid
- Once cached, previous resolutions skip most of the iterative lookup process

## Example

After resolving `eng.washington.edu`, a local nameserver caches the result. Subsequent queries for the same name are answered from cache until the TTL expires.

## Related
- [[Domain Name System (DNS)]] — full DNS overview
- [[Time to Live (TTL)]] — controls cache duration
- [[Local Nameservers]] — where caching primarily occurs
- [[Iterative vs Recursive Queries]] — resolution strategies that produce cached answers
- [[Web Caching]] — HTTP-level caching (contrast)
