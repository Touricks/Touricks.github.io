---
layout: default
title: LCS
narrow: true
---
https://app.laicode.io/app/problem/176?plan=3

Find the longest common substring of two given strings.

**Assumptions**

- The two given strings are not null

**Examples**

- S = “abcde”, T = “cdf”, the longest common substring of S and T is “cd”
***
```
State: dp[i][j]表示 s[0..i-1]和t[0..j-1]的最长公共子序列
		(不一定要include s[i-1]和t[j-1])
Base Case: dp[i][j] = 0 for all i/j
Induction Rule:
	dp[i][j] = Max(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]+1 (if s[i-1] == t[j-1]))
Result: globalMax(dp[slen][tlen])
```
- 原版本
```java
public int longest(String source, String target) {
	String[][] path = new String[source.length()+1][target.length()+1];
	int[][] dp = new int[source.length()+1][target.length()+1];
	for(int i=1;i<source.length()+1;i++){
		for(int j=1;j<target.length()+1;j++){
			if (dp[i-1][j] > dp[i][j-1]){
				path[i][j] = "i--";
			}else{
				path[i][j] = "j--";
			}
			dp[i][j] = Math.max(dp[i-1][j],dp[i][j-1]);
			if (source.charAt(i-1) == target.charAt(j-1)){
				if (dp[i-1][j-1]+1 > dp[i][j]){
					path[i][j] = "succ";
					dp[i][j] = dp[i-1][j-1]+1;
				}
			}
		}
	}
	StringBuilder sb = new StringBuilder();
	int indexi = source.length();
	int indexj = target.length();
	while(indexi>0 && indexj>0){
		if (path[indexi][indexj].equals("i--")){
			indexi--;
		}else if (path[indexi][indexj].equals("j--")){
			indexj--;
		}else{
			sb.append(source.charAt(indexi-1));
			indexi--;
			indexj--;
		}
	}
	sb.reverse();
	return dp[source.length()][target.length()];
}
```
- 打印路径版本
```java
public String longestCommon(String source, String target) {  
    String[][] path = new String[source.length()+1][target.length()+1];  
    int[][] dp = new int[source.length()+1][target.length()+1];  
    for(int i=1;i<source.length()+1;i++){  
        for(int j=1;j<target.length()+1;j++){  
            if (dp[i-1][j] > dp[i][j-1]){  
                path[i][j] = "i--";  
            }else{  
                path[i][j] = "j--";  
            }  
            dp[i][j] = Math.max(dp[i-1][j],dp[i][j-1]);  
            if (source.charAt(i-1) == target.charAt(j-1)){  
                if (dp[i-1][j-1]+1 > dp[i][j]){  
                    path[i][j] = "succ";  
                    dp[i][j] = dp[i-1][j-1]+1;  
                }  
            }  
        }  
    }  
    StringBuilder sb = new StringBuilder();  
    int indexi = source.length();  
    int indexj = target.length();  
    while(indexi>0 && indexj>0){  
        if (path[indexi][indexj].equals("i--")){  
            indexi--;  
        }else if (path[indexi][indexj].equals("j--")){  
            indexj--;  
        }else{  
            sb.append(source.charAt(indexi-1));  
            indexi--;  
            indexj--;  
        }  
    }  
    sb.reverse();  
    return sb.toString();  
}
```