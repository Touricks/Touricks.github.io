---
layout: default
title: All Subset3
narrow: true
---

https://app.laicode.io/app/problem/63?plan=3
Given a set of characters represented by a String, return a list containing all subsets of the characters. Notice that each subset returned will be sorted to remove the sequence.

**Assumptions**

- There could be duplicate characters in the original set.

​**Examples**

- Set = "abc", all the subsets are ["", "a", "ab", "abc", "ac", "b", "bc", "c"]
- Set = "abb", all the subsets are ["", "a", "ab", "abb", "b", "bb"]
- Set = "abab", all the subsets are ["", "a", "aa","aab", "aabb", "ab","abb","b", "bb"]

- Set = "", all the subsets are [""]
- Set = null, all the subsets are []

---

Combination 问题

- 假设数组已经排序
  Signature： dfs(index，sb) 表示考虑到 set 的第 index 个元素，此时 subset 是 sb
  Base Case: index == len, 加入解集
  level：i<len，表示考虑第 i 个字符是否加入解集
  分支：如果加入，则考虑后一个字符
  如果不加入，则后面相同字符都不考虑

```
public List<String> subSets(String set) {
    List<String> res = new ArrayList<>();
    if (set == null){
        return res;
    }
    char[] arr = new char[set.length()];
    for(int i=0;i<set.length();i++){
        arr[i] = set.charAt(i);
    }
    Arrays.sort(arr);
    StringBuilder sb = new StringBuilder();
    dfs(arr,arr.length,0,res,sb);
    return res;
}
public void dfs(char[] arr, int len, int index, List<String> res, StringBuilder sb){
    if (len == index){
        res.add(sb.toString());
        return;
    }
    sb.append(arr[index]);
    dfs(arr,len,index+1,res,sb);
    sb.deleteCharAt(sb.length()-1);
    while(index+1 < len && arr[index+1] == arr[index]){
        index++;
    }
    dfs(arr,len,index+1,res,sb);
}
```

- 思考：考虑硬币组合问题，我们如果提前统计了每个元素的出现频率，可不可以从 0 开始构造解？
- 构造`HashMap<Character,Integer>`表示 string 中有 size()个不重复的元素，个数为 value
- Signature： dfs(index，sb) 表示考虑到 hashset 的第 index 种元素，取值范围为`[0,value]`
- Base Case: index == size(), 加入解集
- level：i<size()，表示考虑第 i 个字符
- 分支：value()+1 种，表示数量

- 易错点
  - 如果使用 TreeMap 来提取字符的话，我们需要每轮在 poll 完后再 put 进去
  - 不仅解需要吐，dfs 途中改变的所有辅助数据结构都需要恢复

```java
public List<String> subSets(String set) {
    List<String> res = new ArrayList<>();
    if (set == null){
        return res;
    }
    TreeMap<Character, Integer> map = new TreeMap<>();
    for(int i=0;i<set.length();i++){
        map.put(set.charAt(i),map.getOrDefault(set.charAt(i),0)+1);
    }
    StringBuilder sb = new StringBuilder();
    dfs(map,map.size(),0,res,sb);
    return res;
}
public void dfs(TreeMap<Character,Integer> map, int len, int index, List<String> res, StringBuilder sb){
    if (index == len){
        res.add(sb.toString());
        return;
    }
    Map.Entry<Character,Integer> cur = map.pollFirstEntry();
    dfs(map,len,index+1,res,sb);
    for(int i=0;i<cur.getValue();i++){
        sb.append(cur.getKey());
        dfs(map,len,index+1,res,sb);
    }
    sb.delete(sb.length()-cur.getValue(),sb.length());
    map.put(cur.getKey(),cur.getValue());
}
```
