---
layout: default
title: Spiral-Order
narrow: true
---
https://app.laicode.io/app/problem/122?plan=3

Traverse an M * N 2D array in spiral order clock-wise starting from the top left corner. Return the list of traversal sequence.

**Assumptions**

- The 2D array is not null and has size of M * N where M, N >= 0

**Examples**

{ {1,  2,  3,  4},

  {5,  6,  7,  8},

  {9, 10, 11, 12} }
the traversal sequence is [1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7]
***
- Signature: spiralOrder(offset,rowSize, colSize)
	- 表示我从第(offset-1,offset-1)开始，y轴方向前进rowSize,x轴方向前进colSize，遍历一个环形数组
- Base Case
	- if rowSize和colSize存在1则直接处理
	- if rowSize和colSize存在0则直接返回
- Subproblem
	- spiral(offset+1,rowSize-2,colSize-2)
- Recursive Rule
	- 对于这一题，子问题的解就是原问题的解

- Recursion写法
```java
public void dfs(int offset, int sizex, int sizey, List<Integer> res, int[][]matrix){  
    if (sizex < 0 || sizey < 0){  
        return;  
    }  
    if (sizex == 0 && sizey == 0){  
        res.add(matrix[offset][offset]);  
        return;  
    }  
    if (sizex == 0){  
        for(int i=0;i<=sizey;i++){  
            res.add(matrix[offset][offset+i]);  
        }  
        return;  
    }  
    if (sizey == 0) {  
        for(int i=0;i<=sizex;i++){  
            res.add(matrix[offset+i][offset]);  
        }  
        return;  
    }  
    for(int i=0;i<sizey;i++){  
        res.add(matrix[offset][offset+i]);  
    }  
    for(int i=0;i<sizex;i++){  
        res.add(matrix[offset+i][offset+sizey]);  
    }  
    for(int i=0;i<sizey;i++){  
        res.add(matrix[offset+sizex][offset+sizey-i]);  
    }  
    for(int i=0;i<sizex;i++){  
        res.add(matrix[offset+sizex-i][offset]);  
    }  
    dfs(offset+1,sizex-2,sizey-2,res,matrix);  
}
```
- Iterative写法
- `N*N版本`
```java
public List<Integer> spiral(int[][] matrix) {  
   int offset = 0;  
   int size = matrix.length-1;  
   List<Integer> res = new ArrayList<>();  
   while(size>=0){  
       if (size == 0){  
           res.add(matrix[offset][offset]);  
           break;  
       }  
       for(int i=0;i<size;i++){  
           res.add(matrix[offset][offset+i]);  
       }  
       for(int i=0;i<size;i++){  
           res.add(matrix[offset+i][offset+size]);  
       }  
       for(int i=0;i<size;i++){  
           res.add(matrix[offset+size][offset+size-i]);  
       }  
       for(int i=0;i<size;i++){  
           res.add(matrix[offset+size-i][offset]);  
       }  
       size = size-2;  
       offset = offset+1;  
   }  
   return res;  
}
```
- `N*M版本`
```java
public List<Integer> spiral(int[][] matrix) {  
    List<Integer> res = new ArrayList<>();  
    int offset = 0;  
    if (matrix == null || matrix.length == 0){  
        return res;  
    }  
    int sizeRow = matrix.length-1;  
    int sizeCol = matrix[0].length-1;  
        while(sizeRow>=0 && sizeCol >= 0){  
        if (sizeRow == 0 || sizeCol == 0){  
            if (sizeRow == 0){  
                for(int i=0;i<=sizeCol;i++){  
                    res.add(matrix[offset][offset+i]);  
                }  
            }else{  
                for(int i=0;i<=sizeRow;i++){  
                    res.add(matrix[offset+i][offset]);  
                }  
            }  
            break;  
        }  
        for(int i=0;i<sizeCol;i++){  
            res.add(matrix[offset][offset+i]);  
        }  
        for(int i=0;i<sizeRow;i++){  
            res.add(matrix[offset+i][offset+sizeCol]);  
        }  
        for(int i=0;i<sizeCol;i++){  
            res.add(matrix[offset+sizeRow][offset+sizeCol-i]);  
        }  
        for(int i=0;i<sizeRow;i++){  
            res.add(matrix[offset+sizeRow-i][offset]);  
        }  
        sizeRow = sizeRow-2;  
        sizeCol = sizeCol-2;  
        offset = offset+1;  
    }  
    return res;  
}
```