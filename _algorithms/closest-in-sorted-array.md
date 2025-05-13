---
layout: post
title: Closest In Sorted Array
---

# Closest In Sorted Array

在有序数组中找最接近目标值的元素，常用二分查找思想。

## 相关题目

- [Binary Search]({{ "/algorithms/binarysearch.html" | relative_url }})

![Closest In Sorted Array](/assets/images/Pasted image 20250512152740.png)

- 二分查找的变体，需要处理边界情况
- 当找到目标值时直接返回
- 当找不到时，比较左右两个元素与目标的距离
- 返回距离较小的那个元素的索引

```java
public class Solution {
  public int closest(int[] array, int target) {
    if (array == null || array.length == 0) {
      return -1;
    }
    int left = 0;
    int right = array.length - 1;
    while (left < right - 1) {
      int mid = left + (right - left) / 2;
      if (array[mid] == target) {
        return mid;
      } else if (array[mid] < target) {
        left = mid;
      } else {
        right = mid;
      }
    }
    if (Math.abs(array[left] - target) <= Math.abs(array[right] - target)) {
      return left;
    }
    return right;
  }
}
```
