---
layout: default
title: Ksmallestwith357
narrow: true
---
Find the Kth smallest number s such that s = 3 ^ x * 5 ^ y * 7 ^ z, x > 0 and y > 0 and z > 0, x, y, z are all integers.

**Assumptions**

- K >= 1

**Examples**

- the smallest is 3 * 5 * 7 = 105
- the 2nd smallest is 3 ^ 2 * 5 * 7 = 315
- the 3rd smallest is 3 * 5 ^ 2 * 7 = 525
- the 5th smallest is 3 ^ 3 * 5 * 7 = 945
***
- DS：PriorityQueue筛选+HashSet去重
- Algorithm：topK
- 易错点：
	- 数值类型匹配 (int -> long)
	- Hard code题目中的常量

```java
public long kth(int k) {  
    PriorityQueue<Integer> pq = new PriorityQueue<>();  
    // 使用Long （long的包装类）代替Integer，防止溢出，下面同理
    HashSet<Integer> visited = new HashSet<>();  
    pq.add(105);  
    visited.add(105);  
    int count = 0;  
    int curNum = 0;  
    int[] coef = new int[]{3,5,7};  
    // 使用全局私有静态常量： 
    // private static final long[] FACTORS = new long[]{3, 5, 7};
    while(count<k){  
        curNum = pq.poll();  
        for(int i=0;i<3;i++){  
            if (!visited.contains(curNum*coef[i])){  
                visited.add(curNum*coef[i]);  
                pq.add(curNum*coef[i]);  
            }  
        }  
        count++;  
    }  
    return curNum;  
}
```