---
layout: default
title: Search-In-Bitonic-Array
narrow: true
---
Search for a target number in a bitonic array, return the index of the target number if found in the array, or return -1.
A bitonic array is a combination of two sequence: the first sequence is a monotonically increasing one and the second sequence is a monotonically decreasing one.
Assumptions:
- The array is not null.
Examples:
array = {1, 4, 7, 11, 6, 2, -3, -8}, target = 2, return 5.
***

- 首先，我们要找到最大的元素，才能以它为pivot向左向右找。如何找最大的元素？
- 对于任意i满足a[i]<a[i-1] (i < len-1) , 我们称之为可行解，设为isValid(i)
- 我们要找最大的元素，isValid的元素都不是最大的元素
- if isValid(mid) = true => left = mid+1
- if isValid(mid) = false  => right = mid

- 此时left一定不小于right，因为小于的都被mid+1了
- 检查left，然后从left向左向右搜target

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