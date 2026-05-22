# CSE 403: Mock-Based Testing

**Mock-based testing** is a technique to test a unit of code in isolation by replacing its real dependencies with controlled **mock objects** — also called **test doubles**, **fakes**, or **stubs** depending on their specific behavior.

This technique directly addresses the open question raised in [[CSE403/Testing/Testing and Continuous Integration]]: *is it possible and desirable to test units in isolation?* Mock-based testing answers yes — and shows how to do it in practice.

The live coding demo for this lecture is available at: `github.com/rjust/testing-mock`

## Why Mocking?

Consider a class that depends on an external resource — a database, a network API, a file system, or any component whose behavior in a test would be:

- **Slow**: a real database query takes far longer than an in-memory operation
- **Flaky**: a real network call can fail intermittently due to connectivity issues
- **Expensive or side-effecting**: a real API call might cost money, send real emails, or modify production data
- **Hard to control**: triggering a specific error condition (e.g., database unavailable, timeout) with a real system is difficult

**Example** — a `UserService` that depends on `UserRepository`:

```java
public class UserService {
    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

    public void registerUser(int id, String name) {
        User user = new User(id, name);
        repository.save(user);
    }

    public String getUserNameById(int id) {
        User user = repository.findById(id);
        return user != null ? user.getName() : null;
    }
}
```

In a unit test of `UserService`, you do not want to connect to a real database. You replace `UserRepository` with a mock that returns pre-configured fake responses, making the test fast, deterministic, and isolated.

## Types of Test Doubles

### Stub

A **stub** is a minimal implementation that returns hard-coded values for specific inputs. It does not record interactions or verify how it was called — it simply provides a canned response so that the unit under test can proceed.

Use stubs when you need the dependency to return a specific value to exercise a particular code path, but you do not care whether the method was actually called.

### Mock

A **mock** is a stub that **also records interactions** and can **verify them**. A mock asserts that certain methods were called — with certain arguments, a certain number of times, in a certain order. If the verification fails (the expected call was not made), the test fails.

Mocks test not just the return value of the unit under test but also the unit's *behavior* — what it does to its dependencies.

### Fake

A **fake** is a lightweight real implementation rather than a configured double. For example, an in-memory `HashMap`-based repository is a fake for a real SQL database. Fakes are more realistic than stubs — they actually implement the interface logic — but are simpler than the production implementation.

| Type | Returns values | Verifies calls | Real logic |
|------|---------------|---------------|-----------|
| Stub | Yes (hard-coded) | No | No |
| Mock | Yes (hard-coded) | Yes | No |
| Fake | Yes (computed) | No | Yes (simplified) |

## How Mocking Works in Practice (Mockito)

The course uses **Mockito** as the mocking framework for Java. The workflow has four steps.

### Step 1: Create the Mock

```java
UserRepository mockRepo = Mockito.mock(UserRepository.class);
```

Mockito generates a proxy object that implements the `UserRepository` interface. By default, all methods return null (or zero/false for primitives).

### Step 2: Stub Methods

Configure the mock to return specific values when called with specific arguments:

```java
when(mockRepo.findById(42)).thenReturn(new User(42, "Alice"));
```

Now `mockRepo.findById(42)` returns the fake `User` object. Any other argument returns null (the default).

### Step 3: Inject the Mock and Run the Test

Pass the mock to the unit under test in place of the real dependency:

```java
UserService service = new UserService(mockRepo);
String name = service.getUserNameById(42);
assertEquals("Alice", name);
```

The `UserService` calls `mockRepo.findById(42)`, which returns the stubbed `User`. The test asserts on the service's behavior without touching any real database.

### Step 4: Verify Interactions

After running the test, verify that the mock was called in the expected way:

```java
verify(mockRepo).findById(42);
// or: verify(mockRepo, times(1)).findById(42);
```

This assertion fails if `findById` was never called, or was called with a different argument. This is how you test that the service actually delegated to the repository — not just that it returned the right value.

## Code Coverage with Mocks: JaCoCo

The lecture also introduced **JaCoCo** (Java Code Coverage), a structural code coverage tool integrated with Gradle. When running `./gradlew build`, JaCoCo instruments the bytecode and produces a coverage report showing:

- **Line coverage**: which lines were executed during the test run
- **Branch coverage**: which branches (true/false arms of conditionals) were taken

```
UserService.java: 100% line coverage, 100% branch coverage
```

This report comes from `github.com/rjust/testing-mock` and shows that mock-based tests can achieve complete structural coverage of the service class, even with no real database involved. The branch on line 20 (`user != null ? user.getName() : null`) requires two test cases: one where `findById` returns a `User` and one where it returns `null`.

## Trade-offs of Mocking

### Advantages

- **Fast**: no I/O, no network, no database — tests run in microseconds.
- **Deterministic**: the mock always returns exactly what you configure, with no external variability.
- **Isolated**: failures point directly to the unit under test, not to a downstream dependency.
- **Controllable error conditions**: triggering a database timeout or a 503 response is trivial with a mock — simply configure `thenThrow(new RuntimeException("timeout"))`.

### Disadvantages

- **Mock accuracy**: if the mock does not accurately represent the real dependency's behavior (e.g., the real database throws on null IDs but the mock returns null silently), tests can pass while the real integration is broken.
- **Implementation coupling**: heavy use of mocks can make tests tightly coupled to implementation details — the exact sequence of method calls — rather than observable behavior. When the internal implementation changes (even if behavior stays the same), all the `verify(...)` calls may need updating.
- **Integration gaps**: mocks do not catch bugs that only appear when real components interact — mismatched API contracts, serialization issues, transaction semantics. Integration and system tests are still needed for that.

## Related

- [[CSE403/Testing/Testing Fundamentals]]
- [[CSE403/Testing/Testing and Continuous Integration]]
- [[CSE403/Testing/Coverage-Based Testing]]
- [[CSE403/Testing/Automated Testing and CI]]
- [[CSE403/Testing/UI Testing and WebDriver]]

## Industry Standard Terms

| Course Term | Industry Equivalent |
|-------------|---------------------|
| Mock object / test double | Mock, stub, spy, fake (Mockito, Moq, unittest.mock) |
| Stubbing | Method stubbing, test stubbing |
| Verify interactions | Behavior verification, interaction testing |
| JaCoCo | Code coverage tool (Istanbul, Coverage.py, JaCoCo, Jacoco) |
| Mock-based testing | Test isolation, dependency injection in tests |
