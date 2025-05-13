---
title: Closest In Sorted Array
---

# Closest In Sorted Array

在有序数组中查找最接近目标值的元素。

## 相关题目

- [Binary Search]({{ "/algorithms/binarysearch.html" | relative_url }})

![[Pasted image 20250512145838.png]]

Processing

- target = T
- array[mid] == target => 直接返回
- array[mid] < target => mid 可能是答案 > left = mid
- array[mid] > target => mid 可能是答案 > right = mid

PostProcessing

- left 可能是答案？Math.abs(a[left]-target)
- right 可能是答案？Math.abs(a[right]-target)
