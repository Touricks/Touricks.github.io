---
layout: default
title: Array-Hopper-I
narrow: true
---
https://app.laicode.io/app/problem/88?plan=3

Given an array A of non-negative integers, you are initially positioned at index 0 of the array. **A[i] means the maximum jump distance from that position (you can only jump towards the end of the array).** Determine if you are able to reach the last index.

**Assumptions**

- The given array is not null and has length of at least 1.

**Examples**

- {1, 3, 2, 0, 3}, we are able to reach the end of array(jump to index 1 then reach the end of the array)    
- {2, 1, 1, 0, 2}, we are not able to reach the end of array
***
- State: dp[i]表示 以index i结尾，从第一格跳过来的最小步数
- base case：dp[0] = 0, otherwise MAX_INT
- induction rule: `dp[i] = Min(dp[i],dp[j]+1) if i-j<=arr[j]`  and dp[j] != MAX_INT
- result: dp[length-1]

- 易错点：不是当i-j<=arr[j]时就能让dp[i] = dp[j]+1的，因为dp[j]如果无法从起点抵达，大门dp[j]+1会修改标识”无法抵达“的值（MAX_INT），造成越界
- 因此 dp[j] != MAX_INT 这个条件千万不能省’

```java
public boolean canJump(int[] array) {  
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
        return false;  
    }else{  
        return true;  
    }  
}
```