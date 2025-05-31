---
layout: default
title: Reorder Linked List
narrow: true
---

Reorder the given singly-linked list N1 -> N2 -> N3 -> N4 -> … -> Nn -> null to be N1- > Nn -> N2 -> Nn-1 -> N3 -> Nn-2 -> … -> null

**Examples**

- L = null, is reordered to null
- L = 1 -> null, is reordered to 1 -> null
- L = 1 -> 2 -> 3 -> 4 -> null, is reordered to 1 -> 4 -> 2 -> 3 -> null
- L = 1 -> 2 -> 3 -> null, is reordred to 1 -> 3 -> 2 -> null

---

- Step1：找中点，切断
- Step2: Reverse 后半段
- Step3：拼接两段 LinkedList

- Function 能做什么

```java
public ListNode reorder(ListNode root);
```

给定一个 root,我能返回从 root 出发，按照题目要求变序后的 LinkedList 的 root

- Step1：找中点：two-pointer
  - slow++,fast+2, until fast reach the end.
  - return slow
- Step2: 切断，reverse 后半段
  - root2 = slow.next
  - slow.next = null
  - reverse(root2)
- Step3: 拼接两段 LinkedList

- 注意，为了防止自环，最稳妥的方法还是先保存两条链的下一个节点

```java
while (l1 != null && l2 != null) {
    ListNode n1 = l1.next, n2 = l2.next;
    cur.next = l1;
    cur = cur.next;
    cur.next = l2;
    cur = cur.next;
    l1 = n1;
    l2 = n2;
}
```

Code

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
