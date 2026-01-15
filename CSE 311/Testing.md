## **1. Exhaustive Testing (≤10 inputs)**

```java
// Function that only accepts values 1-5
public static String gradeLevel(int level) {
    switch (level) {
        case 1: return "Freshman";
        case 2: return "Sophomore";
        case 3: return "Junior";
        case 4: return "Senior";
        case 5: return "Super Senior";
        default: throw new IllegalArgumentException("Invalid level");
    }
}

// TESTS: Test all 5 valid inputs
@Test
public void testGradeLevel() {
    assertEquals("Freshman", gradeLevel(1));
    assertEquals("Sophomore", gradeLevel(2));
    assertEquals("Junior", gradeLevel(3));
    assertEquals("Senior", gradeLevel(4));
    assertEquals("Super Senior", gradeLevel(5));
    // Don't test 0, 6, etc. - those are disallowed inputs
}
```

---

## **2. Statement Coverage**

```java
public static int calculateDiscount(int age, boolean isMember) {
    int discount = 0;
    
    if (age < 18) {
        discount = 10;  // This statement must execute
    }
    
    if (isMember) {
        discount += 5;  // This statement must execute
    }
    
    return discount;
}

// TESTS: Cover all statements
@Test
public void testYoungNonMember() {
    assertEquals(10, calculateDiscount(15, false));  // Hits age < 18 line
}

@Test
public void testAdultMember() {
    assertEquals(5, calculateDiscount(25, true));  // Hits isMember line
}

@Test
public void testAdultNonMember() {
    assertEquals(0, calculateDiscount(25, false));  // Hits return with discount = 0
}
```

---

## **3. Branch Coverage**

```java
public static String checkTemperature(int temp) {
    if (temp > 30) {
        return "Hot";     // Branch A
    } else {
        return "Cold";    // Branch B
    }
}

// TESTS: Cover both branches
@Test
public void testHotTemperature() {
    assertEquals("Hot", checkTemperature(35));  // Branch A (temp > 30)
}

@Test
public void testColdTemperature() {
    assertEquals("Cold", checkTemperature(20));  // Branch B (temp <= 30)
}
```

---

## **4. Loop Coverage (0, 1, Many)**

```java
public static int sumArray(int[] numbers) {
    int sum = 0;
    for (int num : numbers) {
        sum += num;
    }
    return sum;
}

// TESTS: 0, 1, and many iterations
@Test
public void testEmptyArray() {
    assertEquals(0, sumArray(new int[]{}));  // 0 iterations
}

@Test
public void testSingleElement() {
    assertEquals(5, sumArray(new int[]{5}));  // 1 iteration
}

@Test
public void testMultipleElements() {
    assertEquals(15, sumArray(new int[]{3, 5, 7}));  // Many iterations (3)
}
```

---

## **5. Recursion Coverage (0, 1, Many recursive calls)**

```java
public static int factorial(int n) {
    if (n <= 1) {
        return 1;  // Base case: 0 recursive calls
    }
    return n * factorial(n - 1);  // Recursive case
}

// TESTS: 0, 1, and many recursive calls
@Test
public void testFactorialBase() {
    assertEquals(1, factorial(0));  // 0 recursive calls
    assertEquals(1, factorial(1));  // 0 recursive calls
}

@Test
public void testFactorialOneRecursion() {
    assertEquals(2, factorial(2));  // 1 recursive call (2 * factorial(1))
}

@Test
public void testFactorialManyRecursions() {
    assertEquals(120, factorial(5));  // Many recursive calls (4 calls)
}
```

---

## **6. Boundary Testing**

```java
public static String ageCategory(int age) {
    if (age < 18) {
        return "Minor";
    } else if (age <= 65) {
        return "Adult";
    } else {
        return "Senior";
    }
}

// TESTS: Test boundaries at 18 and 65
@Test
public void testBoundaryAt18() {
    assertEquals("Minor", ageCategory(17));   // Just below boundary
    assertEquals("Adult", ageCategory(18));   // At boundary
}

@Test
public void testBoundaryAt65() {
    assertEquals("Adult", ageCategory(65));   // At boundary
    assertEquals("Senior", ageCategory(66));  // Just above boundary
}
```

