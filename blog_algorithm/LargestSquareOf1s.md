---
layout: default
title: LargestSquareOf1s
narrow: true
---
https://app.laicode.io/app/problem/101?plan=3
Determine the largest square of 1s in a binary matrix (a binary matrix only contains 0 and 1), return the length of the largest square.

**Assumptions**

- The given matrix is not null and guaranteed to be of size N * N, N >= 0

**Examples**

{ {0, 0, 0, 0},

  {1, **1, 1,** 1},

  {0, **1, 1,** 1},

  {1, 0, 1, 1}}

the largest square of 1s has length of 2

***
若想让 **(i, j)** 成为某个更大正方形的右下角，需要满足：
1. _(i, j)_ 本身
2. _(i–1, j)_——上边
3. _(i, j–1)_——左边
4. _(i–1, j–1)_——左上角
- 四者都是1
- 并且如果构建长度大于2的正方形，三者中 **最短** 的那一条边决定了可以“撑”到多大；只要它们都 ≥ k，就能围出一个 `(k+1)×(k+1)` 的新方块。

State: `dp[i][j]`表示以 (i,j)为右下角能构建的最大正方形
Base Case: `dp[i][j] = arr[i][j]` (0/1)
Induction Rule: 
- `dp[i][j] = 1 + min( dp[i-1][j-1], dp[i-1][j], dp[i][j-1] )  if matrix[i][j] == 1
	-           = 0     otherwise
Result `MAX(dp[i][j])`

- Code
```java
public int largest(int[][] matrix) {  
    if (matrix.length == 0){  
        return 0;  
    }  
    int[][] dp = new int[matrix.length][matrix.length];  
    for(int i=0;i<matrix.length;i++){  
        for(int j=0;j<matrix.length;j++){  
            dp[i][j] = matrix[i][j];  
        }  
    }  
    int globalMax = 0;  
    for(int i=0;i<matrix.length;i++){  
        for(int j=0;j<matrix.length;j++){  
            if (i==0 || j==0){  
                globalMax = Math.max(globalMax,matrix[i][j]);  
                continue;  
            }  
            if (matrix[i][j] == 0){  
                continue;  
            }  
            dp[i][j] = Math.min(Math.min(dp[i-1][j],dp[i-1][j-1]),dp[i][j-1])+1;  
            if (globalMax < dp[i][j]){  
                globalMax = dp[i][j];  
            }  
        }  
    }  
    return globalMax;  
}
```