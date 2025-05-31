---
layout: default
title: All Permutations3
narrow: true
---

https://app.laicode.io/app/problem/643?plan=3
Given a string with no duplicate characters, return a list with all permutations of the string and all its subsets.

Examples

Set = “abc”, all permutations are [“”, “a”, “ab”, “abc”, “ac”, “acb”, “b”, “ba”, “bac”, “bc”, “bca”, “c”, “cb”, “cba”, “ca”, “cab”].

Set = “”, all permutations are [“”].

Set = null, all permutations are [].

---

Permutation 问题，
我们发现把 All Permutations2 swapswap 时的前 index 个元素取出来，就能得到结果
只差一行

```java
public List<String> allPermutationsOfSubsets(String input) {
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
    String cand = sb.substring(0,index);
    res.add(cand);
    if (index == sb.length()){
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
