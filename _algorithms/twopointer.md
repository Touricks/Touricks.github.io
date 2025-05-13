---
layout: post
title: Two Pointer
date: 2024-05-13
categories: [算法]
tags: [算法, 双指针, 技巧]
---

# Two Pointer

双指针技巧是一种常用的算法技巧，通过使用两个指针来解决问题。

## 问题类型

1. 对撞指针

   - 两个指针从数组两端向中间移动
   - 适用于有序数组的查找问题

2. 快慢指针

   - 两个指针以不同速度移动
   - 适用于链表中的环检测、中点查找等问题

3. 滑动窗口
   - 两个指针维护一个窗口
   - 适用于子数组、子串等问题

## 常见应用

### 1. 对撞指针

```java
public int[] twoSum(int[] numbers, int target) {
    int left = 0;
    int right = numbers.length - 1;
    while (left < right) {
        int sum = numbers[left] + numbers[right];
        if (sum == target) {
            return new int[]{left + 1, right + 1};
        } else if (sum < target) {
            left++;
        } else {
            right--;
        }
    }
    return new int[]{-1, -1};
}
```

### 2. 快慢指针

```java
public boolean hasCycle(ListNode head) {
    if (head == null || head.next == null) {
        return false;
    }
    ListNode slow = head;
    ListNode fast = head;
    while (fast != null && fast.next != null) {
        slow = slow.next;
        fast = fast.next.next;
        if (slow == fast) {
            return true;
        }
    }
    return false;
}
```

### 3. 滑动窗口

```java
public int minSubArrayLen(int target, int[] nums) {
    int left = 0;
    int sum = 0;
    int result = Integer.MAX_VALUE;
    for (int right = 0; right < nums.length; right++) {
        sum += nums[right];
        while (sum >= target) {
            result = Math.min(result, right - left + 1);
            sum -= nums[left++];
        }
    }
    return result == Integer.MAX_VALUE ? 0 : result;
}
```

## 相关题目

- [Reorder Linked List]({{ "/algorithms/reorder-linkedlist.html" | relative_url }})
- [Partition Linked List]({{ "/algorithms/partition-linkedlist.html" | relative_url }})

# 综述

去留问题：关注的点是==怎么个留法==
在这题中：连续的重复元素 - 一个都不留

- Step1: 定义双指针

  - i 的定义：表示 i 左边不包含 i 的部分都是我要的，==i 指向了 array 中第一个不要的元素==
  - j 的定义：负责遍历 - 循环变量 - 一定要看完所有元素

- Step2： 指针怎么移动 - 到什么位置终止 - ==尽量通俗易懂==
- i j 从谁开始？ i=j=0
- i 和 j 也可以从 1 开始，第一个元素就算按照算法处理一定会先要，之后重复了再删

- 怎么判断要不要：回头看看兜里的元素

  - 要：要么兜里没有元素，要么看到现在的元素和兜里的不一样
  - 赋值 operation: `array[slow] = array[fast]`

  - 不要：兜里装的元素和现在看的一样，不仅不要这个，额外：
    - 未来所有跟我兜里一样的全部跳过
    - 兜里元素掏出

- 返回结果： `[0,slow)`
  - 返回的是 array: `Arrays.copyOfRange(array,0,i)`
  - 返回的是 List: `listInstance.subList(0,i)`
  - 返回的是 String: `new String(array,0,i)`

# Sliding Window

# MonoStack
