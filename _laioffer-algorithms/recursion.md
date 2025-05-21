---
layout: default
title: Recursion
narrow: true
---

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

## Dummy head

- Dummy Head
  - 辅助头，节点本身没有实际意义，但是几乎所有 linkedlist 题目都需要，以降低编码复杂度
- 主要好处
  - 删除第一个元素、在第一个位置插入元素，都不再需要单独处理 "头指针可能改变" 的情况。
  - 任何节点的"前驱"都存在（除非链表空了），不必在代码里写 `if (head == node) ...`。
  - 插入／删除操作可以统一写成："找到前驱 `prev`，然后 `prev.next = newNode; newNode.next = curr;`"，不用再考虑 `prev` 为 `null` 的分支。
- 例题
  - [Reorder Linked List](/algorithmn-notes/reorder-linked-list.html)
    - 易错点：在对两条链表交叉合并时，一定要 **先把下一个节点保存好**，再去修改指针，最后再推进 `cur`。警惕连续的 cur.next 赋值操作将 cur 原先对应的节点信息抹除
  - [Partition Linked List](/algorithmn-notes/partition-linked-list.html)
    - 易错点：在对多条链表进行拼接时，警惕最后一段链表尾部的节点一定要添加额外设置:next = null. 如果把原来节点的 `next` 指针都保留了下来，会导致在把两条链拼接回去的时候形成了环
  - [QuickSort LinkedList](/algorithmn-notes/quicksort-linkedlist.html)
    - 将快速排序的两个区间划分成两个 LinkedList，然后以两个 LinkedList 作为参数调用自己

## Linkedlist traversal 写法

- Iterative 写法
- 例题：
  - [Reverse Linked List](/algorithmn-notes/reverse-linked-list.html)
  - [Reverse a linkedlist by pair](/algorithmn-notes/reverse-a-linkedlist-by-pair.html)

## 遍历时对"前一个"，"后一个"节点的控制方法

- 前一个节点
- 维护一个 prev 变量

```java
ListNode prev = dummy;         // dummy.next 是实际的 head
ListNode curr = dummy.next;
while (curr != null) {
  // 需要用到 prev 时就直接访问
  //    prev.next = curr.next;
  //    curr = curr.next;
  prev = curr;
  curr = curr.next;
}
```

- 后一个节点
- 单链表天然支持"后一个"：只需 `curr.next`。但要注意：
  - **空检查**：在访问 `curr.next.xxx` 之前，务必先判断 `curr.next != null`。

```java
while (curr != null && curr.next != null && curr.next.next != null) {
  ListNode next1 = curr.next;
  ListNode next2 = curr.next.next;
  // … 操作 next1、next2
  curr = curr.next;
}
```

# Array

## RainbowSort 相关

- 本质上还是快排，对于 color 较少的情况，可以做到 TC O(N) SC O(1) 解决
- 将快排的 pivot 换为`color[mid]`，然后在划分数组的同时划分`color[mid]`
- 优化方法（二路划分->三路划分）可以将很多元素相等导致的快排退化情况规避掉
  [Rainbow Sort](/algorithmn-notes/rainbow-sort.html)

# Stack

- Sorted Array with Three Stack (要求 TC O(NlogN) )
  [SortedWithStacks](/algorithmn-notes/sortedwithstacks.html)

# Tree

## BinaryTree 结构相关

- 在每一层以 root 为节点的递归中
  - 先考虑 base case，我们可以通过当前节点的值获得什么信息
  - **如果你在当前层用到了左右子树的值，而不是将他们传入递归参数，你可能走错了路**
- 对于非镜像判断，你需要将左右子树传入递归参数然后收集结果再处理
- **而镜像判断需要成对地、交叉地比较节点**，如果你在递归里只拿到一个子树，就很难再去查找它"镜像"的那一边是哪一个节点
- 例题
  [IsSymmertricTree](/algorithmn-notes/issymmertrictree.html)
  [TweakedIdenticalTrees](/algorithmn-notes/tweakedidenticaltrees.html)

- 板子题
- BST 节点的 Insert 和 Delete
  [BSTInsert](/algorithmn-notes/bstinsert.html)
  [BSTdelete](/algorithmn-notes/bstdelete.html)

- BinaryTree 的遍历(非递归写法)
- 牢记 cornercase 的处理 - null
- 在 inorder 和 postorder 中，我们需要保存当前访问的节点将其压入栈中
- 由于"当前访问的节点"不是"当前需要的节点"，我们只能将其压入栈中，而不能直接 pop()
  [Preorder(Iter)](/algorithmn-notes/preorder-iter.html)
  [Inorder(Iter)](/algorithmn-notes/inorder-iter.html)
