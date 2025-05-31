---
layout: default
title: MaximumValueOfSizeKSlidingWindow
narrow: true
---
https://app.laicode.io/app/problem/204?plan=3

Given an integer array A and a sliding window of size K, find the maximum value of each window as it slides from left to right.

**Assumptions**

- The given array is not null and is not empty
    
- K >= 1, K <= A.length
    

**Examples**

A = {1, 2, 3, 2, 4, 2, 1}, K = 3, the windows are {{1,2,3}, {2,3,2}, {3,2,4}, {2,4,2}, {4,2,1}},

and the maximum values of each K-sized sliding window are [3, 3, 4, 4, 4]

***
- Method1: 单调栈
- Step1栈的单调性：我们选择单调递减的Deque，因为在每轮元素入栈时，需要的信息是在给定范围内最大的数，取Deque的头即是答案。栈中永远存索引
- Step2入栈前的更新：从栈顶到栈底去除栈中所有比当前元素小的数，因为他们不可能成为答案。然后，如果栈底元素（最大元素）越界，则删除
- Step3：入栈后计算当前元素对答案的贡献：取栈底元素即为当前窗口的最大值
- Step4：栈中剩余元素：由于我们在入栈时计算了所有可能的答案，直接忽略即可
- 易错点：**再次强调，不要把数组的值放进单调栈内**
```java
public List<Integer> maxWindows(int[] array, int k) {  
    Deque<Integer> deque = new LinkedList<>();  
    List<Integer> res = new ArrayList<>();  
    for(int i=0;i<array.length;i++){  
        int cur = array[i];  
        if (!deque.isEmpty() && i-deque.peekFirst() >= k){  
            deque.pollFirst();  
        }  
        if (deque.isEmpty() || array[deque.peekLast()] > cur){  
            deque.addLast(i);  
        }else{  
            while(!deque.isEmpty() && array[deque.peekLast()] <= cur){  
                deque.pollLast();  
            }  
            deque.addLast(i);  
        }  
        if (i >= k-1) res.add(array[deque.peekFirst()]);  
    }  
    return res;  
}
```
---
- Method2：前缀/后缀数组
- 我们将数组划分为`(len-1)/k+1`块
- 令`prefixMax[i]`表示当前块上的前缀最大值，`suffixMax[i]`表示当前块上的后缀最大值
- 对于一个区间`[L,R]`,`prefixMax[R]+suffixMax[L]`即为结果
```java
public List<Integer> maxWindows(int[] array, int k) {  
    int len = array.length;  
    int[] prefixMax = new int[array.length];  
    int[] suffixMax = new int[array.length];  
    for(int i=0;i<len;i++){  
        if (i%k==0){  
            prefixMax[i] = array[i];  
        }else{  
            prefixMax[i] = Math.max(prefixMax[i-1],array[i]);  
        }  
    }  
    for(int i=len-1;i>=0;i--){  
        if (i%k == k-1 || i == len-1){  
            suffixMax[i] = array[i];  
        }else{  
            suffixMax[i] = Math.max(suffixMax[i+1],array[i]);  
        }  
    }  
    List<Integer> res = new ArrayList<>();  
    for(int i=0;i<len-k+1;i++){  
        int s = i;  
        int t = i+k-1;  
        res.add(Math.max(prefixMax[t],suffixMax[s]));  
    }  
    return res;  
}
```