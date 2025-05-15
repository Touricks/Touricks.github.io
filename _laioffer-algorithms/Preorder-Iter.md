---
layout: default
title: Preorder(Iter)
narrow: true
---

Implement an iterative, pre-order traversal of a given binary tree, return the list of keys of each node in the tree as it is pre-order traversed.

**Examples**

     5

/ \

3 8

/ \ \

1 4 11

Pre-order traversal is [5, 3, 1, 4, 8, 11]

**Corner Cases**

- What if the given binary tree is null? Return an empty list in this case.

**How is the binary tree represented?**

We use the level order traversal sequence with a special symbol "#" denoting the null node.

**For Example:**

The sequence [1, 2, 3, #, #, 4] represents the following binary tree:

1

/ \

2 3

     /

4

---

- 我们使用 stack 来存待遍历的元素
- 由于只要元素拥有 left child 就要一直向右走，

```java
public List<Integer> preOrder(TreeNode root) {
    Deque<TreeNode> stack = new LinkedList<>();
    List<Integer> res = new ArrayList<>();
    if (root == null){
      return res;
    }
    stack.push(root);
    while(!stack.isEmpty()){
      TreeNode cur = stack.pop();
      res.add(cur.key);
      if (cur.right != null){
        stack.push(cur.right);
      }
      if (cur.left != null){
        stack.push(cur.left);
      }
    }
    return res;
  }
```
