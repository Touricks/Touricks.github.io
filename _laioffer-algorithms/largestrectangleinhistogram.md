---
layout: default
title: LargestRectangleInHistogram
narrow: true
---
Given a non-negative integer array representing the heights of a list of adjacent bars. Suppose each bar has a width of 1. Find the largest rectangular area that can be formed in the histogram.

**Assumptions**
- The given array is not null or empty

**Examples**
- { 2, 1, **3, 3, 4** }, the largest rectangle area is 3 * 3 = 9(starting from index 2 and ending at index 4)
***
- S1:   栈的单调性：单调递增，因为当出现比栈顶元素矮的柱子时，以栈顶元素柱子为高度的左右边界就可以确定了（左：栈顶pop后的栈顶+1，若栈为空则为index=0; 右：当前元素的index-1）
- S2：栈中永远存索引（值得强调）
- S3：元素何时出栈：如果栈中元素大于等于当前待加入元素
- S3：元素出栈时如何更新答案：新矩形高度等于`height * (curIndex-1-stack.peek())`
- S4：栈中剩余元素:需要考虑，可以形成的矩形高度等于`height*(len-1-stack.peek())`
- 取最大值

- 易错点：处理相等高度时，标准的单调栈做法通常是弹出栈顶元素（因为找到了它的右边界），或者将当前索引也压入栈（如果允许栈中元素高度不严格单调）。一个常见的做法是 `while` 循环的条件是 `height[stack.peek()] >= height[j]`，这样相等高度的也会被弹出处理。
- 但**相等时不能直接continue**，虽然当前柱子宽度的计算不会出现错误，但是后续较高柱子宽度的计算会出问题
- 例如，对于柱状图 `height = [2, 2, 3]`：
1. `j=0, height[0]=2`。栈：`[-1, 0]`。
2. `j=1, height[1]=2`。`height[stack.peek()] == height[1]` 为真，执行 `continue`。栈仍为 `[-1, 0]`。（**错误点：索引1没有入栈**）
3. `j=2, height[2]=3`。`height[stack.peek()] < height[2]` (即 `height[0] < height[2]`，2 < 3) 为真。栈：`[-1, 0, 2]`。
4. 行末清空栈：
    - 弹出索引2 (`height[2]=3`)。`curHeight=3`。`width = (matrix[0].length-1) - stack.peek() = (3-1) - 0 = 2`。面积 `3*2=6`。这是错误的，因为高度为3的柱子（索引2）实际宽度只有1。错误的原因是索引1没有入栈，导致计算索引2的左边界时错误地跳过了索引1而找到了索引0。

- 错误写法
```java
for(int i=0;i<array.length;i++){
            if (stack.peek() == -1 || array[i] > array[stack.peek()]){
                stack.push(i);
            }else if (array[i] == array[stack.peek()]){
                continue;
            }else{
                while(stack.peek() != -1 && array[i]<array[stack.peek()]){
                    int height = array[stack.pop()];
                    int width = (i-1-stack.peek());
                    best = Math.max(best,height*width);
                }
                stack.push(i);
            }
        }
```

- 正确写法
```java
public int largest(int[] array) {  
    Deque<Integer> stack = new LinkedList<>();  
    stack.push(-1);  
    int best = 0;  
    for(int i=0;i<array.length;i++){  
        if (stack.peek() == -1 || array[i] > array[stack.peek()]){  
            stack.push(i);  
        }else if (array[i] == array[stack.peek()]){  
            continue;  
        }else{  
            while(stack.peek() != -1 && array[i]<array[stack.peek()]){  
                int height = array[stack.pop()];  
                int width = (i-1-stack.peek());  
                best = Math.max(best,height*width);  
            }  
            stack.push(i);  
        }  
    }  
    while(stack.peek() != -1){  
        int height = array[stack.pop()];  
        int width = array.length-1-stack.peek();  
        best = Math.max(best,height*width);  
    }  
    return best;  
}
```