---
layout: default
title: BSTInsert
narrow: true
---
Insert a key in a binary search tree if the binary search tree does not already contain the key. Return the root of the binary search tree.

**Assumptions**
- There are no duplicate keys in the binary search tree
- If the key is already existed in the binary search tree, you do not need to do anything

***
```java
  public TreeNode insert(TreeNode root, int key) {
    if (root == null){
      return new TreeNode(key);
    }
    if (root.key == key){
      return root;
    }
    if (root.key < key){
      root.right = insert(root.right,key);
    }
    if (root.key > key){
      root.left = insert(root.left,key);
    }
    return root;
  }
```