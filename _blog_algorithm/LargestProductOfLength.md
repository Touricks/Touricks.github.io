---
layout: default
title: LargestProductOfLength
narrow: true
---
https://app.laicode.io/app/problem/191?plan=3

Given a dictionary containing many words, find the largest product of two words’ lengths, such that the two words do not share any common characters.

**Assumptions**

- The words only contains characters of 'a' to 'z'
- The dictionary is not null and does not contains null string, and has at least two strings
- If there is no such pair of words, just return 0

**Examples**

- dictionary = [“abcde”, “abcd”, “ade”, “xy”], the largest product is 5 * 2 = 10 (by choosing “abcde” and “xy”)
***
**“两个单词没有共同字符”**。
这句话的本质是在判断两个单词的**字符集合**的交集是否为空。
- `"abcde"` 的字符集是 `{a, b, c, d, e}`
- `"xy"` 的字符集是 `{x, y}`
- 它们的交集是 `∅` (空集)，所以符合条件。

现在的问题是，计算机如何高效地存储和比较这两个集合？如果每次都用哈希集合（HashSet）来存储和比较，效率并不高。

这时，“状态压缩”就登场了。它的核心思想是：**用一个整数的二进制位来“编码”这个字符集**。

由于题目规定单词只包含 'a' 到 'z' 的小写字母，总共 **26** 个。这提供了一个关键线索：我们可以用一个 32 位的 `int` 类型的整数来表示任何一个字符集。因为一个 `int` 至少有 32 个二进制位，足够容纳 26 个字母的状态。

**编码规则：** 我们把这个 `int` 想象成一排有 26 个开关的开关面板，从右到左，第 0 个开关代表 'a'，第 1 个开关代表 'b'，...，第 25 个开关代表 'z'。
- 如果一个单词**包含**某个字母，我们就把对应的开光拨到 **ON (1)**。
- 如果不包含，就保持 **OFF (0)**。

**举例说明：**
1. 对于单词 `"abc"`：
    - 它包含 `a`, `b`, `c`。
    - 我们需要打开第 0, 1, 2 号开关。
    - 它的二进制状态就是：`...00000111`
    - 这个二进制数就是它的“状态码”或“掩码 (mask)”。
2. 对于单词 `"ade"`：
    - 它包含 `a`, `d`, `e`。
    - 我们需要打开第 0, 3, 4 号开关。
    - 它的二进制状态就是：`...00011001`

- 易错点：下列代码因为运算符优先级问题导致错误，要避免这种错误，应该将`+`变成`|`,并且这样也可以省略if条件
```java
public int getMask(String s){  
    int res = 0;  
    int index = 0;  
    while(index < s.length()){  
        char ch = s.charAt(index);  
        if((res & 1<<(ch-'a')) == 0){  
            res = res + 1<<(ch-'a');  
        }  
        index++;  
    }  
    return res;  
}
```
***
```java
public int largestProduct(String[] dict) {  
   int[] dictMask = new int[dict.length];  
   for(int i=0;i<dict.length;i++){  
       dictMask[i] = getMask(dict[i]);  
   }  
   int globalMax = 0;  
   for(int i=0;i<dict.length-1;i++){  
       for(int j=i+1; j<dict.length; j++){  
           if ((dictMask[i] & dictMask[j]) == 0){  
               globalMax = Math.max(globalMax,dict[i].length()*dict[j].length());  
           }  
       }  
   }  
   return globalMax;  
}  
public int getMask(String s){  
    int mask = 0;  
    for (int i = 0; i < s.length(); i++) {  
        mask |= (1 << (s.charAt(i) - 'a'));  
    }  
    return mask;  
}
```
***
