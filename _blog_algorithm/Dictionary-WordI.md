---
layout: default
title: Dictionary-WordI
narrow: true
---
https://app.laicode.io/app/problem/99?plan=3

Given a word and a dictionary, determine if it can be composed by concatenating words from the given dictionary.

**Assumptions**

- The given word is not null and is not empty
- The given dictionary is not null and is not empty and all the words in the dictionary are not null or empty

**Examples**

Dictionary: {“bob”, “cat”, “rob”}

- Word: “robob” return false
- Word: “robcatbob” return true since it can be composed by "rob", "cat", "bob"
***
- 示例
- step1: dp的物理意义：
`dp array: dp[i]` represent 长度为i的string能不能切成每一段都在字典里
- step2: base case
`dp[0](empty) = true / false` 长度为0不用切，默认为true
- step3: induction rule
	- Linear Scan 所有可能的 长度 i，对于当前的长度i？dp[i] 表示最后一个index i - 1
	- case 1(整个满足条件): 长度为i的string直接在字典里面 
		- -> `input.substring[0, i) contains -> dp[i] = true`
	- case 2: 回头看看所有可能的左大段的长度是j -> 它的右小段`[j,i)`是不是在字典里
- step4：result：`dp[length]`
***
State：dp[i] 表示到字符串index=i-1为结尾时最小切割次数
Base Case：dp[0] = true, 其他不合法（false）
Induction：`dp[i] = true if set.contains(input.substring(j,i)) && dp[j] == true`
Result: dp[length]

```java
public boolean canBreak(String input, String[] dict) {  
    HashSet<String> set = new HashSet<>();  
    boolean[] dp = new boolean[input.length() + 1];  
    for (int i = 0; i < dict.length; i++) {  
        set.add(dict[i]);  
    }  
    dp[0] = true;  
    for (int i = 1; i <= input.length(); i++){  
        for (int j = 0; j < i; j++) {  
            if (dp[j] && set.contains(input.substring(j,i))){  
                dp[i] = true;  
                break;  
            }  
        }  
    }  
    return dp[input.length()];  
}
```