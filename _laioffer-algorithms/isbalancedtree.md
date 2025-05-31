---
layout: default
title: isBalancedTree
narrow: true
---
https://app.laicode.io/app/problem/46

Check if a given binary tree is balanced. A balanced binary tree is one in which the depths of every node’s left and right subtree differ by at most 1.

**Examples**

        5

      /    \

    3        8

  /   \        \

1      4        11

is balanced binary tree,

        5

      /

    3

  /   \

1      4

is not balanced binary tree.
***
- Signature: `int isBanlanced(TreeNode root)` 返回以root为根的子树深度， 
	- 返回-1表示树不是平衡的
- Base Case: root == null -> return 0
- Subproblem: isBanlanced(left), isBanlanced(right)
- Recursive Rule: 
	- if Math.abs(left-right) > 1, 说明这棵树不平衡了，返回-1表示不用再算了
	- if left = -1 || right = -1, 说明你的子树告诉你不用再算了，结果已经出来了
	- 否则return Math.max(left,right)+1