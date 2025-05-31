---
layout: default
title: MinimumInsertion
narrow: true
---
https://leetcode.com/problems/minimum-insertion-steps-to-make-a-string-palindrome/description/

Given a string `s`. In one step you can insert any character at any index of the string.

Return _the minimum number of steps_ to make `s` palindrome.

A **Palindrome String** is one that reads the same backward as well as forward.

**Example 1:**

**Input:** s = "zzazz"
**Output:** 0
**Explanation:** The string "zzazz" is already palindrome we do not need any insertions.

**Example 2:**

**Input:** s = "mbadm"
**Output:** 2
**Explanation:** String can be "mbdadbm" or "mdbabdm".

**Example 3:**

**Input:** s = "leetcode"
**Output:** 5
**Explanation:** Inserting 5 characters the string becomes "leetcodocteel".
***
```
State:dp[i][j]表示让string s, s[i]到s[j]成为回文串需要增加的字符数
Base Case: dp[i][i] = 0 dp[i][i+1] = 1(s[i]!=s[i+1]) 0 (s[i]==s[i+1])
Induction: dp[i][j] = Min(dp[i+1][j-1] (s[i]==s[j]) ,dp[i+1][j]+1,dp[i][j-1]+1
Result: dp[0][len-1]
```

```java
public int minInsertions(String s) {  
    char[] arr = s.toCharArray();  
    int[][] dp = new int[arr.length][arr.length];  
    for(int i=0;i<s.length();i++){  
        for(int j=0;j<s.length();j++){  
            dp[i][j] = Integer.MAX_VALUE;  
        }  
    }  
    for(int i=0;i<arr.length;i++){  
        dp[i][i] = 0;  
    }  
    for(int i=0;i<s.length()-1;i++){  
        dp[i][i+1] = (arr[i] == arr[i+1])? 0 : 1;  
    }  
    for(int extendLen = 2;extendLen<arr.length;extendLen++){  
        for(int i = 0;i<arr.length-extendLen;i++){  
            int j = i+extendLen;  
            dp[i][j] = Math.min(dp[i+1][j],dp[i][j-1])+1;  
            if (arr[i] == arr[j]){  
                dp[i][j] = Math.min(dp[i][j],dp[i+1][j-1]);  
            }  
        }  
    }  
    return dp[0][arr.length-1];  
}
```