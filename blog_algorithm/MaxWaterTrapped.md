---
layout: default
title: MaxWaterTrapped
narrow: true
---
https://app.laicode.io/app/problem/199

Given a non-negative integer array representing the heights of a list of adjacent bars. Suppose each bar has a width of 1. Find the largest amount of water that can be trapped in the histogram.

**Assumptions**

- The given array is not null

**Examples**

- { 2, 1, 3, 2, 4 }, the amount of water can be trapped is 1 + 1 = 2 (at index 1, 1 unit of water can be trapped and index 3, 1 unit of water can be trapped)
***
- Method1: 单调栈
-  我们关心的是每个位置 `i` 能接多少水。这取决于 `min(左边最高柱子, 右边最高柱子) - height[i]`。
- 单调栈可以用来维护一个**单调递减**的柱子索引序列。
    - 当遇到一个比栈顶元素高的柱子 `height[current]` 时，说明栈顶柱子 `height[stack.top()]` 的**右边界**找到了（就是 `height[current]`）。
    - 此时，栈顶柱子的**左边界**是栈中仅次于栈顶的那个元素 `height[stack.second_top()]`（如果存在的话）。
    - 于是，以 `height[stack.top()]` 为底的凹槽就可以计算储水量了。
    - 注意我们每次弹栈计算的储水量不代表一个以 `height[stack.top()]` 为底的凹槽的储水量，需要多次叠加

```
stack[i]: 表示当前仍未确定的index=i的位置对应的深度所能贡献的水量
当一个元素加入栈时：
	如果栈顶元素小于当前元素 - 进入while
		如果第二栈顶元素不存在 - break
		否则更新答案， width(当前元素-第二栈顶元素) * height(Min-栈顶元素),继续while
	当前元素入栈
```
- Code
```java
public int maxTrapped(int[] array) {  
    int result = 0;  
    Deque<Integer> stack = new LinkedList<>();  
    for(int i=0;i<array.length;i++){  
        while (!stack.isEmpty() && array[i] > array[stack.peek()]){  
            int bottom = stack.pop();  
            if (stack.isEmpty()){  
                break;  
            }  
            int left = stack.peek();  
            int distance = i-left-1;  
            int bounded = Math.min(array[left],array[i])-array[bottom];  
            if (bounded > 0){  
                result = result + bounded*distance;  
            }  
        }  
        stack.push(i);  
    }  
    return result;  
}
```

***
- Method2: leftMax / rightMax
- S1: 从左往右扫 `leftMax[i] = max(height[0..i])`
- S2: 从右往左扫 `rightMax[i] = max(height[i..n-1])`
- S3: 对每根柱子求水位 `water[i] = min(leftMax[i], rightMax[i]) – height[i]`

| 特点    | 前缀/后缀数组                                       | 单调栈                                                                                                    |
| ----- | --------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| 预处理信息 | “到目前为止的最值”(max/min)                           | “与当前元素形成边界的第一更小/更大”                                                                                    |
| 适合的问题 | **区间最值 + `min/max` 运算**         例：接雨水、滑动窗口最大值 | **最近更小/更大、连续边界**                                        例：Largest Rectangle、下一个更大元素、Daily Temperatures |
- 对比：
	- **接雨水**：每个柱子能接多少水，只和它“视野范围内”的左右两边的最高山峰有关，形成一个大“盆地”。用前缀/后缀最大值可以找到这两个山峰。
	- **最大矩形**：以某个柱子的高度为标准画一条水平线，看这条线能延伸多远。延伸的终点是第一个“掉下去”（遇到更矮柱子）的地方。这种“第一个更矮”的信息，正是单调栈所擅长处理的。
	- 由于你不能在看到柱子 `h` 的时候，就完全确定它最终的左右边界，因为右边界要等扫描到那个更矮的柱子时才能确定。即，一个元素的“有效边界”是相对的，并且只有在扫描到那个边界点时才能最终确定，因此计算必须是在线的，**不能使用前缀后缀数组方法**

```java
public int maxTrapped(int[] array) {  
    int result = 0;  
    int[] leftMax = new int[array.length];  
    int[] rightMax = new int[array.length];  
    for(int i=0;i<array.length;i++){  
        if (i==0){  
            leftMax[i] = array[i];  
        }else{  
            leftMax[i] = Math.max(array[i],leftMax[i-1]);  
        }  
    }  
    for(int i=array.length-1;i>=0;i--){  
        if (i==array.length-1){  
            rightMax[i] = array[i];  
        }else{  
            rightMax[i] = Math.max(array[i],rightMax[i+1]);  
        }  
    }  
    for(int i=0;i<array.length;i++){  
        result = result + (Math.min(leftMax[i],rightMax[i])-array[i]);  
    }  
    return result;  
}
```

***
- Method3: 记录左右端最大值，优化空间复杂度至O（1）
- leftMax表示从左端开始到位置left墙的最大高度
- rightMax表示从右端开始到位置right墙的最大高度
- 若 `leftMax ≤ rightMax`，**左侧**的水面高度受左边最高柱 (`leftMax`) 限制；
    - 因为右侧当前最高柱已**不低于** `leftMax`，即刻算出的 `leftMax - height[left+1]` 一定是最终值，后续右边再高也不会变小。
- 对称地，当 `leftMax > rightMax` 时可以敲定右侧。
- 因此，`min(leftMax, rightMax)` 决定当前外侧格子的水位
- 那么我们在确定一个格子的可能水位后，更新leftMax和rightMax就可以了

- 算法思路：木桶理论 - 盯住最短板，谁小移动谁
	- if left_max 小，left这个点的水位被leftMax确定了，更新i这个点的存水leftMax-H(left)
	- if right_max小，right这个点的水位被rightMax确定，更新i这个点的存水rightMax-H(right)


- Code
```java
public int maxTrapped(int[] array) {  
    int result = 0;  
    if (array == null || array.length<2){  
        return 0;  
    }  
    int leftMax = array[0];  
    int rightMax = array[array.length-1];  
    int left = 0;  
    int right = array.length-1;  
    while(left < right){  
        if (leftMax<rightMax){  
            left++;  
            result = result + Math.max(0,leftMax-array[left]);  
            leftMax = Math.max(array[left],leftMax);  
        }else{  
            right--;  
            result = result + Math.max(0,rightMax-array[right]);  
            rightMax = Math.max(array[right],rightMax);  
        }  
    }  
    return result;  
}
```