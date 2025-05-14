---
layout: default
title: Reverse a LinkedList by Pair
narrow: true
---

Reverse pairs of elements in a singly-linked list.

**Examples**

- L = null, after reverse is null
- L = 1 -> null, after reverse is 1 -> null
- L = 1 -> 2 -> null, after reverse is 2 -> 1 -> null
- L = 1 -> 2 -> 3 -> null, after reverse is 2 -> 1 -> 3 -> null

---

- Signatures
  reverseInPairs(head)
- Base Case
  - head = null, return null
  - head.next = null return head
- Subproblem：
  - newHead = reverInPairs(head.next.next)
- Recursive Rule
  - curHead = head.next
  - curHead.next = head
  - head.next = newHead
  - return curHead

```java
public ListNode reverseInPairs(ListNode head) {
    if (head == null || head.next == null){
      return head;
    }
    ListNode newHead = reverseInPairs(head.next.next);
    ListNode dummyhead = new ListNode(0);
    dummyhead.next = head.next;
    head.next.next = head;
    head.next = newHead;
    return dummyhead.next;
  }
```

- Iterative 写法

  > 对于头不定的情况（你不确定对于长度为 1 的是不是第二个，总之不是第一个），使用 dummyhead

- 一定要先保存下一轮要访问的点的信息，再处理这一轮的事情

```java
public ListNode reverseInPairs(ListNode head) {
    ListNode dummy = new ListNode(0);
    dummy.next = head;
    ListNode prev = dummy;
    while(prev.next != null && prev.next.next != null){
      ListNode first = prev.next;
      ListNode second = first.next;

      prev.next = second;
      first.next = second.next;
      second.next = first;
      prev = first;
    }
    return dummy.next;
  }
```
