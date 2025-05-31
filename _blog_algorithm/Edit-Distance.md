---
layout: default
title: Edit-Distance
narrow: true
---
https://app.laicode.io/app/problem/100?plan=3

Given two strings of alphanumeric characters, determine the minimum number of **Replace**, **Delete**, and **Insert** operations needed to transform one string into the other.

**Assumptions**

- Both strings are not null

**Examples**

string one: “sigh”, string two : “asith”

the edit distance between one and two is 2 (one insert “a” at front then replace “g” with “t”).

***
- `state:dp[i][j]表示将`字符串s1前i-1位和字符串s2前j-1位完全匹配的最少操作量`
- base case: `dp[0][i] = i; dp[j][0] = j; dp[0][0] = 0`
- Induction Rule: 
	- 向s1第i位插入字符 `dp[i][j] = dp[i][j-1]+1`
	- 向s1第i位删除字符 `dp[i][j] = dp[i-1][j]+1`
	- 将s1第i位字符修改为s2的第j位`dp[i][j] = dp[i-1][j-1]+1`
	- 匹配 `dp[i][j] = dp[i-1][j-1]` if match
- Result: `dp[s1.length][s2.length]`
- 保存路径：在dp更新时保存修改结果

- Code:带路径打印版本
- 易错点：**初始化不要设置为MAX_VALUE，因为我们有value+1操作，会溢出**
```java
public int editDistance(String one, String two) {  
    int[][] dp = new int[one.length()+1][two.length()+1];  
    for(int i=0;i<=one.length();i++){  
        for(int j=0;j<=two.length();j++){  
            dp[i][j] = Integer.MAX_VALUE/2;  
        }  
    }  
    char[][] changelog = new char[one.length()+1][two.length()+1];  
    for(int i=0;i<=one.length();i++){  
        dp[i][0] = i;  
        changelog[i][0] = 'D';  
    }  
    for(int j=0;j<=two.length();j++){  
        dp[0][j] = j;  
        changelog[0][j] = 'I';  
    }  
  
    for(int i=1;i<=one.length();i++){  
        for(int j=1;j<=two.length();j++){  
            int match = (one.charAt(i-1) == two.charAt(j-1))? dp[i-1][j-1] : Integer.MAX_VALUE;  
            int replace = dp[i-1][j-1]+1;  
            int insert = dp[i][j-1]+1;  
            int delete = dp[i-1][j]+1;  
            if (match < insert && match < delete){  
                dp[i][j] = match;  
                changelog[i][j] = 'M';  
            }else if (replace < insert && replace < delete){  
                dp[i][j] = replace;  
                changelog[i][j] = 'R';  
            }else if (insert < delete){  
                dp[i][j] = insert;  
                changelog[i][j] = 'I';  
            }else{  
                dp[i][j] = delete;  
                changelog[i][j] = 'D';  
            }  
        }  
    }  
    Integer res = dp[one.length()][two.length()];  
    StringBuilder s1 = new StringBuilder();  
    StringBuilder s2 = new StringBuilder();  
    int x = one.length();  
    int y = two.length();  
    while(x>0 || y>0){  
        if (changelog[x][y] == 'M' || changelog[x][y] == 'R'){  
            s1.append(one.charAt(x-1));  
            s2.append(two.charAt(y-1));  
            x--;  
            y--;  
        }else if (changelog[x][y] == 'I'){  
            s1.append('_');  
            s2.append(two.charAt(y-1));  
            y--;  
        }else{  
            s1.append(one.charAt(x-1));  
            s2.append('_');  
            x--;  
        }  
    }  
    s1.reverse();  
    s2.reverse();  
    System.out.println(s1);  
    System.out.println(s2);  
    return res;  
}
```