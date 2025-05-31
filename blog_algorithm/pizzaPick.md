---
layout: default
title: pizzaPick
narrow: true
---
https://app.laicode.io/app/problem/657?plan=3

There is an array of positive integers, in which each integer represents a piece of Pizza’s size, you and your friend take turns to pick pizza from either end of the array. Your friend follows a simple strategy: He will always pick the larger one he could get during his turn. The winner is the one who gets the larger total sum of all pizza. Return the max amount of pizza you can get.

Assumption: If during your friend's turn, the leftmost pizza has the same size as the rightmost pizza, he will pick the rightmost one.

Example:

Input: [2,1,100,3]

Output: 102

Explanation: To win the game, you pick 2 first, then your friend will pick either 3, after that you could pick 100. In the end you could get 2 + 100 = 102, while your friend could only get 1 + 3 = 4.

***
```java
State: dp[i][j] = 从第i块到第 j 块披萨里，先手最终能拿到的最大总和。
Base Case: 
 长度 1：dp[i][i] = value[i]`
 长度 2：dp[i][i+1] = max(value[i], value[i+1])
Induction Rule
	dp[i][j] = Max(拿左边，拿右边)
	拿左边：left = arr[i] + (arr[i+1] > arr[j])? arr[i+2][j] : arr[i+1][j-1]
	拿右边：right = arr[j] + (arr[i] > arr[j-1])? arr[i+1][j-1] : arr[i][j-2]
Result: dp[0][len-1]
```

- Code
```java
public int canWin(int[] nums) {  
    int[][] dp = new int[nums.length][nums.length];  
    for(int len = 1; len <= nums.length; len++){  
        for(int i=0;i<nums.length-len+1;i++){  
            if (len == 1){  
                dp[i][i] = nums[i];  
            }else  
            if (len == 2){  
                dp[i][i+1] = Math.max(nums[i],nums[i+1]);  
            }else{  
                int j = i+len-1;  
                int left = nums[i] + ((nums[i+1]>nums[j])? dp[i+2][j] : dp[i+1][j-1]);  
                int right = nums[j] + ((nums[i]>nums[j-1])? dp[i+1][j-1] : dp[i][j-2]);  
                dp[i][j] = Math.max(left,right);  
            }  
        }  
    }  
    return dp[0][nums.length-1];  
}
```