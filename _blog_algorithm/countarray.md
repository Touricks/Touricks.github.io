---
layout: default
title: CountArray
narrow: true
---
https://app.laicode.io/app/problem/276?plan=3

Given an array A of length N containing all positive integers from [1...N]. How to get an array B such that B[i] represents how many elements A[j] (j > i) in array A that are smaller than A[i].

**Assumptions**:

- The given array A is not null.

**Examples:**

- A = { 4, 1, 3, 2 }, we should get B = { 3, 0, 1, 0 }.

**Requirement:**

- time complexity = O(nlogn).
***
- **要得到 B[i] = 右侧比 A[i] 小的元素个数**  ，使用归并排序思想
- 在归并阶段如果 **左边的当前元素 ≤ 右边的当前元素**，  那么 **左边这个元素前面已经跨过了 `rightUsed` 个右侧元素**，  这些右侧元素都比它小，应把 `rightUsed` 累加到它的计数上。

- 易错点：如果不使用辅助对象记录一个数的原始位置，则会出现逆序对的计数会错误地归属到在排序过程中恰好移动到该 `index` 位置的任何元素上，而不是固定地累加到某个特定初始元素上，从而造成错误
- 对于逆序对题目，最容易理解的方法是新建辅助对象

```java
package CrossTrainV;  
  
import Sort.mergesort;  
  
import java.util.HashMap;  
import java.util.Map;  
class Element{  
    int value;  
    int original_index;  
    int count;  
    public Element(int value, int index){  
        this.value = value;  
        this.original_index = index;  
        this.count = 0;  
    }  
}  
  
public class p276 {  
  
    public int[] countArray(int[] array) {  
        if (array == null || array.length == 0){  
            return new int[]{};  
        }  
        Element[] tmp = new Element[array.length];  
        Element[] arr = new Element[array.length];  
        for(int i=0;i<arr.length;i++){  
            arr[i] = new Element(array[i],i);  
        }  
        mergesort(arr, tmp,0, arr.length - 1);  
        int[] count = new int[array.length];  
        for(int i=0;i<arr.length;i++){  
            count[arr[i].original_index] = arr[i].count;  
        }  
        return count;  
    }  
  
    public void mergesort(Element[] array, Element[] tmp, int left, int right) {  
        if (left == right) {  
            return;  
        }  
        int mid = left + (right - left) / 2;  
        mergesort(array, tmp,left, mid);  
        mergesort(array, tmp,mid + 1, right);  
        merge(array,tmp,left,mid,right);  
    }  
  
    public void merge(Element[] arr, Element[] tmp, int left, int mid, int right) {  
        int index1 = left;  
        int index2 = mid+1;  
        int index = left;  
        int rightGetAdvanced = 0;  
        while(index1<= mid && index2 <= right){  
            if (arr[index1].value > arr[index2].value){  
                tmp[index++]= arr[index2++];  
                rightGetAdvanced++;  
            }else{  
                arr[index1].count += rightGetAdvanced;  
                tmp[index++] = arr[index1++];  
            }  
        }  
        while(index1<= mid){  
            arr[index1].count += rightGetAdvanced;  
            tmp[index++] = arr[index1++];  
        }  
        while(index2<= right){  
            tmp[index++]=arr[index2++];  
        }  
        for(int i=left;i<=right;i++){  
            arr[i] = tmp[i];  
        }  
    }  
}
```