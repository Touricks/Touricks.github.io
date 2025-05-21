- Recursion解法
Step1：Signature
```
ListNode reverse(ListNode head)
```
给定一个链表头，返回这个链表的reverse状态的链表头

Step2：Base Case
if head == null 或者 head.next == null，则不需要继续递归，返回head

Step3：Subproblem
newHead = reverse(head.next) 表示以下一个节点为链表头的reveres状态的链表头

Step4：Recursion Rule
head.next.next = head 下一个节点指向自己
head.next = null断开指向下一个节点的连接
return newHead 返回reverse后的链表头

```java
public ListNode reverse(ListNode head) {
    if (head == null || head.next == null){
      return head;
    }
    ListNode newHead = reverse(head.next);
    head.next.next = head;
    head.next = null;
    return newHead;
  }
```

- Iterative解法：
- 思考：我在当前层
	- 1. 如何处理当前层记录的同时不影响访问下层信息
	- 2. 为了完成这个任务我需要记录多少个值
```java
public ListNode reverse(ListNode head) {
    ListNode cur = head;
    ListNode pre = null;
    ListNode nxt = null;
    if (head == null){
      return null;
    }
    while(cur != null){
      nxt = cur.next;
      cur.next = pre;
      pre = cur;
      cur = nxt;
    }
    
    return pre;
  }
```