---
layout: default
title: 2SUM-II
narrow: true
---
```
Find all pairs of elements in a given array that sum to the given target number. Return all the pairs of indices.

Assumptions
- The given array is not null and has length of at least 2.
    
Examples
- A = {1, 3, 2, 4}, target = 5, return [[0, 3], [1, 2]]
- A = {1, 2, 2, 4}, target = 6, return [[1, 3], [2, 3]]
```
***
- 使用HashMap存到目前为止每个值对应的数组位置
- 对一个在位置$i$的数字$a_i$，他可以与值为`target-i`的所有数字组成一对
- 我们先找出所有可能的数值对，然后把当前数存进map中，用于后续搜索
- 可以保证不重复，不遗漏
```java
public List<List<Integer>> allPairs(int[] array, int target) {  
    HashMap<Integer, List<Integer>> map = new HashMap<>();  
    List<List<Integer>> res = new ArrayList<>();  
    for(int i=0;i<array.length;i++){  
        if (map.containsKey(target-array[i])){  
            List<Integer> value = map.get(target-array[i]);  
            for(Integer x : value){  
                res.add(new ArrayList<>(Arrays.asList(x,i)));  
            }  
        }  
        if (!map.containsKey(array[i])){  
            List<Integer> tmp = new ArrayList<>();  
            map.put(array[i],tmp);  
        }  
        List<Integer> cur = map.get(array[i]);  
        cur.add(i);  
    }  
    return res;  
}
```