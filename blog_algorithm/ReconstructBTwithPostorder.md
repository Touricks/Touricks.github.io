---
layout: default
title: ReconstructBTwithPostorder
narrow: true
---
https://app.laicode.io/app/problem/214?plan=3

Given the postorder and inorder traversal sequence of a binary tree, reconstruct the original tree.

**Assumptions**

- The given sequences are not null and they have the same length
- There are no duplicate keys in the binary tree

**Examples**

postorder traversal = {1, 4, 3, 11, 8, 5}

inorder traversal = {1, 3, 4, 5, 8, 11}

the corresponding binary tree is

        5

      /    \

    3        8

  /   \               \

1      4               11
***
- 和preorder解法完全一致，在此不再赘述
```java
public TreeNode reconstruct(int[] inOrder, int[] postOrder) {  
    HashMap<Integer, Integer> inorderMap = new HashMap<>();  
    for(int i=0;i<inOrder.length;i++){  
        inorderMap.put(inOrder[i],i);  
    }  
    TreeNode root = dfs(inorderMap, 0, postOrder.length-1, postOrder, 0, postOrder.length-1);  
    return root;  
}  
public TreeNode dfs(HashMap<Integer, Integer> inorder, int inStart, int inEnd, int[] postorder, int start, int end){  
    if (start > end){  
        return null;  
    }  
    TreeNode root = new TreeNode(postorder[end]);  
    int leftTreeSize = inorder.get(postorder[end])-inStart;  
    root.left = dfs(inorder,inStart,inorder.get(postorder[end])-1,postorder,start,start+leftTreeSize-1);  
    root.right = dfs(inorder,inorder.get(postorder[end])+1,inEnd,postorder,start+leftTreeSize,end-1);  
    return root;  
}
```