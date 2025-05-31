---
layout: default
title: FactorCombination
narrow: true
---
https://app.laicode.io/app/problem/404?plan=3
Given an integer number, return all possible combinations of the factors that can multiply to the target number.

Example

Give A = 24

since 24 = 2 x 2 x 2 x 3

              = 2 x 2 x 6

              = 2 x 3 x 4

              = 2 x 12

              = 3 x 8

              = 4 x 6

your solution should return

{ { 2, 2, 2, 3 }, { 2, 2, 6 }, { 2, 3, 4 }, { 2, 12 }, { 3, 8 }, { 4, 6 } }
***
Combination问题
Signature: dfs(target,curFactor,index,curSol)
	目前还需要拼凑target，只能用curFactor[]中index为index的因数，目前已经保存的因数在curSol中
Base Case: target == 1, 返回结果; index == len, 无效解
Level：curFactor，每层考虑一个因数的个数
分支：一个因数的最大个数k，使得`num[i]^k <= target`
剪枝：如果`target%curFactor[i]!=0`直接return

```java
public List<List<Integer>> combinations(int target) {  
    // Write your solution here  
    List<Integer> factor = new ArrayList<>();  
    for (int i = 2; i < target; i++) {  
        if (target % i == 0) {  
            factor.add(i);  
        }  
    }  
    List<List<Integer>> res = new ArrayList<>();  
    List<Integer> cur = new ArrayList<>();  
    if (target <= 2){  
        return res;  
    }  
    dfs(target,factor,0,cur,res);  
    return res;  
}  
public void dfs(int target, List<Integer> factor, int index, List<Integer> cur, List<List<Integer>> res){  
    if (target == 1){  
        res.add(new ArrayList<>(cur));  
        return;  
    }  
    if (index == factor.size()){  
        return;  
    }  
    dfs(target,factor,index+1,cur,res);  
    int max = 0;  
    while(target % factor.get(index) == 0){  
        target = target / factor.get(index);  
        cur.add(factor.get(index));  
        dfs(target,factor,index+1,cur,res);  
        max++;  
    }  
    for(int i=0;i<max;i++){  
        cur.remove(cur.size()-1);  
    }  
}
```