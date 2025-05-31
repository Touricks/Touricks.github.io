---
layout: default
title: LIS
narrow: true
---
https://app.laicode.io/app/problem/1

Given an array A[0]...A[n-1] of integers, find out the length of the longest ascending subsequence.

**Assumptions**
- A is not null

**Examples**  
Input: A = {5, 2, 6, 3, 4, 7, 5}  
Output: 4  
Because [2, 3, 4, 5] is the longest ascending subsequence.
***
- Method1: DP(O(N^2))
- State
	- `dp[i]`表示以index i结尾能获得的最长子序列
- Base Case: 
	- `dp[i] = 1` for all i
	- 如果A长度为0则返回0
- Induction Rule
	- `dp[i] = Max(dp[j])+1 for all j<i and arr[j]<arr[i]`
- Result:
	- `Max(dp[i]) for all i`

- Code
```java
public int longest(int[] array) {  
    if (array == null || array.length == 0){  
        return 0;  
    }  
    int[] dp = new int[array.length];  
    for(int i=0;i<array.length;i++){  
        dp[i] = 1;  
    }  
    int globalMax = 1;  
    for(int i=0;i<array.length;i++){  
        for(int j=0;j<i;j++){  
            if (dp[j]+1 > dp[i] && array[j] < array[i]){  
                dp[i] = dp[j]+1;  
            }  
        }  
        if (globalMax < dp[i]){  
            globalMax = dp[i];  
        }  
    }  
    return globalMax;  
}
```

- Method2: 动态数组
- 令`dp[i]`表示所有长度为k+1的递增子序列中 **结尾元素最小** 的值
- dp **严格递增** → 可以二分；二分找到dp数组里第一个不小于当前值的位置，进行替换
- 每条长度 `k` 的升序子序列的 “最优尾值” 都被维护在 `dp[k-1]`；
- 用更小的尾值更新只会 **增加后续拼接成功的机会**，不会破坏已存在的更长序列
- 例如

| 步   | 读入 x | 二分位置 pos   | 操作       | dp 数组（有效长度 = size） |
| --- | ---- | ---------- | -------- | ------------------ |
| 1   | 10   | pos = 0（空） | push     | **[10]**           |
| 2   | 9    | pos = 0    | dp[0]=9  | **[9]**            |
| 3   | 2    | pos = 0    | dp[0]=2  | **[2]**            |
| 4   | 5    | pos = 1    | push     | **[2, 5]**         |
| 5   | 3    | pos = 1    | dp[1]=3  | **[2, 3]**         |
| 6   | 7    | pos = 2    | push     | **[2, 3, 7]**      |
| 7   | 101  | pos = 3    | push     | **[2, 3, 7, 101]** |
| 8   | 18   | pos = 3    | dp[3]=18 | **[2, 3, 7, 18]**  |

- 易错点：对于 **严格递增** LIS，`tails` 数组必须保持 **递增且不含重复值**。  因此在二分时应当寻找 **第一个 ≥ target 的位置** 并替换；  如果代码找的是 **第一个 > target**，结果会把与 `target` 相等的值当成 “更大”，从而把重复值直接 `add` 到尾部，破坏了不变式。
- 例如： `array=[2,2,2]`

|i|读入|dp 期望|代码结果|
|---|---|---|---|
|0|2|[2]|[2]|
|1|2|[2]|[2,2] ← ❌ 多加了一项|
|2|2|[2]|[2,2,2] ← ❌|
|最终输出 `dp.size() = 3`，而正确 LIS 长度应为 **1**。||||
- 错误代码片段
```java
if (dp.get(mid) <= target) {     // 用了 “<=”
    left = mid + 1;              // 使相等元素被视为“小于”，跳过
} else {
    right = mid;
}
```

- 正确Code
```java
public int longest(int[] array) {  
    List<Integer> dp = new ArrayList<>();  
    for(int i=0;i<array.length;i++){  
        if (dp.isEmpty()){  
            dp.add(array[i]);  
        }else{  
            // find the first element in dp that satisfied dp[j] > array[i]  
            int firstLarger = find(dp,array[i],0,dp.size()-1);  
            if (firstLarger == dp.size()){  
                dp.add(array[i]);  
            }else{  
                dp.set(firstLarger,array[i]);  
            }  
        }  
    }  
    return dp.size();  
}  
public int find(List<Integer> dp, int target, int l,int r){  
    int left = l;  
    int right = r;  
    while(left < right-1){  
        int mid = left + (right-left)/2;  
        if (dp.get(mid) < target){  
            left = mid+1;  
        }else{  
            right = mid;  
        }  
    }  
    if (dp.get(left) >= target){  
        return left;  
    }  
    if (dp.get(right) >= target){  
        return right;  
    }  
    return right+1;  
}
```