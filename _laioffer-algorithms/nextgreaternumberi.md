---
layout: default
title: NextGreaterNumberI
narrow: true
---
Given two integer arrays all and partial without duplicate numbers, array partial is subset of array all. For each number in partial, find the first number on its right in all that greater than it. If no such number existed, then assign the result to -1.

Example 1: 

Input: all = [3,4,1,2]    partial = [4,1,2]

Output: [-1, 2, -1]

Example 2:

Input: all = [1, 2, 3, 4] partial = [4,1,2]

Output: [-1, 2, 3]
***
- 栈的单调性：递减
- 栈中存：索引
- 元素何时出栈：当前元素大于栈顶元素
- 出栈更新答案：直接更新：`greater.put(all[stack.pop()], all[i]);`
- 剩余元素对答案的贡献：没有找到更大的元素，置-1

- 易错点：对于这种数组内元素不知道有多大的题目，使用HashMap存一个值为k的元素的nextGreater是多少，不要用List或array

- Code
```java
public int[] nextGreaterElement(int[] partial, int[] all) {  
    HashMap<Integer,Integer> greater = new HashMap<>();  
    Deque<Integer> stack = new LinkedList<>();  
    for(int i=0;i<all.length;i++){  
        if (stack.isEmpty() || all[i] <= all[stack.peek()]){  
            stack.push(i);  
        }else{  
            while(!stack.isEmpty() && all[i] > all[stack.peek()]){  
                greater.put(all[stack.pop()], all[i]);  
            }  
            stack.push(i);  
        }  
    }  
  
    int[] res = new int[partial.length];  
    for(int i=0;i<partial.length;i++){  
        res[i] = greater.getOrDefault(partial[i],-1);  
    }  
    return res;  
}
```