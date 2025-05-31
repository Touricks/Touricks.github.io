---
layout: default
title: WordLadder
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
We apply BFS, queue to solve this problem
Data structure we need:
1. `Queue<String>`, collect the string state to be explore
2. `HashMap<String,Integer>` collect the operation we need to reach specific string
Algorithm step:
- S1: Base case: we put beginWord as the first state, add to the queue and put (beginWord,0) to hashMap
- S2: Generate: for each state in queue, we find all its neighbour(change one letter and see if this words exists in dictionary && doesn't appear in hashset), add available option to queue and hashMap
- S3: Terminate: if we find endWord, return this step we need. Otherwise return -1 if queue is empty

```java
public int ladderLength(String beginWord, String endWord, List<String> wordList) {  
    Queue<String> queue = new LinkedList<>();  
    HashMap<String, Integer> map = new HashMap<>();  
    HashSet<String> dictionary = new HashSet<>();  
    for(String x: wordList){  
        dictionary.add(x);  
    }  
    if (beginWord.equals(endWord)){  
        return 1;  
    }  
    queue.offer(beginWord);  
    map.put(beginWord,1);  
    while(!queue.isEmpty()){  
        String cur = queue.poll();  
        int count = map.get(cur);  
        List<String> availableNeighbour = findPossibleNeighbour(cur,dictionary);  
        for(String next:availableNeighbour){  
            if (!map.containsKey(next)){  
                if (next.equals(endWord)){  
                    return count+1;  
                }  
                queue.offer(next);  
                map.put(next,count+1);  
            }  
        }  
    }  
    return 0;  
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