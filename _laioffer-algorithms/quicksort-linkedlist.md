---
layout: default
title: QuickSort LinkedList
narrow: true
---

Given a singly-linked list, where each node contains an integer value, sort it in ascending order. The quick sort algorithm should be used to solve this problem.

**Examples**

- null, is sorted to null
- 1 -> null, is sorted to 1 -> null
- 1 -> 2 -> 3 -> null, is sorted to 1 -> 2 -> 3 -> null
- 4 -> 2 -> 6 -> -3 -> 5 -> null, is sorted to -3 -> 2 -> 4 -> 5 -> 6

---

- ListNode quickSort(ListNode head)
  给定一个 head，返回一个新 head，使得链表升序排列
- Base Case
  head = null, return null
- Recursive Rule1
  - 先从头到尾判断每个数和 head 值的比较
  - 小于 head 的进入一个 LL
  - 大于 head 的进入一个 LL
- Subproblem：
  - quickSort(smallDummy.next)
  - quickSort(largeDummy.next)
  - 对两段链表进行排序
- Recursive Rule2
  - 合并：small - equal - large

```java
/**
 * class ListNode {
 *   public int value;
 *   public ListNode next;
 *   public ListNode(int value) {
 *     this.value = value;
 *     next = null;
 *   }
 * }
 */
public class Solution {
  public ListNode quickSort(ListNode head) {
    if (head == null){
      return null;
    }
    ListNode pivot = head;
    ListNode smallDummy = new ListNode(0);
    ListNode equalDummy = new ListNode(0);
    ListNode largeDummy = new ListNode(0);
    ListNode curSmall = smallDummy;
    ListNode curEqual = equalDummy;
    ListNode curLarge = largeDummy;
    ListNode curNode = head;
    while(curNode != null){
      if (curNode.value < pivot.value){
        curSmall.next = curNode;
        curSmall = curSmall.next;
      }else if (curNode.value == pivot.value){
        curEqual.next = curNode;
        curEqual = curEqual.next;
      }else{
        curLarge.next = curNode;
        curLarge = curLarge.next;
      }
      curNode = curNode.next;
    }
    curSmall.next = null;
    curEqual.next = null;
    curLarge.next = null;
    ListNode sortedSmall = quickSort(smallDummy.next);
    ListNode sortedLarge = quickSort(largeDummy.next);
    ListNode sorted = new ListNode(0);
    if (sortedSmall == null){
      sorted.next = equalDummy.next;
    }else{
      sorted.next = sortedSmall;
      curNode = sortedSmall;
      while(curNode.next != null){
        curNode = curNode.next;
      }
      curNode.next = equalDummy.next;
    }
    curNode = equalDummy.next;
    while(curNode.next != null){
      curNode = curNode.next;
    }
    curNode.next = sortedLarge;
    return sorted.next;
  }
}

```
