---
layout: default
title: Binary Search
narrow: true
---

# 模板

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

# 例题

注意：

- null 和 length=0 特别处理
- right 和 left 的取值取决于
  - mid 能否是答案
  - 根据题目要求，在获知 mid 的信息后扩展答案的区间
  - 相关题目：[Clostest In sorted array](/algorithmn-notes/clostest-in-sorted-array.html)
- 必须 postprocessing：left 和 right 可能均不是答案，只是不断收缩的结果

  - 按照模板操作，left 一定小于等于 right
  - 如果问 first occur，先看 left； 问 last occur，先看 right

- ==即使给定的解区间对应数组无序，甚至不是数组（e.g.字符串）,只要解区间有序，就可以用二分查找一个"最大值最小""最小值最大"类型的题目==
  - 解区间有序：对任意 i < len; 如果 a[i]是一个可行解，那么对任意 j>i（或 j<i）,a[j]都是可行解
  - 找满足条件的第一个值
  - 相关题目 1：[Search In Bitonic Array](/algorithmn-notes/search-in-bitonic-array.html)
  - 相关题目 2：[Search In Shifted Sorted Array I](/algorithmn-notes/search-in-shifted-sorted-array-i.html)
