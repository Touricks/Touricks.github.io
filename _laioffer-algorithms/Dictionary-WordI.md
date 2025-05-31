---
layout: default
title: Dictionary WordI
narrow: true
---

https://app.laicode.io/app/problem/99?plan=3
Given a word and a dictionary, determine if it can be composed by concatenating words from the given dictionary.

**Assumptions**

- The given word is not null and is not empty
- The given dictionary is not null and is not empty and all the words in the dictionary are not null or empty

**Examples**

Dictionary: {“bob”, “cat”, “rob”}

- Word: “robob” return false
- Word: “robcatbob” return true since it can be composed by "rob", "cat", "bob"

---

State：dp[i] 表示到字符串 index=i-1 为结尾时最小切割次数
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
