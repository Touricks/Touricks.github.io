---
layout: post
title: Recursion
date: 2024-05-13
categories: [算法]
tags: [算法, 递归, 分治]
---

# Recursion

递归是一种重要的编程技巧，通过函数调用自身来解决问题。

## 递归的基本要素

1. 基本情况（Base Case）

   - 递归的终止条件
   - 不需要继续递归的情况

2. 递归情况（Recursive Case）
   - 将问题分解为更小的子问题
   - 调用自身解决子问题

## 递归的实现步骤

1. 确定基本情况
2. 确定递归情况
3. 确定递归函数的参数和返回值
4. 实现递归函数

## 常见应用

### 1. 阶乘计算

```java
public int factorial(int n) {
    // Base case
    if (n == 0 || n == 1) {
        return 1;
    }
    // Recursive case
    return n * factorial(n - 1);
}
```

### 2. 斐波那契数列

```java
public int fibonacci(int n) {
    // Base case
    if (n <= 1) {
        return n;
    }
    // Recursive case
    return fibonacci(n - 1) + fibonacci(n - 2);
}
```

### 3. 二叉树遍历

```java
public void inorderTraversal(TreeNode root) {
    // Base case
    if (root == null) {
        return;
    }
    // Recursive case
    inorderTraversal(root.left);
    System.out.println(root.val);
    inorderTraversal(root.right);
}
```

## 递归的优化

1. 记忆化递归

   - 使用数组或哈希表存储已计算的结果
   - 避免重复计算

2. 尾递归优化
   - 递归调用是函数的最后一个操作
   - 可以转换为迭代实现

## 相关题目

- [QuickSort LinkedList]({{ "/algorithms/quicksort-linkedlist.html" | relative_url }})
- [DFS]({{ "/algorithms/dfs.html" | relative_url }})

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
