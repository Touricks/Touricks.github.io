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

- 例题：[WordSearchII](/algorithmn-notes/wordsearchii.html)
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

---

### Search

1. 从根节点 `root` 开始，令当前节点 `current = root`。
2. 遍历要搜索单词的每一个字符 `ch`: a. 检查 `current.children` 是否包含字符 `ch` 作为键。 b. **如果不存在**: 说明 Trie 树中没有以当前路径开头的这个字符，因此单词不存在。返回 `false`。 c. **如果存在**: `current = current.children.get(ch)`。
3. 当单词的所有字符都成功匹配并遍历完毕后，检查当前节点 `current`： a. 返回 `current.isWord`。如果为 `
