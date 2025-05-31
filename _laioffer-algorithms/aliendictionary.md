---
layout: default
title: AlienDictionary
narrow: true
---
There is a new alien language which uses the latin alphabet. However, the order among letters are unknown to you. You receive a list of non-empty words from the dictionary, where words are sorted lexicographically by the rules of this new language. Derive the order of letters in this language.

Example 1:  
Given the following words in dictionary,

[
  "wrt",
  "wrf",
  "er",
  "ett",
  "rftt"
]
The correct order is: `"wertf"`.

Example 2:  
Given the following words in dictionary,

[
  "z",
  "x"
]
The correct order is: `"zx"`.

Example 3:  
Given the following words in dictionary,

[
  "z",
  "x",
  "z"
]
The order is invalid, so return `""`.
***
-  Data structure we need:
```
Map<Character, Set<Character>> edges
Map<Character, Integer> indegree
Queue<Character> topoSortQueue
StringBuilder result recorded
```
- 易错点：
	- 首先，我们要明确indegree代表点集，edges代表边集，虽然edges以点为key表示边集Set，但仍然存在大量不会进入拓扑排序，合法的点。
		- 我们不能在加入边集的时候"顺带"将边所在的两点加入点集，这样会造成漏解。我们需要在一开始就将所有点入队，防止**孤立的节点和没有入/出度的节点**被忽略
	- 其次，我们要谨防**重复计算入度**的问题
		- 思考这个例子：`words = ["za", "zb", "ca", "cb"]`
		- 1. 比较 `"za"` 和 `"zb"`，发现 `a -> b`。此时 `b` 的入度变为 **1**。
		- 2. 比较 `"ca"` 和 `"cb"`，再次发现 `a -> b`
		- 如果无条件进行加边操作，会使得同一条边计算了两次，导致后续拓扑失败
		- 修复方法：使用`set.add`操作，有两个优势
			- 可以判断是否有重复节点，有则不会重复入Set
			- 如果有重复节点，add会返回false，可以以此判断不需要让对应入度+1
	- 最后：break存在与时机
		- 发现有单词不同后，无论一条边最终有没有加上，我们都需要break，因此后续比较不再有意义
```java
public String alienOrder(String[] words) {  
    Map<Character, Set<Character>> edges = new HashMap<>();  
    Map<Character, Integer> inDegree = new HashMap<>();  
    Queue<Character> topoQueue = new LinkedList<>();  
    StringBuilder res = new StringBuilder();  
    for(int i=0;i<words.length;i++){  
        for(int pos=0;pos<words[i].length();pos++){  
            edges.putIfAbsent(words[i].charAt(pos),new HashSet<>());  
            inDegree.putIfAbsent(words[i].charAt(pos),0);  
        }  
    }  
    for(int i=0;i<words.length-1;i++) {  
        if (words[i] == null || words[i].length() == 0) {  
            continue;  
        }  
        if (words[i].length() > words[i + 1].length() && words[i].startsWith(words[i + 1])) {  
            return "";  
        }  
        for (int pos = 0; pos < words[i].length(); pos++) {  
            if (words[i].charAt(pos) != words[i + 1].charAt(pos)) {  
                Set<Character> neighbour = edges.get(words[i].charAt(pos));  
                if (neighbour.add(words[i + 1].charAt(pos))){  
                    int inDeg = inDegree.get(words[i + 1].charAt(pos));  
                    inDegree.put(words[i + 1].charAt(pos), inDeg + 1);  
                }  
                break;  
            }  
        }  
    }  
    for (Map.Entry<Character, Integer> entry : inDegree.entrySet()) {  
        if (entry.getValue() == 0) {  
            topoQueue.offer(entry.getKey());  
        }  
    }  
    while(!topoQueue.isEmpty()){  
        Character curChar = topoQueue.poll();  
        res.append(curChar);  
        Set<Character> next = edges.get(curChar);  
        for(Character ch: next){  
            int deg = inDegree.get(ch);  
            inDegree.put(ch,deg-1);  
            if (inDegree.get(ch) == 0){  
                topoQueue.add(ch);  
            }  
        }  
    }  
    if (res.length() != inDegree.size()){  
        return "";  
    }  
    return res.toString();  
}
```