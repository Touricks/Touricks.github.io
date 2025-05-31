---
layout: default
title: Longest-X-of-1s
narrow: true
---
https://app.laicode.io/app/problem/105?plan=3

Given a matrix that contains only 1s and 0s, find the largest X shape which contains only 1s, with the same arm lengths and the four arms joining at the central point.

Return the arm length of the largest X shape.

**Assumptions**

- The given matrix is not null, has size of N * M, N >= 0 and M >= 0.

**Examples**

{ {0, 0, 0, 0},

  {**1**, 1, **1**, 1},

  {0, **1**, 1, 1},

  {**1**, 0, **1**, 1} }

the largest X of 1s has arm length 2.
***
- 对四个方向做前缀和
```java
public int largest(int[][] matrix) {  
    if (matrix.length == 0 || matrix[0].length == 0) {  
        return 0;  
    }  
    int[][][] dp = new int[4][matrix.length][matrix[0].length];  
    // dp[0]: left-upper  
    // dp[1]: left-below    // dp[2]: right-upper    // dp[3]: right-below    int max = 0;  
    int row = matrix.length;  
    int col = matrix[0].length;  
    for(int i=0;i<row;i++){  
        for(int k=0;k<4;k++){  
            dp[k][i][0] = matrix[i][0];  
            dp[k][i][col-1] = matrix[i][col-1];  
        }  
    }  
    for(int j=0;j<col;j++){  
        for(int k=0;k<4;k++){  
            dp[k][0][j] = matrix[0][j];  
            dp[k][row-1][j] = matrix[row-1][j];  
        }  
    }  
    for(int i=1;i<row;i++){  
        for(int j=1;j<col;j++){  
            dp[0][i][j] = (matrix[i][j] == 1)? dp[0][i-1][j-1] + 1 : 0;  
        }  
    }  
    for(int i=1;i<row;i++){  
        for(int j=col-2;j>=0;j--){  
            dp[2][i][j] = (matrix[i][j] == 1)? dp[2][i-1][j+1] + 1 : 0;  
        }  
    }  
    for(int i=row-2;i>=0;i--){  
        for(int j=1;j<col;j++){  
            dp[1][i][j] = (matrix[i][j] == 1)? dp[1][i+1][j-1] + 1 : 0;  
        }  
    }  
    for(int i=row-2;i>=0;i--){  
        for(int j=col-2;j>=0;j--){  
            dp[3][i][j] = (matrix[i][j] == 1)? dp[3][i+1][j+1] + 1 : 0;  
        }  
    }  
    for(int i=0;i<row;i++){  
        for(int j=0;j<col;j++){  
            max = Math.max(max,Math.min(Math.min(dp[0][i][j], dp[1][i][j]),Math.min(dp[2][i][j],dp[3][i][j])));  
        }  
    }  
  
    return max;  
}
```