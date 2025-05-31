---
layout: default
title: MedianOfTwoSortedArray
narrow: true
---
https://app.laicode.io/app/problem/410?plan=3

Given two sorted arrays of integers in ascending order, find the median value.

**Assumptions**

- The two given array are not null and at least one of them is not empty
- The two given array are guaranteed to be sorted

**Examples**

- A = {1, 4, 6}, B = {2, 3}, median is 3
- A = {1, 4}, B = {2, 3}, median is 2.5
***
- 首先，我们可以O（1）得出两个数组的length: 设为len1，len2
- 我们要找的数，可以简化为：
	- len1+len2为奇数时，要找index = (len1+len2)/2 小的数（设index从0开始）
	- len1+len2为偶数时，要找index1 = (len1+len2)/2 和index2 = （len1+len2）/2-1的平均数

- 找两数组第k小元素

- Signature: (k,sa,sb) 表示目前找两数组第k小的元素，sa和sb表示对应数组之前的部分已经被丢弃
- Case1: 单一数组已经被全部丢弃
	- if (sa >= a.length) return b[sb + k - 1];  
	- if (sb >= b.length) return a[sa + k - 1];
- Case2: k=1时要特殊处理，否则会陷入无限递归
	- if (k == 1) return Math.min(a[sa], b[sb]);
- Case3: 否则，找出每个数组在k/2位置的值
	- 注意，如果一个数组在k/2位置越界，则说明另外一个数组的**前k/2个值一定不是解**
	- 因为即使把当前越界数组剩下的所有值全部排除，也到不了k/2个
	- 此时可以放心排除另外一个数组的k/2个值并且继续递归

	- 如果两个数组都没有越界，将较小一方元素前的值全部舍去

```java
public double median(int[] a, int[] b) {  
    int len1 = a.length;  
    int len2 = b.length;  
    double res = 0;  
    if ((len1 + len2) % 2 == 0) {  
        int res1 = kth(a, b, (len1 + len2) / 2, 0, 0);  
        int res2 = kth(a, b, (len1 + len2) / 2 + 1, 0, 0);  
        res = 1.0 * (res1 + res2) / 2;  
    } else {  
        res = (double) kth(a, b, (len1 + len2) / 2 + 1, 0, 0);  
    }  
    return res;  
}  
  
public int kth(int[] a, int[] b, int k, int sa, int sb) {  
    if (sa >= a.length) return b[sb + k - 1];  
    if (sb >= b.length) return a[sa + k - 1];  
  
    // Base Case  
    if (k == 1) return Math.min(a[sa], b[sb]);  
  
    int amid  = sa + k / 2 - 1;  
    int bmid = sb + k/2-1;  
    // 选出各自要比较的元素下标  
    int valuea = (amid >= a.length) ? Integer.MAX_VALUE : a[amid];  
    int valueb = (bmid >= b.length) ? Integer.MAX_VALUE : b[bmid];  
  
    if (valuea <= valueb) {  
        return kth(a, b, k - k / 2, amid + 1, sb);  
    } else {  
        return kth(a, b, k - k / 2, sa, bmid + 1);  
    }  
}
```
	
