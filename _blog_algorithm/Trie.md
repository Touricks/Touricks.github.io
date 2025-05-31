---
layout: default
title: Trie
narrow: true
---

## 综述

- 单词结构

```java
public class TrieNode {
    Map<Character, TrieNode> children;
    boolean isWord;
    int count;
    public TrieNode() {
        children = new HashMap<>();
        isWord = false;
        count = 0;
    }
}
```

- 假设我们有一个 Trie 树的根节点 `TrieNode root = new TrieNode();`

- 例题：[WordSearchII](/algorithmnotes/wordsearchii.html)
  - 给定一个字典和一个棋盘，找出哪些单词可以在棋盘中找到

### Insert

1. 从根节点 `root` 开始，令当前节点 `current = root`。
2. 遍历要插入单词的每一个字符 `ch`: a. 检查 `current.children` 是否包含字符 `ch` 作为键。 b. **如果不存在**: 创建一个新的 `TrieNode` (`newNode = new TrieNode()`)，然后将它以 `(ch, newNode)` 的形式放入 `current.children` Map 中。 c. 将当前节点更新为其子节点：`current = current.children.get(ch)`。 d. **(可选，根据 `count` 的用途)**: 如果 `count` 表示前缀计数，则增加 `current.count`。
3. 当单词的所有字符都处理完毕后，当前节点 `current` 代表单词的最后一个字符。 a. 设置 `current.isWord = true`，表示这是一个单词的结尾。 b. **(可选，根据 `count` 和 `value` 的用途)**: _ 如果 `count` 用于记录单词结束的频率，则增加 `current.count`。 _ 如果需要为该单词关联一个值，设置 `current.value = a_specific_value`。

- **示例**: 插入 "cat"

1. `current = root`
2. 字符 'c': `root.children` 中没有 'c'。创建 `node_c`，`root.children.put('c', node_c)`。`current = node_c`。`node_c.count++` (如果 count 是前缀计数)。
3. 字符 'a': `node_c.children` 中没有 'a'。创建 `node_a`，`node_c.children.put('a', node_a)`。`current = node_a`。`node_a.count++`。
4. 字符 't': `node_a.children` 中没有 't'。创建 `node_t`，`node_a.children.put('t', node_t)`。`current = node_t`。`node_t.count++`。
5. "cat" 结束。设置 `node_t.isWord = true`。如果 "cat" 有值，`node_t.value = a_value`。

- 易错点：count 的意义是有多少个单词以当前节点代表的字符串为前缀。因此，`count` 应该在 `cur` 移动到 `next` _之后_，对 `next` (即 `cur` 更新后的值) 进行递增。小心位置。
- 另外，空字符串也是单词，空字符串不能被列为 cornercase 从而直接返回 true

```java
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
```
***
### Search
1. 从根节点 `root` 开始，令当前节点 `current = root`。
2. 遍历要搜索单词的每一个字符 `ch`: a. 检查 `current.children` 是否包含字符 `ch` 作为键。 b. **如果不存在**: 说明Trie树中没有以当前路径开头的这个字符，因此单词不存在。返回 `false`。 c. **如果存在**: `current = current.children.get(ch)`。
3. 当单词的所有字符都成功匹配并遍历完毕后，检查当前节点 `current`： a. 返回 `current.isWord`。如果为 `true`，则单词存在；否则，该路径只是一个前缀，而不是一个完整的单词。 b. 如果要获取与单词关联的 `value`，并且 `current.isWord` 为 `true`，则可以返回 `current.value`。
- **搜索前缀 (StartsWith)**: 如果是搜索前缀，步骤与搜索单词类似，但在遍历完前缀的所有字符后，如果都能找到对应的路径，则前缀存在，直接返回 `true`，无需检查 `current.isWord`。
```java
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
```
### Delete
-  删除操作通常通过递归实现，从叶节点向根节点方向清理。 假设有一个递归辅助函数 `deleteHelper(TrieNode current, String word, int index)`:

1. **基本情况1 (节点不存在)**: 如果 `current` 为 `null`，说明路径中断，单词不可能存在，返回 `false` (表示此路径上的父节点不需要删除其对当前节点的引用)。
2. **基本情况2 (到达单词末尾)**: 如果 `index == word.length()` (即已处理完单词的所有字符): 
	1. 如果 `current.isWord` 为 `false`，说明这个路径本身不代表一个单词的结尾（或者单词已被删除），返回 `false`。 
	2. 若 `current.isWord` 为`true`，则设置为 `false`，表示这个单词不再被标记。
	3. 如果 `count` 记录单词结束频率，则 `current.count--`。如果 `count` 降为0，那么这个节点可以被物理删除。返回 `true` 通知其父节点进行删除。否则返回 `false`。

- 易错点：
	- 必须在开始删除前检测该单词是否存在，否则会造成count这个field逻辑混乱，在继续删除其他单词时出现错误
	- 当next.count等于1时，我们要return而不是break。因为break会造成cur.isWord继续运行，但这不是我们想要的结果，也会对后续的search/insert逻辑造成影响
```java
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
```