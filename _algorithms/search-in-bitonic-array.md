---
layout: post
title: Search In Bitonic Array
date: 2024-05-13
categories: [算法]
tags: [算法, 二分查找, 数组]
---

# Search In Bitonic Array

Bitonic 数组搜索问题，结合二分查找和分治思想。

## 问题描述

在一个 Bitonic 数组（先递增后递减）中查找目标值。

## 解题思路

- 首先，我们要找到最大的元素，才能以它为 pivot 向左向右找
- 对于任意 i 满足 a[i]<a[i-1] (i < len-1) , 我们称之为可行解，设为 isValid(i)
- 我们要找最大的元素，isValid 的元素都不是最大的元素
- if isValid(mid) = true => left = mid+1
- if isValid(mid) = false => right = mid

## 代码实现

```java
public class Solution {
  public int search(int[] array, int target) {
    if (array == null || array.length == 0){
      return -1;
    }
    int pivot = findPivot(array);
    int res1 = findTarget(array,0,pivot,target,false);
    int res2 = findTarget(array,pivot+1,array.length-1,target,true);
    if (res1 == -1 && res2 == -1){
      return -1;
    }
    if (res1 == -1){
      return res2;
    }else{
      return res1;
    }
  }
  public boolean isValid(int[] array, int index){
    if (index == array.length-1){
      return false;
    }
    return array[index]<array[index+1];
  }
  public int findPivot(int[] array){
    int left = 0;
    int right = array.length-1;
    while(left < right-1){
      int mid = left + (right-left)/2;
      if (isValid(array,mid)){
        left = mid+1;
      }else{
        right = mid;
      }
    }
    if (array[left]>array[right]){
      return left;
    }else{
      return right;
    }
  }
  public int findTarget(int[] array, int left, int right, int target, boolean isDown){
    while(left <= right){
      int mid = left + (right-left)/2;
      if (array[mid] == target){
        return mid;
      }
      if ((array[mid] < target)^isDown){
        left = mid+1;
      }else{
        right = mid-1;
      }
    }
    return -1;
  }
}
```

## 相关题目

- [Binary Search]({{ "/algorithms/binarysearch.html" | relative_url }})
- [Closest In Sorted Array]({{ "/algorithms/closest-in-sorted-array.html" | relative_url }})
- [Search In Shifted Sorted Array I]({{ "/algorithms/search-in-shifted-sorted-array-i.html" | relative_url }})

![Search In Bitonic Array](/assets/images/Pasted image 20250512152740.png)
