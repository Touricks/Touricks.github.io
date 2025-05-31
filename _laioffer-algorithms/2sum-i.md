---
layout: default
title: 2SUM-I
narrow: true
---
Determine if there exist two elements in a given array, the sum of which is the given target number.
**Assumptions**

- The given array is not null and has length of at least 2

​**Examples**

- A = {1, 2, 3, 4}, target = 5, return true (1 + 4 = 5)
    
- A = {2, 4, 2, 1}, target = 4, return true (2 + 2 = 4)
    
- A = {2, 4, 1}, target = 4, return false
***
- 使用HashSet
- 按Array从前到后遍历，对于每个元素，若之前有和它匹配的数(与他相加为target)，则返回true
- 否则把该元素放进Set
```java
public boolean existSum(int[] array, int target) {  
    HashSet<Integer> set = new HashSet<>();  
    for(int i=0;i<array.length;i++){  
        if (set.contains(target-array[i])){  
            return true;  
        }  
        set.add(array[i]);  
    }  
    return false;  
}
```