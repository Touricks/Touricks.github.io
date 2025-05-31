---
layout: default
title: BinaryTreePathSumMAX
narrow: true
---
https://app.laicode.io/app/problem/140

Given a binary tree in which each node contains an integer number. Find the maximum possible subpath sum**(both the starting and ending node of the subpath should be on the same path from root to one of the leaf nodes, and the subpath is allowed to contain only one node).**

**Assumptions**

- The root of given binary tree is not null

**Examples**

   -5

  /    \

2      11

     /    \

    6     14

           /

        -3

The maximum path sum is 11 + 14 = 25

**How is the binary tree represented?**

We use the level order traversal sequence with a special symbol "#" denoting the null node.
***
- 首先，这题 bottom up 和 top down 都可以
- 我们尝试 top down
***
- Signature：`dfs(TreeNode root, int prev)` prev到目前root的路径最大值是多少
- Base Case: root=Root -> prev = 0; root=null -> return
- DFS rule: update globalMax if root.key + MAX(prev,0) > globalMax
- Expand: dfs(root.left, max(prev,0)+root.key); dfs(root.right, max(prev,0)+root.key)