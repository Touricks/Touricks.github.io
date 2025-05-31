---
layout: default
title: LargestSubmatrixSum
narrow: true
---
Given a matrix that contains integers, find the submatrix with the largest sum.

Return the sum of the submatrix.

**Assumptions**

- The given matrix is not null and has size of M * N, where M >= 1 and N >= 1

**Examples**

{ {1, -2, **-1, 4**},

  {1, -1,  **1, 1**},

  {0, -1, **-1, 1**},

  {0,  0,  **1, 1**} }

the largest submatrix sum is (-1) + 4 + 1 + 1 + (-1) + 1 + 1 + 1 = 7.
***
- Suppose `dp[i][j] = ending at i,j, the largest submatrix sum`
- Base case: `dp[i][j] = arr[i][j]`. At least equal to itself.
- Induction Rule:
 `Suppose we maintain a array called prefixSum[row][j] indicated the prefix sum of column j to the specific row, then the sum of column j from row=r1 to row=r2 is r[r1,r2] = prefixSum[r2]-prefixSum[r1-1]`,
 `Thus, we can simplify the question from finding the max submatrix started from r1 to r2, to finding the max subArray based on prefixSum array`
 `Then, dp[j] = Max(dp[j-1],0)+ s[j], where s[j] is Max(r1,j) where r1<j`
- Result: `we need to collect the maximum value from dp[j]`
***

Step1:按列prefixSum
Step2:遍历上下行压缩成`s[i]`, 
Step3: 根据`s[i]`做largestArraySum: 
- Suppose `dp[j] = ending at j, the largest subarray sum`
- Base case: `dp[0] = arr[0]`. At least equal to itself.
- Induction Rule: `dp[]`
```java
 public int largest(int[][] matrix) {  
    int row= matrix.length;  
    int col = matrix[0].length;  
    int[][] prefixSum = new int[row+1][col];  
    for(int i=0;i<row;i++){  
        for(int j=0;j<col;j++){  
            prefixSum[i+1][j] = prefixSum[i][j] + matrix[i][j];  
        }  
    }  
    int globalMax = Integer.MIN_VALUE;  
    int[] s = new int[col];  
    int[] dp = new int[col];  
    for(int r1=0;r1<row;r1++){  
        for(int r2 = r1; r2 < row; r2++){  
            for(int j=0;j<col;j++){  
                s[j] = prefixSum[r2+1][j] - prefixSum[r1][j];  
            }  
            for(int j=0;j<col;j++){  
                if (j==0){  
                    dp[j] = s[j];  
                }else{  
                    dp[j] =(dp[j-1]>0)? dp[j-1]+s[j] : s[j];  
                }  
            }  
            for(int j=0;j<col;j++){  
                globalMax = Math.max(globalMax,dp[j]);  
            }  
        }  
    }  
    return globalMax;  
}
```