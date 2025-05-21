---
layout: default
title: Tree Path Problems
narrow: true
---

- 树上 DFS 题目分两种：==人字形 Path 和直上直下型 Path==

  - 人字形：一定在这个 path 上存在从某一点左边进，右边出
  - 直上直下：不发生上述情况

- Tree Path:

  - 题目求的是什么，题目允许人字形吗？
  - 是必须人字形？还是必须直上直下？还是都行？

- ==不管题目求的是什么，我们 recursion 里定义的一定 return 的是直上直下的定义==
- 原因：
  - 父节点需要拿到"可以再往上接"的信息；只有单链满足这一点。
  - 从子树上拿到了两个直上直下 Path 的结果可以组合出人字形 Path 的结果
  - 例如：Longest Univalue Path
    - 请找出**树中最长的一条路径**，要求路径上所有结点的值完全相同
  - 例如：Longest Consecutive Increasing Path
    - 找出 **最长的连续递增路径**，要求路径上的相邻两个结点 `(parent, child)`，必须满足 `child.val = parent.val + 1`
- 例题
  [Maximum Path Sum](/algorithmn-notes/maximum-path-sum.html)
- 叶节点到叶节点,更好的做法是用 MIN_VALUE 标记不存在的节点，因为负数的存在会使赋值 0 失去原有的意义（排除该节点的作用）
  [Maximum Path Sum II](/algorithmn-notes/maximum-path-sum-ii.html)
- 任意节点到任意节点
  [Longest Univalue Path](/algorithmn-notes/longest-univalue-path.html)
- 任意节点到任意节点，要求值相同
  [Longest Incresing Path](/algorithmn-notes/longest-incresing-path.html)
- 直上直下的一条路径，要求相差为 1 且从根到子树递增
  [Longest consecutive PathII](/algorithmn-notes/longest-consecutive-pathii.html)
- 最长连续序列(值相差为 1)路径的长度，路径起点跟终点可以为二叉树的任意节点
