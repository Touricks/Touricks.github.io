---
layout: default
title: All-Subset2
narrow: true
---
https://app.laicode.io/app/problem/640?plan=3
Given a set of characters represented by a String, return a list containing all subsets of the characters whose size is K.

Assumptions

There are no duplicate characters in the original set.

​Examples

Set = "abc", K = 2, all the subsets are [“ab”, “ac”, “bc”].

Set = "", K = 0, all the subsets are [""].

Set = "", K = 1, all the subsets are [].

***
这是一个Combination问题
Signature： dfs(index,curPos) 表示考虑长度为k的subset的第curPos个元素，从index之后的位置取
Base Case：curPos == k, 收集解； index == len但curPos<k 无效解
level：考虑第k个位置取得元素
分支：有len-index+1个选择

```java
public List<String> subSetsOfSizeK(String set, int k) {  
    List<String> res = new ArrayList<>();  
    StringBuilder sb = new StringBuilder();  
    dfs(set,k,0,0,sb,res);  
    return res;  
}  
public void dfs(String set, int k, int index, int curPos, StringBuilder sb, List<String> res){  
    if (curPos == k){  
        res.add(sb.toString());  
        return;  
    }  
    if (set.length()-index < k-curPos){  
        return;  
    }  
    for(int i=index;i<set.length();i++){  
        sb.append(set.charAt(i));  
        dfs(set,k,i+1,curPos+1,sb,res);  
        sb.deleteCharAt(sb.length()-1);  
    }  
}
```