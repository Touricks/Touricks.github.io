---
layout: default
title: 3SUM
narrow: true
---
Determine if there exists three elements in a given array that sum to the given target number. Return all the triple of values that sums to target.

**Assumptions**

- The given array is not null and has length of at least 3
- No duplicate triples should be returned, order of the values in the tuple does not matter

**Examples**

- A = {1, 2, 2, 3, 2, 4}, target = 8, return$[[1, 3, 4], [2, 2, 4]]$
***
- 首先，我们将数进行排序
- 使用2SUM+从小到大枚举第一位数的方式解决
	- 对于第一位数，我们使用重复就跳过的原则，防止重复
	- 对于第2，第3位数，我们使用2SUM用到的hashmap方法，对一般情况和两数之和等于目标的特殊情况分开处理
	- 2SUM方法返回等于目标值的pair，我们将其和第一位数进行合并，在外层循环收集解
***
```java
public List<List<Integer>> allTriples(int[] array, int target) {  
    List<List<Integer>> result = new ArrayList<>();  
    HashSet<Integer> dedup = new HashSet<>();  
    Arrays.sort(array);  
    for(int i=0;i<array.length-2;i++){  
        if (!dedup.contains(array[i])){  
            List<List<Integer>> res = allPairs(array,i+1,target-array[i]);  
            for(List<Integer> s : res){  
                result.add(Arrays.asList(array[i],s.get(0),s.get(1)));  
            }  
        }  
        dedup.add(array[i]);  
    }  
    return result;  
}  
  
private List<List<Integer>> allPairs(int[] array, int start, int target) {  
    HashMap<Integer, Integer> map = new HashMap<>();  
    List<List<Integer>> res = new ArrayList<>();  
    for(int i=start;i<array.length;i++){  
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