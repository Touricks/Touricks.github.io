---
layout: default
title: Cousin in Binary Tree
narrow: true
---

Given a binary Tree and the two keys, determine whether the two nodes are cousins of each other or not. Two nodes are cousins of each other if they are at the same level and have different parents.

**Assumptions:**

- It is not guranteed the two keys are all in the binary tree.
- There are no duplicate keys in the binary tree.

**Examples:**
     6  
   /   \  
  3     5  
 / \   / \
7   8 1   13  
7 and 1, result is true.  
3 and 5, result is false.  
7 and 5, result is false.

---

Step1：Data Structure：使用 Queue 记录当前层和下层的节点，由于节点不重复，使用 Integer 表示对应的节点
Step2：Initial State：第一层的元素，如果树为空则返回 false
Step3：每一轮 Expand（queue.pop()）的意义是什么：取出当前层树上的节点
Step4：Generate 的条件是什么？如何 Generate？将下一层的节点加入 queue
Step5：Termination Condition 是什么
如果在同一层找到两个数，则提前返回 true
**如果找到的节点的父亲是同一个，则不算 cousin**
Step6：Deduplication 策略是什么？在入队前置 visited=true 是否可行
不需要维护 dedup

```java
class Pair {
    public final TreeNode x;
    public final TreeNode y;
    public Pair(TreeNode x, TreeNode y) {
        this.x = x;
        this.y = y;
    }
}

public class Solution {
      public boolean isCousin(TreeNode root, int a, int b) {
        if (root == null) return false;
        Deque<Pair> inQueue = new LinkedList<>();
        inQueue.addLast(new Pair(root, null));
        while(!inQueue.isEmpty()){
            int size = inQueue.size();
            boolean foundA = false;
            boolean foundB = false;
            TreeNode parentA = null;
            TreeNode parentB = null;
            for (int i = 0; i < size; i++) {
                Pair cur = inQueue.pollFirst();
                TreeNode curNode = cur.x;
                TreeNode parent = cur.y;
                if (curNode.key == a) {
                    foundA = true;
                    parentA = parent;
                }
                if (curNode.key == b) {
                    foundB = true;
                    parentB = parent;
                }
                if (curNode.left != null) {
                    inQueue.addLast(new Pair(curNode.left, curNode));
                }
                if (curNode.right != null) {
                    inQueue.addLast(new Pair(curNode.right, curNode));
                }
            }
            if (foundA && foundB && (!parentA.equals(parentB))) return true;
        }
        return false;
    }
```
