---
layout: post
title: QuickSort LinkedList
date: 2024-05-13
categories: [算法]
tags: [算法, 链表, 排序, 快速排序]
---

# QuickSort LinkedList

链表版快速排序的实现与数组不同，常用递归和分治思想。

## 问题描述

对链表进行快速排序，要求时间复杂度为 O(nlogn)，空间复杂度为 O(logn)。

## 解题思路

- ListNode quickSort(ListNode head)
  给定一个 head，返回一个新 head，使得链表升序排列
- Base Case
  head = null, return null
- Recursive Rule
  - 先从上到下
  - 再从左到右

## 代码实现

```java
public class Solution {
  public ListNode quickSort(ListNode head) {
    if (head == null || head.next == null) {
      return head;
    }
    ListNode pivot = head;
    ListNode smaller = new ListNode(0);
    ListNode larger = new ListNode(0);
    ListNode curSmaller = smaller;
    ListNode curLarger = larger;
    ListNode cur = head.next;

    while (cur != null) {
      if (cur.value < pivot.value) {
        curSmaller.next = cur;
        curSmaller = curSmaller.next;
      } else {
        curLarger.next = cur;
        curLarger = curLarger.next;
      }
      cur = cur.next;
    }

    curSmaller.next = null;
    curLarger.next = null;

    ListNode sortedSmaller = quickSort(smaller.next);
    ListNode sortedLarger = quickSort(larger.next);

    if (sortedSmaller == null) {
      pivot.next = sortedLarger;
      return pivot;
    }

    ListNode tail = sortedSmaller;
    while (tail.next != null) {
      tail = tail.next;
    }
    tail.next = pivot;
    pivot.next = sortedLarger;
    return sortedSmaller;
  }
}
```

## 相关题目

- [Partition Linked List]({{ "/algorithms/partition-linkedlist.html" | relative_url }})
- [Reorder Linked List]({{ "/algorithms/reorder-linkedlist.html" | relative_url }})

![QuickSort LinkedList](/assets/images/Pasted image 20250513130055.png)
