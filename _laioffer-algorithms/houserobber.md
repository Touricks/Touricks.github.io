---
layout: default
title: HouseRobber
narrow: true
---

[https://app.laicode.io/app/problem/685](https://app.laicode.io/app/problem/685)

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

  
Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police. 

选一些房子打劫，不能选相邻的房子，
假设1. 这个房子里面的面额都是正数，2. 第一个房子和最后一个房子相连
问最多能抢多少
***
状态选择问题 -> 背包问题雏形
- key point: 对于当前这个房子，我能考虑的无非就2种情况，偷当前房子 or 不偷当前的房子
- step 1: dp[i]物理意义：偷到index i的这个房子的时候，我能偷到的最大面值
- step 2: base case
	- dp[0] = input[0]
	- dp[1] = MAX(input[0], input[1])
- step 3: Induction rule
	- case 1: 偷当前房子
		dp[i] = input[i] + dp[i - 2] -> 当前抢了，不能考虑前一个，直接考虑[0, i-2]面值
	- case 2: 不偷当前房子
		dp[i] = dp[i - 1]  -> 当前没抢，前一天是什么样你就是什么样
	- dp[i] = MAX(case1, case2)
- step 4: result:
	dp[len - 1]

TC: O(n)
SC: O(n)

- 首尾相连变成环形数组还是找偷的最大
	- case 1: 要头不要尾，[0, len - 2] run house robber 1
	- case 2: 要尾不要头 [1, len - 1] run house robber 1
	- final result from MAX(case1, case2)

***
```java
class Solution {  
    public int rob(int[] nums) {  
        if (nums == null || nums.length == 0) {  
            return 0;  
        }  
        if (nums.length < 2) {  
            return nums[0];  
        }  
        int[] dp = new int[nums.length];  
        // if only one element, must rob  
        dp[0] = nums[0];  
        // if two elements, consider rob which one  
        dp[1] = Math.max(nums[0], nums[1]);  
         
        for (int i = 2; i < nums.length; i++) {  
            int robCur = dp[i - 2] + nums[i];  
            int notRobCur = dp[i - 1];  
            dp[i] = Math.max(robCur, notRobCur);  
        }  
         
        return dp[nums.length - 1];  
    }  
}
```