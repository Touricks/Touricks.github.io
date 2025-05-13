---
layout: post
title: Recursion
---

# Recursion

递归是一种通过函数自身调用自身来解决问题的方法，常用于分治、树形结构等问题。

## 例题

- [QuickSort LinkedList]({{ "/algorithms/quicksort-linkedlist.html" | relative_url }})
- [Partition Linked List]({{ "/algorithms/partition-linkedlist.html" | relative_url }})
- [Reorder Linked List]({{ "/algorithms/reorder-linkedlist.html" | relative_url }})

# 综述

四个问题：

- Function 能做什么
- Base Case
- Subproblem
- Recursion Rule

一个思路

- 从下到上地构建 solution，一定是先拿到子问题的结果，再做原问题

- 对于 Recursion 问题的 Iterative 解法，总是：
  - 要自己维护一个 stack 来保存这些信息 （如 inorder traversal）
  - 如果要保存的信息只有一个，可以不开 stack（reverse linkedlist）
  - 在一个 `while`/`for` 循环里，不断更新指针或状态，手动决定下一步该处理的子问题

# Linked List

- Dummy Head
  - 辅助头，节点本身没有实际意义，但是几乎所有 linkedlist 题目都需要，以降低编码复杂度
- 例题
  - [[Reorder Linked List]]
    - 易错点：在对两条链表交叉合并时，一定要 **先把下一个节点保存好**，再去修改指针，最后再推进 `cur`。警惕连续的 cur.next 赋值操作将 cur 原先对应的节点信息抹除
  - [[Partition Linked List]]
    - 易错点：在对多条链表进行拼接时，警惕最后一段链表尾部的节点一定要添加额外设置:next = null. 如果把原来节点的 `next` 指针都保留了下来，会导致在把两条链拼接回去的时候形成了环
  - [[QuickSort LinkedList]]
- Recursion vs Traversal
- 例题：
  - [[Reverse Linked List]]
  - [[Reverse a linkedlist by pair]]
