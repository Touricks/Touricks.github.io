---
layout: post
title: Reorder Linked List
date: 2024-05-13
categories: [算法]
tags: [算法, 链表, 重排]
---

# Reorder Linked List

链表重排问题，常用于链表的变形操作。

## 问题描述

给定一个链表，将其重排为：L0 → Ln → L1 → Ln-1 → L2 → Ln-2 → ...

## 解题思路

- Step1：找中点，切断
- Step2: Reverse 后半段
- Step3：拼接两段 LinkedList

## 代码实现

```java
public class Solution {
  public ListNode reorder(ListNode head) {
    if (head == null) return null;
    ListNode root1 = head;
    ListNode middle = findMiddle(head);
    ListNode root2 = middle.next;
    middle.next = null;
    root2 = reverse(root2);
    ListNode dummy = new ListNode(0);
    ListNode cur = dummy;
    while(root1 != null && root2 != null){
      cur.next = root1;
      root1 = root1.next;
      cur = cur.next;
      cur.next = root2;
      root2 = root2.next;
      cur = cur.next;
    }
    while(root1 != null){
      cur.next = root1;
      cur = cur.next;
      root1 = root1.next;
    }
    return dummy.next;
  }

  public ListNode findMiddle(ListNode head){
    ListNode slow = head;
    ListNode fast = head;
    while(fast != null && fast.next != null){
      slow = slow.next;
      fast = fast.next.next;
    }
    return slow;
  }

  public ListNode reverse(ListNode head){
    if (head == null || head.next == null){
      return head;
    }
    ListNode newhead = reverse(head.next);
    head.next.next = head;
    head.next = null;
    return newhead;
  }
}
```

## 相关题目

- [Partition Linked List]({{ "/algorithms/partition-linkedlist.html" | relative_url }})
- [QuickSort LinkedList]({{ "/algorithms/quicksort-linkedlist.html" | relative_url }})

![Reorder Linked List](/assets/images/Pasted image 20250512190808.png)
