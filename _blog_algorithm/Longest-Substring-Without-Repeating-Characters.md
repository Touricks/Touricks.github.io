---
layout: default
title: Longest-Substring-Without-Repeating-Characters
narrow: true
---
https://app.laicode.io/app/problem/253?plan=3
Given a string, find the longest substring without any repeating characters and return the length of it. The input string is guaranteed to be not null.

For example, the longest substring without repeating letters for "bcdfbd" is "bcdf", we should return 4 in this case.
***
```
[0,slow) 无效元素
[slow, fast) 目前解集
fast 正在处理，最终得到一个以fast为右边界的解集: [slow2,fast]
(fast,end] 前面的区域，以后再来探索吧
```

```java
public int longest(String input) {  
    HashSet<Character> set = new HashSet<>();  
    if (input == null || input.length() == 0) {  
        return 0;  
    }  
    char[] arr = input.toCharArray();  
    int slow = 0;  
    int fast = 0;  
    int best = 0;  
    while(fast < input.length()){  
        if (!set.contains(arr[fast])){  
            set.add(arr[fast]);  
            best = Math.max(best,fast-slow+1);  
        }else{  
            while(arr[slow] != arr[fast]){  
                set.remove(arr[slow]);  
                slow++;  
            }  
            slow++;  
        }  
        fast++;  
    }  
    return best;  
}
```