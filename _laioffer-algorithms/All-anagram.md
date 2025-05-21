---
layout: default
title: All anagram
narrow: true
---

https://app.laicode.io/app/problem/398?plan=3
Find all occurrence of anagrams of a given string s in a given string l. Return the list of starting indices.
**Assumptions**

- sh is not null or empty.
- lo is not null.
  **Examples**
- l = "abcbac", s = "ab", return [0, 3] since the substring with length 2 starting from index 0/3 are all anagrams of "ab" ("ab", "ba").

---

- 维护一个 sliding window, `[slow,fast)`表示当前窗口下还有多少字符没有匹配
- 考虑 fast 时：
  - 要移除 slow 处的字符 -> 先处理
  - 再处理加入 fast 处的字符
  - 更新答案
- 细节 1：target 和 origin 的长度关系
- 细节 2：离开字符的计数必须保证在进入字符的计数前，才能忽略不在 target 中元素的同时保证正确性

```java
public List<Integer> allAnagrams(String target, String origin) {
    List<Integer> res = new ArrayList<>();
    if (origin == null || origin.length() == 0 || origin.length() < target.length()){
        return res;
    }
    HashMap<Character,Integer> lookup = new HashMap<>();
    for(int i=0;i<target.length();i++){
        lookup.put(target.charAt(i),lookup.getOrDefault(target.charAt(i),0)+1);
    }
    int len = target.length();
    int leftUnmatched = lookup.size();
    for(int i=0;i<len;i++) {
        if (lookup.containsKey(origin.charAt(i))) {
            if (lookup.get(origin.charAt(i)) == 1) {
                leftUnmatched--;
            }
            lookup.put(origin.charAt(i), lookup.get(origin.charAt(i)) - 1);
        }
    }
    if (leftUnmatched == 0){
        res.add(0);
    }
    for(int i=1;i<=origin.length()-len;i++){
        int indexToBeAdd = i+target.length()-1;
        int indexToBeDrop = i-1;
        if (lookup.containsKey(origin.charAt(indexToBeDrop))){
            if (lookup.get(origin.charAt(indexToBeDrop)) == 0){
                leftUnmatched++;
            }
            lookup.put(origin.charAt(indexToBeDrop),lookup.get(origin.charAt(indexToBeDrop))+1);
        }
        if (lookup.containsKey(origin.charAt(indexToBeAdd))){
            if (lookup.get(origin.charAt(indexToBeAdd)) == 1){
                leftUnmatched--;
            }
            lookup.put(origin.charAt(indexToBeAdd),lookup.get(origin.charAt(indexToBeAdd))-1);
        }
        if (leftUnmatched == 0){
            res.add(i);
        }
    }
    return res;
}
```
