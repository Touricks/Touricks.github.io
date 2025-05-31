---
layout: default
title: (Bottomup)
narrow: true
---
- 对于自底而上的树上DFS题目分两种：==人字形Path和直上直下型Path==
	- 人字形：一定在这个path上存在从某一点左边进，右边出
	- 直上直下：不发生上述情况

- Tree Path:
	- 题目求的是什么，题目允许人字形吗？
	- 是必须人字形？还是必须直上直下？还是都行？ 

- ==不管题目求的是什么，我们recursion里定义的一定return的是直上直下的定义==
- 原因：
	- 父节点需要拿到“可以再往上接”的信息；只有单链满足这一点。
	- 从子树上拿到了两个直上直下Path的结果可以组合出人字形Path的结果
	- 例如：Longest Univalue Path
		- 请找出**树中最长的一条路径**，要求路径上所有结点的值完全相同
	- 例如：Longest Consecutive Increasing Path
		- 找出 **最长的连续递增路径**，要求路径上的相邻两个结点 `(parent, child)`，必须满足 `child.val = parent.val + 1`
- 例题	

[Maximum Path Sum](/algorithmnotes/Maximum Path Sum.html)
- 叶节点到叶节点,更好的做法是用MIN_VALUE标记不存在的节点，因为负数的存在会使赋值0失去原有的意义（排除该节点的作用）

[Maximum Path Sum II](/algorithmnotes/Maximum Path Sum II.html)
- 任意节点到任意节点

[Longest Univalue Path](/algorithmnotes/Longest Univalue Path.html)
- 任意节点到任意节点，要求值相同

[Longest Incresing Path](/algorithmnotes/Longest Incresing Path.html)
- 直上直下的一条路径，要求相差为1且从根到子树递增

[Longest consecutive PathII](/algorithmnotes/Longest consecutive PathII.html)
- 最长连续序列(值相差为1)路径的长度，路径起点跟终点可以为二叉树的任意节点