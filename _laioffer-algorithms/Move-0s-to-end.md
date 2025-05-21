---
layout: default
title: Move 0s to end
narrow: true
---

https://app.laicode.io/app/problem/259
Given an array of integers, move all the 0s to the right end of the array.

The relative order of the elements in the original array **need to be maintained**.

**Assumptions:**

- The given array is not null.

**Examples:**

- {1} --> {1}
- {1, 0, 3, 0, 1} --> {1, 3, 1, 0, 0}

---

```java
  public int[] moveZero(int[] array) {
    int slow = 0;
    int fast = 0;
    while(fast < array.length){
      if (array[fast] == 0){
        fast++;
      }else{
        array[slow] = array[fast];
        slow++;
        fast++;
      }
    }
    for(int i=slow;i<array.length;i++){
      array[i] = 0;
    }
    return array;
  }
```
