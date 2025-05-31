---
layout: default
title: Reconstruct-Binary-Tree-With-Level-Order
narrow: true
---
Given the levelorder and inorder traversal sequence of a binary tree, reconstruct the original tree.

**Assumptions**

- The given sequences are not null and they have the same length
- There are no duplicate keys in the binary tree

**Examples**

levelorder traversal = {5, 3, 8, 1, 4, 11}

inorder traversal = {1, 3, 4, 5, 8, 11}

the corresponding binary tree is

        5

      /    \

    3        8

  /   \                  \

1      4                   11
***
Recursion
1. Signature
	`TreeNode dfs(int[] inOrder, int[] levelOrder)`
	给出以当前节点为根的子树的inorder和levelorder，返回构建好树的根
2. Base Case
	if inOrder.length 为1，返回该节点
	if inOrder.length 为0，返回null
3. SubProblem
	root = `levelOrder[0]`
	root.left = dfs(inOrder, levelOrder1)
	root.right = dfs(inOrder,levelOrder2)
	由于inorder没有递归性质，但levelOrder有，我们用levelOrder存储当前子树中剩下的节点
	根据该节点在inorder中与root在inorder中位置的大小决定分到左子树还是右子树
4. Recursion Rule
	return root
```java
public TreeNode reconstruct(int[] inOrder, int[] levelOrder) {  
    HashMap<Integer, Integer> inorderMap = new HashMap<>();  
    for(int i=0;i<inOrder.length;i++){  
        inorderMap.put(inOrder[i],i);  
    }  
    List<Integer> initial = new ArrayList<>();  
    for(int i=0;i<levelOrder.length;i++){  
        initial.add(levelOrder[i]);  
    }  
    TreeNode root = dfs(inorderMap, initial);  
    return root;  
}  
public TreeNode dfs(Map<Integer, Integer> inorder, List<Integer> levelorder){  
    if (levelorder.size() == 0){  
        return null;  
    }  
    TreeNode root = new TreeNode(levelorder.get(0));  
    int pos = inorder.get(levelorder.get(0));  
    List<Integer> left = new ArrayList<>();  
    List<Integer> right = new ArrayList<>();  
    for(int i=1;i<levelorder.size();i++){  
        if (inorder.get(levelorder.get(i)) > pos){  
            right.add(levelorder.get(i));  
        }else{  
            left.add(levelorder.get(i));  
        }  
    }  
    root.left = dfs(inorder,left);  
    root.right = dfs(inorder,right);  
    return root;  
}
```