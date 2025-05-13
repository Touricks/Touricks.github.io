---
layout: post
title: QuickSort LinkedList
---

# QuickSort LinkedList

链表版快速排序的实现与数组不同，常用递归和分治思想。

## 相关题目

- [Partition Linked List]({{ "/algorithms/partition-linkedlist.html" | relative_url }})

![QuickSort LinkedList](/assets/images/Pasted image 20250513130055.png)

- ListNode quickSort(ListNode head)
  给定一个 head，返回一个新 head，使得链表升序排列
- Base Case
  head = null, return null
- Recursive Rule
  - 先从上到下
