---
layout: default
title: LargestSubarraySum
narrow: true
---
https://app.laicode.io/app/problem/489?plan=3

Given an unsorted integer array, find the subarray that has the greatest sum. Return the sum and the indices of the left and right boundaries of the subarray. If there are multiple solutions, return the leftmost subarray.

Assumptions

- The given array is not null and has length of at least 1.

Examples

- {2, -1, 4, -2, 1}, the largest subarray sum is 2 + (-1) + 4 = 5. The indices of the left and right boundaries are 0 and 2, respectively.
    
- {-2, -1, -3}, the largest subarray sum is -1. The indices of the left and right boundaries are both 1

***
State：dp[i]表示以数组第i位结尾的最大字段和
Base Case dp[0] = arr[0]
Induction Rule dp[i] = Math.max(arr[i],dp[i-1]+arr[i])
Result Max(dp[i])
- 由于要收集左右区间，我们需要维护六个值
	- currentMax, currentLeft, currentRight
	- globalMax，globalLeft, globalRight
	- 真的吗？

- 对于这道题，我们知道更新时右区间一定是index i，我们只需要保留当前方案的左区间就行了
- 此外，一个state = i的dp value只和 i-1有关，因此我们可以保留一个值curSum来代替dp数组
- 易错点：如果我们不设置dummy node（index=0无意义），那么globalMax就要等于数组的第一个值，不能等于MIN_VALUE，否则在数组只有一个值的时候，就会漏解
```java
public int[] largestSum(int[] array) {  
    int curSum = array[0];  
    int curLeft = 0;  
    int globalMax = array[0];  
    int globalleft = 0;  
    int globalright = 0;  
    for(int i=1;i<array.length;i++){  
        if (curSum < 0){  
            curSum = array[i];  
            curLeft = i;  
        }else{  
            curSum += array[i];  
        }  
  
        if (curSum > globalMax) {  
            globalleft = curLeft;  
            globalright = i;  
            globalMax = curSum;  
        }  
    }  
    return new int[]{globalMax,globalleft,globalright};  
}
```