---
layout: default
title: Search-In-Shifted-Sorted-Array-I
narrow: true
---
Given a target integer T and an integer array A, A is sorted in ascending order first, then shifted by an arbitrary number of positions.

For Example, A = {3, 4, 5, 1, 2} (shifted left by 2 positions). Find the index i such that A[i] == T or return -1 if there is no such index.

**Assumptions**

- There are no duplicate elements in the array.

**Examples**

- A = {3, 4, 5, 1, 2}, T = 4, return 1
- A = {1, 2, 3, 4, 5}, T = 4, return 3
- A = {3, 5, 6, 1, 2}, T = 4, return -1

**Corner Cases**

- What if A is null or A is of zero length? We should return -1 in this case.

***

- 对于任意index满足a[index] > a[len-1]的值，设isValid(index)=true,反之为false
- 我们要找isValid=true的第一个值
- 例如，对于[3,4,5,1,2], 在isValid处理后变为[true,true,true,false,-]
- 我们想要的pivot是Last occurrance of True

- if isValid(mid) = true => left = mid （mid是可能是答案）
- if isValid(mid) = false => right = mid-1 (mid一定不是答案)
- 由于是last occurrance，先判断right再判断left
- 然后在两个区间中搜索

```java
public class Solution {
  public int search(int[] array, int target) {
    if (array == null || array.length == 0){
      return -1;
    }
    int pivot = findPivot(array);
    int res1 = findValue(array,0,pivot,target);
    int res2 = findValue(array,pivot+1,array.length-1,target);
    if (res1 == -1 && res2 == -1){
      return -1;
    }
    if (res1 == -1){
      return res2;
    }else{
      return res1;
    }
  }
  public int findValue(int[] array, int left, int right, int target){
    while(left <= right){
      int mid = left + (right-left)/2;
      if (array[mid] == target){
        return mid;
      }
      if (array[mid] < target){
        left = mid+1;
      }else{
        right = mid-1;
      }
    }
    return -1;
  }
  public boolean isValid(int[] array, int index){
    return array[index]>array[array.length-1];
  }
  public int findPivot(int[] array){
    if (array.length == 1){
      return 0; 
    } 
    int target = array[array.length-1];
    int left = 0;
    int right = array.length-2;
    while(left < right-1){
      int mid = left + (right-left)/2;
      if (isValid(array,mid)){
        left = mid;
      }else{
        right = mid-1;
      }
    }
    if (isValid(array,right)){
      return right;
    }else if (isValid(array,left)){
      return left;
    }else{
      return -1;
    }
  }
}

```