---
layout: default
title: Clostest In Sorted Array
narrow: true
---

![pasted-image-20250512145838.png](/laioffer-algorithms/pasted-image-20250512145838.png)

Processing

- target = T
- array[mid] == target => 直接返回
- array[mid] < target => mid 可能是答案 > left = mid
- array[mid] > target => mid 可能是答案 > right = mid

PostProcessing

- left 可能是答案？Math.abs(a[left]-target)
- right 可能是答案？Math.abs(a[right]-target)
