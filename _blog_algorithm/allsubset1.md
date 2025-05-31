---
layout: default
title: AllSubset1
narrow: true
---
https://app.laicode.io/app/problem/62?plan=3
Given a set of characters represented by a String, return a list containing all subsets of the characters.

**Assumptions**

- There are no duplicate characters in the original set.

​**Examples**

- Set = "abc", all the subsets are [“”, “a”, “ab”, “abc”, “ac”, “b”, “bc”, “c”]
- Set = "", all the subsets are [""]
- Set = null, all the subsets are []
***
- 考虑当前元素
	- 层数：input中字符串的长度
	- 分支：当前位置的字符加或不加
	- base case：index = length时收集结果
```
[root]
|      \   
[a]    [] 
|   \  
[ab] [a] 
|   \
[abc] [ab]

```
```java
public List<String> subSets(String set) {  
    StringBuilder sb = new StringBuilder();  
    List<String> res = new ArrayList<>();  
    if (set == null) return res;  
    dfs(set,0,sb,res);  
    return res;  
}  
public void dfs(String set, int index, StringBuilder sb, List<String> res){  
    if (index == set.length()){  
        res.add(sb.toString());  
        return;  
    }  
    sb.append(set.charAt(index));  
    dfs(set,index+1,sb,res);  
    sb.deleteCharAt(sb.length()-1);  
    dfs(set,index+1,sb,res);  
}
```


- 考虑当前位置
	- 层数：字符串长度
	- 分支：当前位置选择哪个字符，但选择完字符后下一轮的字符必须在该字符后面
	- base case：index=length时收集结果
```
[root]
|      \    \    \
[a]    [b]   [c]  []
|  \  \ 
[b] [c] []
|  \
[c] []
|
[]
```
```java
public List<String> subSets(String set) {  
    StringBuilder sb = new StringBuilder();  
    List<String> res = new ArrayList<>();  
    if (set == null) return res;  
    dfs(set,0,sb,res);  
    return res;  
}  
public void dfs(String set, int index, StringBuilder sb, List<String> res){  
    if (index == set.length()){  
        res.add(sb.toString());  
        return;  
    }  
    for(int opt = index; opt<=set.length();opt++){  
        if (opt == set.length()){  
            dfs(set,opt,sb,res);  
            continue;  
        }  
        sb.append(set.charAt(opt));  
        dfs(set,opt+1,sb,res);  
        sb.deleteCharAt(sb.length()-1);  
    }  
}
```