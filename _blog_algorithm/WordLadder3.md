---
layout: default
title: WordLadder3
narrow: true
---
https://leetcode.com/problems/word-ladder-ii/submissions/1644482415/

A **transformation sequence** from word `beginWord` to word `endWord` using a dictionary `wordList` is a sequence of words `beginWord -> s1 -> s2 -> ... -> sk` such that:

- Every adjacent pair of words differs by a single letter.
- Every `si` for `1 <= i <= k` is in `wordList`. Note that `beginWord` does not need to be in `wordList`.
- `sk == endWord`

Given two words, `beginWord` and `endWord`, and a dictionary `wordList`, return _all the **shortest transformation sequences** from_ `beginWord` _to_ `endWord`_, or an empty list if no such sequence exists. Each sequence should be returned as a list of the words_ `[beginWord, s1, s2, ..., sk]`.

**Example 1:**

**Input:** beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
**Output:** [["hit","hot","dot","dog","cog"],["hit","hot","lot","log","cog"]]
**Explanation:** There are 2 shortest transformation sequences:
"hit" -> "hot" -> "dot" -> "dog" -> "cog"
"hit" -> "hot" -> "lot" -> "log" -> "cog"

***
解析见BFS页面
```java
public List<List<String>> findLadders(String beginWord, String endWord, List<String> wordList) {  
    Queue<String> queue = new LinkedList<>();  
    HashMap<String, List<String>> prev = new HashMap<>();  
    HashMap<String, Integer> dist = new HashMap<>();  
    HashSet<String> dictionary = new HashSet<>();  
    for(String x: wordList){  
        dictionary.add(x);  
    }  
    queue.offer(beginWord);  
    prev.put(beginWord,new ArrayList<>());  
    dist.put(beginWord,1);  
    int flag = 0;  
    while(!queue.isEmpty()) {  
        int size = queue.size();  
        for (int i = 0; i < size; i++) {  
            String cur = queue.poll();  
            int distToCur = dist.get(cur);  
            List<String> nei = findPossibleNeighbour(cur,dictionary);  
            for(String next:nei){  
                if (next.equals(endWord)){  
                    flag = 1;  
                }  
                if (dist.containsKey(next)){  
                    if (dist.get(next) == distToCur+1){  
                        List<String> pre = prev.get(next);  
                        pre.add(cur);  
                    }  
                }else{  
                    dist.put(next,distToCur+1);  
                    List<String> pre = new ArrayList<>();  
                    pre.add(cur);  
                    prev.put(next,pre);  
                    queue.offer(next);  
                }  
            }  
        }  
        if (flag == 1){  
            break;  
        }  
    }  
    // now we have prev  
    List<List<String>> res = new ArrayList<>();  
    if (flag == 0){  
        return res;  
    }  
    Trace(endWord, new ArrayList<>(),res,prev,beginWord);  
    return res;  
}  
public void Trace(String curWord, List<String> curPath, List<List<String>> res,  
                                HashMap<String,List<String>> pre, String start){  
    curPath.add(curWord);  
    if (curWord.equals(start)){  
        res.add(new ArrayList<>(curPath.reversed()));  
        curPath.remove(curPath.size()-1);  
        return;  
    }  
    List<String> prev = pre.get(curWord);  
    for(String last: prev){  
        Trace(last,curPath,res,pre,start);  
    }  
    curPath.remove(curPath.size()-1);  
  
}  
public List<String> findPossibleNeighbour(String cur, HashSet<String> wordset){  
    char[] charr = cur.toCharArray();  
    List<String> res = new ArrayList<>();  
    for(int i=0;i<charr.length;i++){  
        char temp = charr[i];  
        for(int j=0;j<26;j++){  
            charr[i] = (char)('a'+j);  
            String cand = new String(charr);  
            if (wordset.contains(cand)){  
                res.add(cand);  
            }  
        }  
        charr[i] = temp;  
    }  
    return res;  
}
```