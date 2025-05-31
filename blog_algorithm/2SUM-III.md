---
layout: default
title: 2SUM-III
narrow: true
---
Find all pairs of elements in a given array that sum to the pair the given target number. Return all the **distinct** pairs of values.

**Assumptions**

- The given array is not null and has length of at least 2
- The order of the values in the pair does not matter

**Examples**
- A = {2, 1, 3, 2, 4, 3, 4, 2}, target = 6, return$[[2, 4], [3, 3]]$
***
- 使用HashMap存目前一个数已经出现了几次
- 对于一个数x，如果`target-x=x`，那么第二次出现时我们可以将$[x,x]$这一对数加入解集
- 然而对于一个数x,如果`target-x!=x`，那么我们仅当遍历到x时x是第一次出现时将这对数加入解
	- 假设有一个数y出现在x前面，`target-y=x`，当遍历到y时，`[x,y]`已经会加入解集，所以遍历到x时不能再加
	- 假设有一个数y出现在x后面，`target-y=x`，当遍历到y时，`[x,y]`就会加入解集，因此在当前位置不需要提前进行操作
```java
public List<List<Integer>> allPairs(int[] array, int target) {  
    HashMap<Integer, Integer> map = new HashMap<>();  
    List<List<Integer>> res = new ArrayList<>();  
    for(int i=0;i<array.length;i++){  
        if (map.containsKey(target-array[i])){  
            if (array[i]*2==target && map.get(array[i]) == 1){  
                res.add(new ArrayList<>(Arrays.asList(array[i],array[i])));  
            }  
            if (array[i]*2 != target && !map.containsKey(array[i])){  
                res.add(new ArrayList<>(Arrays.asList(target-array[i],array[i])));  
            }  
        }  
        if (!map.containsKey(array[i])){  
            map.put(array[i],0);  
        }  
        map.put(array[i],map.get(array[i])+1);  
    }  
    return res;  
}
```