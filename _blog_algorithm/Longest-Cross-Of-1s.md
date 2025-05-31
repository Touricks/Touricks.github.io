---
layout: default
title: Longest-Cross-Of-1s
narrow: true
---
https://app.laicode.io/app/problem/104?plan=3

Given a matrix that contains only 1s and 0s, find the largest cross which contains only 1s, with the same arm lengths and the four arms joining at the central point.

Return the arm length of the largest cross.

**Assumptions**

- The given matrix is not null, has size of N * M, N >= 0 and M >= 0.

**Examples**

{ {0, 0, 0, 0},

  {1, 1, **1**, 1},

  {0, **1, 1, 1**},

  {1, 0, **1**, 1} }

the largest cross of 1s has arm length 2.
***
辅助数组：`prefixSum[4][i][j]`表示分别从上，下，左，右侧对应行对应列到位置`(i,j)`的最长连续1的长度
```
prefixSum[0][i][j] = prefixSum[0][i-1][j]+1 if (i,j) = 1
prefixSum[0][0][j] = arr[0][j]
prefixSum[2][i][j] = prefixSum[2][i][j-1]+1 if (i,j) = 1
prefixSum[2][i][0] = arr[i][0]
其他类似
```
然后我们可以O(1)得到各个点的最大值，总TC O(N2)
```java
public int largest(int[][] matrix) {  
    // Write your solution here  
    if (matrix.length == 0 || matrix[0].length == 0){  
        return 0;  
    }  
    int row = matrix.length;  
    int col = matrix[0].length;  
    int[][][] prefixSum = new int[4][row][col];  
    for(int i=0;i<row;i++){  
        prefixSum[2][i][0] = matrix[i][0];  
        prefixSum[3][i][col-1] = matrix[i][col-1];  
    }  
    for(int j=0;j<col;j++){  
        prefixSum[0][0][j] = matrix[0][j];  
        prefixSum[1][row-1][j] = matrix[row-1][j];  
    }  
    for(int i=1;i<row;i++){  
        for(int j = 0;j<col;j++){  
            prefixSum[0][i][j] = (matrix[i][j] == 1)? prefixSum[0][i-1][j]+1 : 0;  
        }  
    }  
    for(int i=row-2;i>=0;i--){  
        for(int j = 0;j<col;j++){  
            prefixSum[1][i][j] = (matrix[i][j] == 1)? prefixSum[1][i+1][j]+1 : 0;  
        }  
    }  
    for(int j=1;j<col;j++){  
        for(int i=0;i<row;i++){  
            prefixSum[2][i][j] = (matrix[i][j] == 1)? prefixSum[2][i][j-1]+1 : 0;  
        }  
    }  
  
    for(int j=col-2;j>=0;j--){  
        for(int i=0;i<row;i++){  
            prefixSum[3][i][j] = (matrix[i][j] == 1)? prefixSum[3][i][j+1]+1 : 0;  
        }  
    }  
    int globalMax = 0;  
    for(int i=0;i<row;i++){  
        for(int j=0;j<col;j++){  
            int curSol = Math.min(Math.min(prefixSum[0][i][j],prefixSum[1][i][j]),  
                    Math.min(prefixSum[2][i][j],prefixSum[3][i][j]));  
            if (curSol > globalMax){  
                globalMax = curSol;  
            }  
        }  
    }  
    return globalMax;  
}
```