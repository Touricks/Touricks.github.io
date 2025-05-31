---
layout: default
title: Maximum-Path-Sum-II
narrow: true
---
https://app.laicode.io/app/problem/139?plan=3
Given a binary tree in which each node contains an integer number. Find the maximum possible sum **from any node to any node (the start node and the end node can be the same).** 

**Assumptions**

- ​The root of the given binary tree is not null

**Examples**

   -1

  /    \

2      11

     /    \

    6    -14

one example of paths could be -14 -> 11 -> -1 -> 2

another example could be the node 11 itself

The maximum path sum in the above binary tree is 6 + 11 + (-1) + 2 = 18

**How is the binary tree represented?**

We use the level order traversal sequence with a special symbol "#" denoting the null node.
***
- Step1：Function定义
```
int recursion(root,max)
```
- 给我一个root，我能返回从root出发到anynode的直上直下path的最大值

- Step2： Base Case
	- root is null return 0
	- root is leaf (root.left, root.right is null)
	
- Step3: Subproblem
	- root.left recursion(root.left,max)
		- 给我root.left 我能返回从root.left出发到 anyNode 的maxPathSum
	- root.right recursion(root.right,max)
		- 给我root.right 我能返回从root.right出发到 anyNode 的maxPathSum
		
- Step4: Recursion Rule
	- 要么是 人字形组合 的结果：left+自己+right
	- 要么是 直上直下 的结果：自己+left or 自己+right
	- 要么东山再起： 自己