---
layout: default
title: CutWood
narrow: true
---
https://app.laicode.io/app/problem/137?plan=3

There is a wooden stick with length L >= 1, we need to cut it into pieces, where the cutting positions are defined in an int array A. The positions are guaranteed to be in ascending order in the range of [1, L - 1]. The cost of each cut is the length of the stick segment being cut. Determine the minimum total cost to cut the stick into the defined pieces.

**Examples**

- L = 10, A = {2, 4, 7}, the minimum total cost is 10 + 4 + 6 = 20 (cut at 4 first then cut at 2 and cut at 7)

***
- 切木头，石子合并类型题目，state定义为切点
```
木头：0 1 2 3 4 5 6 7 8 9 10
     |_ _|_ _|_ _ _|_ _ _ |
index 0 1 2 3 4
切点   0 2 4 7 10

State: dp[i][j] 表示从切点i到切点j，把之间的木头全部切开的最小代价
Base Case: dp[i][i+1] = 0, 没有切点的木头不需要切， dp[i][i] 无意义，仅出现于corner case
Induction Rule: dp[i][j] = MIN(dp[i][k]+dp[k][j])+(a[j]-a[i])
Result:dp[0][len-1]
```

- 对于区间DP，改进方法包括：
	- 为每个循环变量名起一个好名字
	- Base Case赋值部分不要夹在主循环中
```java
public int minCost(int[] cuts, int length) {  
    int[] cutPoint = new int[cuts.length+2];  
    if (length<=1 || cuts.length == 0){  
        return 0;  
    }  
    cutPoint[0] = 0;  
    cutPoint[cuts.length+1] = length;  
    for(int i=1;i<cuts.length+1;i++){  
        cutPoint[i] = cuts[i-1];  
    }  
    int len = cutPoint.length;  
    int[][] dp = new int[len][len];  
    for(int i=0;i<len;i++){  
        for(int j=i;j<len;j++){  
            dp[i][j] = Integer.MAX_VALUE;  
        }  
    }  
    for(int interval = 1; interval<len; interval++){  
        for(int i=0;i<len-interval;i++){  
            if (interval == 1){  
                dp[i][i+1] = 0;  
                continue;  
            }  
            for(int k = i+1;k<i+interval;k++){  
                int j = i+interval;  
                dp[i][j] = Math.min(dp[i][j],dp[i][k]+dp[k][j]+cutPoint[j]-cutPoint[i]);  
            }  
        }  
    }  
    return dp[0][len-1];  
}
```