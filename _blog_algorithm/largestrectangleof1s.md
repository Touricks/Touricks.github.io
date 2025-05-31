---
layout: default
title: LargestRectangleOf1s
narrow: true
---
https://app.laicode.io/app/problem/102?plan=3

Determine the largest rectangle of 1s in a binary matrix (a binary matrix only contains 0 and 1), return the area.

**Assumptions**

- The given matrix is not null and has size of M * N, M >= 0 and N >= 0

**Examples**

{ {0, 0, 0, 0},

  {1, **1, 1, 1**},

  {0, **1, 1, 1**},

  {1, 0, 1, 1} }

the largest rectangle of 1s has area of 2 * 3 = 6
***
- 注意和以下两题的不同：
	- [LargestSquareOf1s](/algorithmnotes/LargestSquareOf1s.html)
		- 求最大全1正方形，由于dp解法是`O(N^2)`的，所以使用单调栈也没有优化空间
	- [LargestSubmatrixSum](/algorithmnotes/LargestSubmatrixSum.html)
		- 求最大子矩形，由于对每个位置的元素没有硬性要求，可以使用前缀和处理区间然后O(N)解决，但这里我们对元素有要求（必须为1），所以需要使用单调栈

- 预处理对于第i行，向上均为1的最大值
	- 可以由上一行的height O(N)得到，和单调栈算法并列
	- 总复杂度为O(N^2)

- S1:   栈的单调性：递增
- S2：栈中永远存索引（值得强调）
- S3：元素何时出栈：栈顶元素大于等于当前元素
- S3：元素出栈时如何更新答案：`height * (curIndex-1-peek())`
- S4：栈中剩余元素: 需要考虑： `height * (len-1-peek())`

```java
public int largest(int[][] matrix) {  
    if (matrix.length == 0 || matrix[0].length == 0){  
        return 0;  
    }  
    int[] height = new int[matrix[0].length];  
    Deque<Integer> stack = new LinkedList<>();  
    stack.push(-1);  
    int best = 0;  
    for(int i=0;i<matrix.length;i++){  
        for(int j=0;j<matrix[0].length;j++){  
            height[j] = (matrix[i][j] == 1)? height[j]+1 : 0;  
        }  
        for(int j=0;j<matrix[0].length;j++){  
            if (stack.peek() == -1 || height[stack.peek()] < height[j]){  
                stack.push(j);  
            }else{  
                while(stack.peek() != -1 && height[stack.peek()] >= height[j]){  
                    int curHeight = height[stack.pop()];  
                    int width = j-1-stack.peek();  
                    if (best < curHeight*width){  
                        best = curHeight*width;  
                    }  
                }  
                stack.push(j);  
            }  
        }  
        while(stack.peek() != -1){  
            int curHeight = height[stack.pop()];  
            int width = matrix[0].length-1-stack.peek();  
            if (best < curHeight*width){  
                best = curHeight*width;  
            }  
        }  
    }  
    return best;  
}
```