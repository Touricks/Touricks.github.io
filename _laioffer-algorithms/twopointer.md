---
layout: default
title: Two Pointer
narrow: true
---

## 综述

slow-fast 的含义在 sliding window / 双指针 题目背景下具有不同的意义
slow-fast：就是 slow-fast 双指针
Sliding Window：Alias - 攘外必先安内

| 模式                    | 指针移动方向 | 区域划分                                      | 保序性   | 常见用途                               |
| ----------------------- | ------------ | --------------------------------------------- | -------- | -------------------------------------- |
| 同向隔板（Slow→Fast）   | 同方向       | `[0..slow)` + `[slow..fast)` + `[fast]`       | 稳定保序 | 滑动窗口、过滤、去重、移动零、隔板插入 |
| 相向隔板（Left←→Right） | 相向         | `[0..left)` + `[left..right]` + `[right+1..]` | 可打乱   | 原地分区（快速排序、Rainbow Sort）     |

- 对于相向隔板
  - `left` 标记左边"已放好"区的右边界；
  - `right` 标记右边"已放好"区的左边界；
  - 中间区 `[left .. right]` 是待处理的元素
  - [QuickSort LinkedList](/algorithmn-notes/quicksort-linkedlist.html)
  - [Rainbow Sort](/algorithmn-notes/rainbow-sort.html)

## 双指针 - Array/String

slow-fast：slow 左边是处理好的元素（不含 slow），当前指针 fast 是正在探索的元素，fast 右边是未处理的元素；`[slow,fast)`是无用的，任何时候不应该用到

`[0,slow)` keep
`[slow,fast)` useless
`fast` processing
`(fast,end]` unexplored

[Array Deduplication III](/algorithmn-notes/array-deduplication-iii.html)

- 去留问题：关注的点是==怎么个留法==
- 在这题中：连续的重复元素 - 一个都不留
- slow-fast 代替 stack 工作

[Move-0s-to-end](/algorithmn-notes/move-0s-to-end.html)

- 有些时候，需要把一个特征对应的元素挪到一边，同时保持剩余元素的相对顺序。
- 同时保持相对顺序

## Linked List

Slow–Fast（快慢指针）是一种"**在同一遍历里，以不同步长同时推进两个指针**"的技巧。设：

- `slow` 每次走 1 步：`slow = slow.next;`
- `fast` 每次走 2 步：`fast = fast.next.next;`
  应用：查找中点，检测环

## Sliding Window

- Sliding Window 最重要的特征是：
  - `[slow,fast)` processing
  - `[0,slow)` useless
  - `(fast,end]` unexplored
- 对 fast 的处理步骤： - 移动 slow - 得到一个以 fast 为右边界的解集: [slow2,fast] - 更新答案
  [Longest Substring Without Repeating Characters](/algorithmn-notes/longest-substring-without-repeating-characters.html)
- Sliding Window + Hashset
  [All anagram](/algorithmn-notes/all-anagram.html)
- Sliding Window + HashMap
  [Longest subarray contains only 1s](/algorithmn-notes/longest-subarray-contains-only-1s.html)
- Sliding Window + HashMap, 变种
  [Clostest Number in BST](/algorithmn-notes/clostest-number-in-bst.html)

## MonoStack
