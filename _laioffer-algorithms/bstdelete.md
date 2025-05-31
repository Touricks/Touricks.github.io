---
layout: default
title: BSTdelete
narrow: true
---
Delete the target key K in the given binary search tree if the binary search tree contains K. Return the root of the binary search tree.

Find your own way to delete the node from the binary search tree, after deletion the binary search tree's property should be maintained.

**Assumptions**

- There are no duplicate keys in the binary search tree
    The smallest larger node is first candidate after deletion
***

```java
public TreeNode deleteTree(TreeNode root, int key) {
    if (root == null){
      return null;
    }
    if (root.key < key){
      root.right = deleteTree(root.right,key);
      return root;
    }
    if (root.key > key){
      root.left = deleteTree(root.left,key);
      return root;
    }
    // We have found node to be deleted
    if (root.left == null && root.right == null){
      return null;
    }
    if (root.left == null || root.right == null){
      return (root.left == null)? root.right : root.left;
    }
    // Two subtree are both NOT NULL
    if (root.right.left == null){
      root.right.left = root.left;
      return root.right;
    }
    // We try to find the first element in inorder traversal of right subtree
    TreeNode newRoot = findFirstInorderElement(root.right);
    newRoot.right = root.right;
    newRoot.left = root.left;
    return newRoot;
  }
  public TreeNode findFirstInorderElement(TreeNode cur){
    TreeNode pre = null;
    while(cur.left != null){
      pre = cur;
      cur = cur.left;
    }
    pre.left = cur.right;
    return cur;
  }
```