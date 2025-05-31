---
layout: default
title: Rainbow-Sort
narrow: true
---
Given an array of balls with k different colors denoted by numbers 1- k, sort the balls.

**Examples**

- k=1, {1} is sorted to {1}
- k=3, {1, 3, 2, 1, 2} is sorted to {1, 1, 2, 2, 3}
- k=5, {3, 1, 5, 5, 1, 4, 2} is sorted to {1, 1, 2, 3, 4, 5, 5}

**Assumptions**

- The input array is not null.
- k is guaranteed to be >= 1.
- k << logn.
***


>快排普通方法如果重复元素太多，会退化到`O(N^2)`

- 优化方法：三指针防止重复元素影响时间效率
	- 假设我们选一个 pivot 值（例如某种颜色），用三个指针：
		- `low`，表示“< pivot”区间的右边界（初始在最左）。
		- `mid`，当前扫描元素的位置（从 `low` 开始往右）。
	    - `high`，表示“> pivot”区间的左边界（初始在最右）。
	- `[0,low)`表示小于pivot的区域,`[mid,high)`表示未确定的区域
	- `[low,mid)`表示等于pivot的区域，`[high,len-1]`表示大于pivot的区域

- 注意：**当 `mid == high` 时，位置 `high` 上的元素还没有被处理**，它既可能＜pivot，也可能＝pivot，也可能＞pivot。只有当 `mid` 跑过 `high`（即 `mid == high+1`）时，才意味着“[0..high]” 上的所有元素都已正确分类完毕，可以退出循环。

- 基本思路
```java
low = 0
mid = 0
high = n - 1
pivot = color[(cL + cR)/2]
while mid <= high:
  if A[mid] < pivot:
    swap(A[low], A[mid])
    low++; mid++
  else if A[mid] > pivot:
    swap(A[mid], A[high])
    high--
  else:  
    mid++
```
- **交换到前面**：`A[mid] < pivot`，就把它换到“更小”区间的尾端，`low` 和 `mid` 都往右扩张。
- **交换到后面**：`A[mid] > pivot`，把它换到“更大”区间的头部，`high` 左移；`mid` 不动，马上重新检查当前位置的新值。
- **跳过相等**：`A[mid] == pivot`，`mid` 直接跳过

- 更普适的写法
- Code
```java
public int[] rainbowSort(int[] array) {
    int len = array.length-1;
    int[] color = new int[]{-1,0,1};
    quickSort(array,0,len,color,0,color.length-1);
    return array;
  }
  public void swap(int[] array, int i, int j){
    int temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
  public void quickSort(int[] array, int arrLeft, int arrRight, int[] color, int colLeft, int colRight){
    if (arrLeft >= arrRight || colLeft >= colRight){
      return;
    }
    int small = arrLeft;
    int curIndex = arrLeft;
    int large = arrRight;
    int pivotColor = colLeft + (colRight-colLeft)/2;
    while(curIndex <= large){
      if (array[curIndex] < color[pivotColor]){
        swap(array,small,curIndex);
        small++;
        curIndex++;
      }else if (array[curIndex] > color[pivotColor]){
        swap(array,curIndex,large);
        large--;
      }else{
        curIndex++;
      }
    }
    quickSort(array,arrLeft,small-1,color,colLeft,pivotColor-1);
    quickSort(array,large+1,arrRight,color,pivotColor+1,colRight);
  }
```