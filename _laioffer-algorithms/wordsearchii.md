---
layout: default
title: WordSearchII
narrow: true
---
Given a 2D board and a list of words from the dictionary, find all words in the board.

Each word must be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

For example,  
Given words = `["oath","pea","eat","rain"]` and board =

[
  ['o','a','a','n'],
  ['e','t','a','e'],
  ['i','h','k','r'],
  ['i','f','l','v']
]

Return `["eat","oath"]`.
***
- 易错点：在将第一个字母加入stringBuilder时，对应位置的visited就应该设为true
```java
package Trie;  
  
public class Trie {  
    public Trie(){};  
    public TrieNode root = new TrieNode();  
    public boolean insert(String s){  
        TrieNode cur = root;  
        if (s == null){  
            return true;  
        }  
        for(int i=0;i<s.length();i++){  
            if (cur.children.containsKey(s.charAt(i))){  
                TrieNode next = cur.children.get(s.charAt(i));  
                cur = next;  
                cur.count++;  
            }else{  
                TrieNode next = new TrieNode();  
                cur.children.put(s.charAt(i),next);  
                cur = next;  
                cur.count++;  
            }  
        }  
        if (cur.isWord){  
            return false;  
        }else{  
            cur.isWord = true;  
            return true;  
        }  
    }  
  
    public boolean search(String s){  
        TrieNode cur = root;  
        for(int i=0;i<s.length();i++){  
            if (!cur.children.containsKey(s.charAt(i))){  
                return false;  
            }else{  
                TrieNode next = cur.children.get(s.charAt(i));  
                cur = next;  
            }  
        }  
        return cur.isWord;  
    }  
  
    public void delete(String s){  
        if (!search(s)){  
            return;  
        }  
        TrieNode cur = root;  
        for(int i=0;i<s.length();i++){  
            TrieNode next = cur.children.get(s.charAt(i));  
            if (next == null) return;  
            if (next.count == 1){  
                cur.children.remove(s.charAt(i));  
                return;  
            }else{  
                cur = next;  
                cur.count--;  
            }  
        }  
        cur.isWord = false;  
    }  
}
```