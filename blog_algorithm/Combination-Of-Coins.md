---
layout: default
title: Combination-Of-Coins
narrow: true
---
Given a number of different denominations of coins (e.g., 1 cent, 5 cents, 10 cents, 25 cents), get all the possible ways to pay a target number of cents.

**Arguments**

- coins - an array of positive integers representing the different denominations of coins, there are no duplicate numbers and the numbers are sorted by descending order, eg. {25, 10, 5, 2, 1}
- target - a non-negative integer representing the target number of cents, eg. 99

**Assumptions**

- coins is not null and is not empty, all the numbers in coins are positive
- target >= 0
- You have infinite number of coins for each of the denominations, you can pick any number of the coins.

**Return**

- a list of ways of combinations of coins to sum up to be target.
- each way of combinations is represented by list of integer, the number at each index means the number of coins used for the denomination at corresponding index.

**Examples**
coins = {2, 1}, target = 4, the return should be

[
  [0, 4],   (4 cents can be conducted by 0 * 2 cents + 4 * 1 cents)
  [1, 2],   (4 cents can be conducted by 1 * 2 cents + 2 * 1 cents)
  [2, 0]    (4 cents can be conducted by 2 * 2 cents + 0 * 1 cents)
]
***
- Combination问题
- Method1:一次考虑一个元素
- index表示考虑到第k个硬币
- Base Case:
	-  remain == 0, 合法的结果，加入解
	-  remain<0的state不会被放到stack中
- level：最多target/min(coins[k])层，表示当前考虑加哪个硬币
- 分支：len-k+1层，表示下次决定拿哪个硬币
- dfs rule: 如果remain-coin[opt]>=0，则当前选择合法，可以拓展，扩展区间为`[opt,len)`

```java
public List<List<Integer>> combinations(int target, int[] coins) {  
    List<List<Integer>> res = new ArrayList<>();  
    List<Integer> cur = new ArrayList<>(coins.length);  
    for(int i=0;i<coins.length;i++) cur.add(0);  
    dfs(target,coins,0,res,cur);  
    return res;  
}  
public void dfs(int target, int[] coins, int index, List<List<Integer>> res, List<Integer> cur){  
    if (target == 0){  
        res.add(new ArrayList<>(cur));  
        return;  
    }  
    for(int opt = index; opt < coins.length;opt++){  
        if (target-coins[opt] >= 0){  
            cur.set(opt,cur.get(opt)+1);  
            dfs(target-coins[opt],coins,opt,res,cur);  
            cur.set(opt,cur.get(opt)-1);  
        }  
    }  
}
```

- Method2：一次考虑一种面值
- index表示考虑到第k个面额
- Base Case:
	- index = len, remain == 0, 合法的结果，加入解
- level：k层，表示当前考虑加哪种硬币
- 分支：target/coin[i]层，表示决定拿多少枚当前硬币
- dfs rule: 如果remain-coin[i] x m>=0，则当前选择合法，可以拓展，扩展区间为i+1

- 易错点
	- 不能当target等于0时就收集解，因为此时解的构造还不完整（如果后续硬币都取0个）
	
```java
public List<List<Integer>> combinations(int target, int[] coins) {  
    List<List<Integer>> res = new ArrayList<>();  
    List<Integer> cur = new ArrayList<>(coins.length);  
    dfs(target,coins,0,res,cur);  
    return res;  
}  
public void dfs(int target, int[] coins, int index, List<List<Integer>> res, List<Integer> cur){  
    if (target == 0 && index == coins.length){  
        res.add(new ArrayList<>(cur));  
        return;  
    }  
    if (index == coins.length){  
        return;  
    }  
    for(int i=0;i<=target/coins[index];i++){  
        cur.add(i);  
        dfs(target-coins[index]*i,coins,index+1,res,cur);  
        cur.remove(cur.size()-1);  
    }  
}
```