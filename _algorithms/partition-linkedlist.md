---
layout: post
title: Partition Linked List
date: 2024-05-13
categories: [算法]
tags: [算法, 链表, 分区]
---

# Partition Linked List

分割链表问题，常用于链表的重排或排序。

## 问题描述

给定一个链表和一个目标值，将链表分割成两部分，使得小于目标值的节点都在大于或等于目标值的节点之前。

## 解题思路

- Step1: 设置两个 dummy node
- Step2：将大于和小于 target 的节点接到两个 dummy node 上
  - 牢记：先保存下一个节点

## 代码实现

```java
public class Solution {
  public ListNode partition(ListNode head, int target) {
    ListNode dummy1 = new ListNode(0);
    ListNode cur1 = dummy1;
    ListNode dummy2 = new ListNode(0);
    ListNode cur2 = dummy2;
    while(head != null){
      if (head.value < target){
        cur1.next = head;
        cur1 = cur1.next;
      }else{
        cur2.next = head;
        cur2 = cur2.next;
      }
      head = head.next;
    }
    cur1.next = dummy2.next;
    cur2.next = null;
    return dummy1.next;
  }
}
```

## 相关题目

- [QuickSort LinkedList]({{ "/algorithms/quicksort-linkedlist.html" | relative_url }})
- [Reorder Linked List]({{ "/algorithms/reorder-linkedlist.html" | relative_url }})

![Partition Linked List](/assets/images/Pasted image 20250513113624.png)
