---
layout: default
title: GroupAnagram
narrow: true
---
https://leetcode.com/problems/group-anagrams/description/
```
Given an array of strings `strs`, group the anagrams together. You can return the answer in **any order**.

**Example 1:**

**Input:** strs = ["eat","tea","tan","ate","nat","bat"]

**Output:** [["bat"],["nat","tan"],["ate","eat","tea"]]
```
***
```java
public List<List<String>> groupAnagrams(String[] strs) {  
    HashMap<String, List<String>> map = new HashMap<>();  
    for(String s : strs){  
        char[] charr = s.toCharArray();  
        Arrays.sort(charr);  
        String anagram = new String(charr);  
        if (map.containsKey(anagram)){  
            List<String> anaList = map.get(anagram);  
            anaList.add(s);  
        }else{  
            List<String> anaList = new ArrayList<>();  
            anaList.add(s);  
            map.put(anagram,anaList);  
        }  
    }  
    List<List<String>> res= new ArrayList<>();  
    for(Map.Entry<String,List<String>> entry:map.entrySet()){  
        res.add(entry.getValue());  
    }  
    return res;  
}
```