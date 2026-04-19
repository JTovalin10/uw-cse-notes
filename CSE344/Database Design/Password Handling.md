# CSE344: Password Handling

## Plaintext Storage

Never store passwords in plaintext — if the database is leaked, attackers have the passwords directly.

## Storing Hashes

Instead of plaintext, store a **hash** of the password.
- A user can prove they have the correct password if the stored hash equals the hash of what they just typed
- This works because a hash is deterministic: $H(x) \rightarrow R(x)$

### Salting

**Salting** adds a small amount of randomness to user passwords before hashing:
- Makes identical passwords produce non-identical hashes
- Makes it harder for attackers to find commonly-used passwords
- The salt can be stored in the database — attackers still need to brute-force the password

Salting also makes it harder to find:
- Pairs of users who share passwords within a stolen dataset
- Users who share passwords across multiple stolen datasets

**How to use:** when a user attempts to log in, hash their input with the saved salt and compare against the saved salted hash.

Salting is not intended to protect an individual password — it protects the entire set of passwords.

## Prepared Statements

If you allow users to insert raw input into SQL, this causes **SQL injection**, which can allow a malicious user to access arbitrary data from the database. To prevent this, use **Prepared Statements**:

```java
private static final String FLIGHT_CAPACITY_SQL = "SELECT capacity FROM Flights WHERE fid = ?";
private PreparedStatement flightCapacityStmt;
```

## Related
- [[Database Applications]] — context for where password handling applies
- [[Multi-tier Architecture]] — credentials travel between tiers and must be protected in transit
- [[CSE484/Cryptography/Hashing + Ciphertext Integrity|CSE484 Hashing + Ciphertext Integrity]] — deeper treatment of hash functions, preimage/collision resistance, and HMAC
- [[CSE484/Cryptography/Cryptography|CSE484 Cryptography]] — cryptographic primitives used in authentication systems
- [[CSE484/Security Fundamentals/Other types of attacks|CSE484 Other types of attacks]] — SQL injection and other input-validation attacks
