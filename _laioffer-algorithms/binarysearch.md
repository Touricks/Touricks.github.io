---
layout: default
title: Binary-Search
narrow: true
---

## 典型框架

1. 找特定 target，找不到则结果不存在

```java
int binarySearch(int[] a, int target){
	int left = 0;
	int right = a.length - 1;
	while (left <= right){
		//int mid = (left+right)/2;
		int mid = left + (right - left) / 2;
		if (target == a[mid]){
			return mid;
		}
		else if (target<a[mid]){
			right = mid-1;
		}
		else{
			left = mid+1;
		}
	}
}
```

2. 找符合特定条件的最优结果（假设找 smallest Larger than target）

```java
int binarySearch(int[] a, int target){
	int mid;
	int left = 0;
	int right = a.length-1;
	while(left < right-1){
		mid = left + (right-left)/2;
		if (isValid(mid)){ // 这里是a[mid] > target
			right = mid; // mid是潜在答案
		}else{
			left = mid+1; // mid不是答案，直接排除
		}
	}
}
```

- 注意事项：
- null 和 length=0 特别处理
- right 和 left 的取值取决于
  - mid 能否是答案
  - 根据题目要求，在获知 mid 的信息后扩展答案的区间
  - 相关题目：[Clostest In sorted array](/algorithmn-notes/Clostest In sorted array.html)
- 必须 postprocessing：left 和 right 可能均不是答案，只是不断收缩的结果
  - 按照模板操作，left 一定小于等于 right
  - 如果问 first occur，先看 left； 问 last occur，先看 right

## 典型例题

- ==即使给定的解区间对应数组无序，甚至不是数组（e.g.字符串）,只要解区间有序，就可以用二分查找一个"最大值最小""最小值最大"类型的题目==

  - 解区间有序：对任意 i < len; 如果 a[i]是一个可行解，那么对任意 j>i（或 j<i）,a[j]都是可行解
  - 找满足条件的第一个值
  - 相关题目 1：[Search In Bitonic Array](/algorithmn-notes/Search In Bitonic Array.html)
  - 相关题目 2：[Search In Shifted Sorted Array I](/algorithmn-notes/Search In Shifted Sorted Array I.html)

- 进入二分查找时一定要注意 start 和 end 是否在界内（适用于在数组特定范围内执行二分查找）

  - 如果 start 被设定为`index+1`传入函数，则可能出现 start 出界（如果 index 是最后一个值）
  - 因为对此类题目需要判断，若`start>end`直接返回特定结果
  - [ReconstructBTwithPreorder-Inorder](/algorithmn-notes/ReconstructBTwithPreorder-Inorder.html)

- 倍增思想
  - 给定排好序的两个数组，找两个数组的中位数（要求 logn）
  - [MedianOfTwoSortedArray](/algorithmn-notes/MedianOfTwoSortedArray.html)
