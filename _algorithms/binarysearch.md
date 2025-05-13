---
layout: post
title: Binary Search
date: 2024-05-13
categories: [算法]
tags: [算法, 二分查找, 数据结构]
---

# Binary Search

二分查找是一种高效的搜索算法，常用于在有序数组中查找目标值。

## 基本模板

```java
public int binarySearch(int[] array, int target) {
    if (array == null || array.length == 0) {
        return -1;
    }
    int left = 0;
    int right = array.length - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (array[mid] == target) {
            return mid;
        } else if (array[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return -1;
}
```

## 变体

### 1. 找第一个等于目标值的位置

```java
public int firstOccurrence(int[] array, int target) {
    if (array == null || array.length == 0) {
        return -1;
    }
    int left = 0;
    int right = array.length - 1;
    while (left < right - 1) {
        int mid = left + (right - left) / 2;
        if (array[mid] >= target) {
            right = mid;
        } else {
            left = mid;
        }
    }
    if (array[left] == target) {
        return left;
    }
    if (array[right] == target) {
        return right;
    }
    return -1;
}
```

### 2. 找最后一个等于目标值的位置

```java
public int lastOccurrence(int[] array, int target) {
    if (array == null || array.length == 0) {
        return -1;
    }
    int left = 0;
    int right = array.length - 1;
    while (left < right - 1) {
        int mid = left + (right - left) / 2;
        if (array[mid] <= target) {
            left = mid;
        } else {
            right = mid;
        }
    }
    if (array[right] == target) {
        return right;
    }
    if (array[left] == target) {
        return left;
    }
    return -1;
}
```

## 相关题目

- [Closest In Sorted Array]({{ "/algorithms/closest-in-sorted-array.html" | relative_url }})
- [Search In Bitonic Array]({{ "/algorithms/search-in-bitonic-array.html" | relative_url }})
- [Search In Shifted Sorted Array I]({{ "/algorithms/search-in-shifted-sorted-array-i.html" | relative_url }})
