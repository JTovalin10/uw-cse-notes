# CSE461: Web Caching

**Web caching** allows clients and intermediate servers to serve HTTP responses from a local copy rather than fetching from the origin server, reducing latency and bandwidth usage.

## Determining Validity

A cache must decide whether its stored copy is still valid before using it:

### Local Freshness Check (No Network Request)
- Based on **expiry information** from the server, such as the `Expires` header or `Cache-Control: max-age`
- Or use a heuristic (e.g., the resource is cacheable, freshly valid, and has not been modified recently)
- If still fresh, the content is available immediately (0 RTTs)

### Revalidation (One Round Trip)
- Based on the **timestamp** of the stored copy, such as the `Last-Modified` header → sent as `If-Modified-Since`
- Or based on the **content hash** of the stored copy, such as the `ETag` header → sent as `If-None-Match`
- If the server confirms the copy is still current, it responds with **`304 Not Modified`** (no body), and the content is available after 1 RTT

## Related
- [[HTTP - Protocol Mechanics and Evolution]] — HTTP caching mechanics (`Cache-Control`, `ETag`, `304`)
- [[World Wide Web - HTTP Evolution and Caching]] — advanced cache-control directives and the `Vary` header
- [[Web Proxies]] — shared caching via proxy servers
- [[Content Distribution Networks (CDN)]] — large-scale caching infrastructure
- [[Caching]] — DNS-level caching (contrast)
