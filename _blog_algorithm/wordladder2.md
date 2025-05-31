---
layout: default
title: WordLadder2
narrow: true
---
https://app.laicode.io/app/problem/661?plan=3

Given a begin word, an end word and a dictionary, find the least number transformations from begin word to end word, and return the length of the transformation sequence. Return 0 if there is no such transformations.

In each transformation, you can only change one letter, and the word should still in the dictionary after each transformation. 

Assumptions

1. All words have the same length.

2. All words contain only lowercase alphabetic characters.

3. There is no duplicates in the word list.

4.The _beginWord_ and _endWord_ are non-empty and are not the same.

Example: start = "git", end = "hot", dictionary = {"git","hit","hog","hot"}

Output: 3
***
We apply 2dir-BFS
Data structure: qStart,qEnd,mapStart,mapEnd
Algorithms:
- S1: put beginWord in qstart and mark it in mapStart; put endWord in qEnd and mark it in mapEnd
- S2: while 2 queue are not both empty, compare their size; choose the queue with less size to expand
- S3: poll the element in queue with size() times, each time, we find out its possible neighbour and find if we can found it in the other hashMap. If we found, the minimum path can be collected with value equal to map1.get(cur) + map2.get(neigh); If we cannot find, we add neighbour to queue if it appears the first time.
- If we cannot found , return 0
***
```java
public int ladderLength(String beginWord, String endWord, List<String> wordList) {  
    HashSet<String> dictionary = new HashSet<>();  
    for(String x: wordList){  
        dictionary.add(x);  
    }  
    Queue<String> qStart = new LinkedList<>();  
    Queue<String> qEnd = new LinkedList<>();  
    HashMap<String, Integer> mapStart= new HashMap<>();  
    HashMap<String, Integer> mapEnd= new HashMap<>();  
    qStart.offer(beginWord);  
    qEnd.offer(endWord);  
    mapStart.put(beginWord,1);  
    mapEnd.put(endWord,1);  
  
    while(!qStart.isEmpty() && !qEnd.isEmpty()){  
        int goal = 0;  
        if (qStart.size() <= qEnd.size()){  
            goal = bfs(qStart,mapStart,mapEnd,qStart.size(),dictionary);  
        }else{  
            goal = bfs(qEnd,mapEnd,mapStart,qEnd.size(),dictionary);  
        }  
        if (goal != 0){  
            return goal;  
        }  
    }  
    return 0;  
}  
public int bfs(Queue<String> q, HashMap<String, Integer> thisMap, HashMap<String, Integer> otherMap, int size,HashSet<String> wordset){  
    for(int i=0;i<size;i++){  
        String cur = q.poll();  
        List<String> nei = findPossibleNeighbour(cur,wordset);  
        int count = thisMap.get(cur);  
        for(String next:nei){  
            if (otherMap.containsKey(next)){  
                return otherMap.get(next) + count;  
            }  
            if (!thisMap.containsKey(next)){  
                q.offer(next);  
                thisMap.put(next,count+1);  
            }  
        }  
    }  
    return 0;  
}  
public List<String> findPossibleNeighbour(String cur, HashSet<String> wordset){  
    List<String> res = new ArrayList<>();  
    if (cur == null || cur.length() == 0) return res;  
    char[] charr = cur.toCharArray();  
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