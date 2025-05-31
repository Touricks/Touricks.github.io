---
layout: default
title: All-Permutations2
narrow: true
---
Given a string with possible duplicate characters, return a list with all permutations of the characters.

**Examples**

- Set = “abc”, all permutations are [“abc”, “acb”, “bac”, “bca”, “cab”, “cba”]
- Set = "aba", all permutations are ["aab", "aba", "baa"]
- Set = "", all permutations are [""]
- Set = null, all permutations are []
***
- Permutation问题：考虑每个位置
- Signature: dfs(index) 表示考虑第index位置的元素加什么
- Base Case： index == len, 加入解集
- level：index：表示第index个位置的元素
- 分支：`[index,end] && hashmap.contains(index) == false` 
	- 去重，swap过来的元素不能重复

```java
public List<String> permutations(String input) {  
    // Write your solution here  
    List<String> res = new ArrayList<>();  
    if (input == null){  
        return res;  
    }  
    StringBuilder sb = new StringBuilder(input);  
    dfs(0,sb,res);  
    return res;  
}  
  
public void dfs(int index, StringBuilder sb, List<String> res){  
    if (index == sb.length()){  
        res.add(sb.toString());  
        return;  
    }  
    HashSet<Character> lookup = new HashSet<>();  
    for(int i = index; i<sb.length();i++){  
        if (!lookup.contains(sb.charAt(i))){  
            lookup.add(sb.charAt(i));  
            swap(sb,index,i);  
            dfs(index+1,sb,res);  
            swap(sb,index,i);  
        }  
    }  
}  
public void swap(StringBuilder sb, int i, int j){  
    char temp = sb.charAt(i);  
    sb.setCharAt(i,sb.charAt(j));  
    sb.setCharAt(j, temp);  
}
```