---

## **7. Logical Operator Coverage (|| and &&)**

```java
public static boolean canVote(int age, boolean isCitizen) {
    return age >= 18 && isCitizen;  // Both conditions must be true
}

// TESTS: Test all combinations
@Test
public void testOldEnoughButNotCitizen() {
    assertFalse(canVote(20, false));  // age >= 18 is TRUE, isCitizen is FALSE
}

@Test
public void testCitizenButTooYoung() {
    assertFalse(canVote(16, true));  // age >= 18 is FALSE, isCitizen is TRUE
}

@Test
public void testCanVote() {
    assertTrue(canVote(20, true));  // Both TRUE
}

@Test
public void testCannotVote() {
    assertFalse(canVote(16, false));  // Both FALSE
}
```

```java
public static boolean needsUmbrella(boolean isRaining, boolean isCloudy) {
    return isRaining || isCloudy;  // At least one must be true
}

// TESTS: Test all combinations
@Test
public void testRainingButNotCloudy() {
    assertTrue(needsUmbrella(true, false));  // isRaining TRUE, isCloudy FALSE
}

@Test
public void testCloudyButNotRaining() {
    assertTrue(needsUmbrella(false, true));  // isRaining FALSE, isCloudy TRUE
}

@Test
public void testBothTrue() {
    assertTrue(needsUmbrella(true, true));  // Both TRUE
}

@Test
public void testNeitherTrue() {
    assertFalse(needsUmbrella(false, false));  // Both FALSE
}
```

---

## **8. Special Values Testing**

```java
public static int getLength(String str) {
    if (str == null) {
        return 0;
    }
    return str.length();
}

// TESTS: Test special values
@Test
public void testNullString() {
    assertEquals(0, getLength(null));  // null
}

@Test
public void testEmptyString() {
    assertEquals(0, getLength(""));  // empty string
}

@Test
public void testNormalString() {
    assertEquals(5, getLength("Hello"));  // normal case
}
```

---

## **Complete Example: All Concepts Together**

```java
public static List<Integer> filterPositive(List<Integer> numbers) {
    if (numbers == null) {
        return new ArrayList<>();
    }
    
    List<Integer> result = new ArrayList<>();
    for (Integer num : numbers) {
        if (num != null && num > 0) {
            result.add(num);
        }
    }
    return result;
}

// COMPREHENSIVE TESTS
@Test
public void testNullList() {
    assertEquals(new ArrayList<>(), filterPositive(null));  // Special value: null
}

@Test
public void testEmptyList() {
    assertEquals(new ArrayList<>(), filterPositive(new ArrayList<>()));  // Loop: 0 iterations
}

@Test
public void testSinglePositive() {
    assertEquals(Arrays.asList(5), filterPositive(Arrays.asList(5)));  // Loop: 1 iteration
}

@Test
public void testManyPositives() {
    assertEquals(Arrays.asList(1, 2, 3), 
                 filterPositive(Arrays.asList(1, 2, 3)));  // Loop: many iterations
}

@Test
public void testMixedValues() {
    assertEquals(Arrays.asList(5, 10), 
                 filterPositive(Arrays.asList(-3, 5, 0, 10, -1)));  // Branch coverage
}

@Test
public void testWithNullElement() {
    assertEquals(Arrays.asList(5), 
                 filterPositive(Arrays.asList(null, 5, null)));  // Special value: null element
}

@Test
public void testBoundaryAtZero() {
    assertEquals(new ArrayList<>(), 
                 filterPositive(Arrays.asList(0)));  // Boundary: 0 is not > 0
    assertEquals(Arrays.asList(1), 
                 filterPositive(Arrays.asList(1)));  // Boundary: 1 is > 0
}
```

This comprehensive example shows how to apply multiple testing principles to a single function!

***
