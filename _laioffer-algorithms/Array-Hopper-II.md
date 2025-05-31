---
layout: default
title: Array-Hopper-II
narrow: true
---
https://app.laicode.io/app/problem/89?plan=3

Given an array A of non-negative integers, you are initially positioned at index 0 of the array. **A[i] means the maximum jump distance from index i (you can only jump towards the end of the array).** Determine the minimum number of jumps you need to reach the end of array. If you can not reach the end of the array, return -1.

**Assumptions**

- The given array is not null and has length of at least 1.

**Examples**

- {3, 3, 1, 0, 4}, the minimum jumps needed is 2 (jump to index 1 then to the end of array)
    
- {2, 1, 1, 0, 2}, you are not able to reach the end of array, return -1 in this case.

***
```java
public int minJump(int[] array) {
	int[] dp = new int[array.length];
	for(int i=0;i<array.length;i++){
		dp[i] = Integer.MAX_VALUE;
	}
	dp[0] = 0;
	for(int i=1;i<array.length;i++){
		for(int j=0;j<i;j++){
			if (i-j<=array[j] && dp[j] != Integer.MAX_VALUE){
				dp[i] = Math.min(dp[i],dp[j]+1);
			}
		}
	}
	if (dp[array.length-1] == Integer.MAX_VALUE){
		return -1;
	}else{
		return dp[array.length-1];
	}
}
```