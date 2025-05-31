---
layout: default
title: 4SUM
narrow: true
---
Determine if there exists a set of four elements in a given array that sum to the given target number.

**Assumptions**

- The given array is not null and has length of at least 4

**Examples**
- A = {1, 2, 2, 3, 4}, target = 9, return true(1 + 2 + 2 + 4 = 9)
- A = {1, 2, 2, 3, 4}, target = 12, return false

***
对于一个目标值target，如果我们能找到一对数，使得`i1+j1 = target`,**且j1尽量小**，那么我便能O（1）判断是否有另外一对数`i2,j2`满足1）`i2>j1`;  2）`target+i2+j2==n`, 从而获得答案是否存在

Step1：对每一对数进行计算，构建一个HashMap，key为两个数的和，value为这两个数
- 我们需要特意维护循环顺序，使得每个key对应的value只有一对数，且这对数的j1在所有满足条件的数中是最小的
Step2: 对另外一对数`i2,j2`进行循环,若map中存在key为`target-arr[i2]-arr[j2]`的记录且map中的记录对应的`j1<i2`，则这两对数可以构成一组合法解，返回true。如果最终未能找到合法解，返回false
```java
class Pair{  
    int i;  
    int j;  
    public Pair(int i,int j){  
        this.i = i;  
        this.j = j;  
    }  
    @Override  
    public boolean equals(Object o){  
        if (o == this) return true;  
        if (o == null || o.getClass() != getClass()) return false;  
        Pair temp = (Pair) o;  
        return (temp.i == this.i && temp.j == this.j);  
    }  
    @Override  
    public int hashCode(){  
        return i*1001+j;  
    }  
      
}  
public boolean exist(int[] array, int target) {  
    HashMap<Integer, Pair> map = new HashMap<>();  
    for(int j1 = 1; j1<array.length-2;j1++){  
        for(int i1 = 0;i1 < j1; i1++){  
            if (!map.containsKey(array[i1] + array[j1])){  
                map.put(array[i1] + array[j1],new Pair(i1,j1));  
            }  
        }  
    }  
    for(int i2 = 2;i2<array.length-1;i2++){  
        for(int j2 = i2+1;j2<array.length;j2++){  
            if (map.containsKey(target-array[i2]-array[j2]) && (map.get(target-array[i2]-array[j2]).j < i2)){  
                return true;  
            }  
        }  
    }  
    return false;  
}
```