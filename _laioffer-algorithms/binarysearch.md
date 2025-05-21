- 典型框架
1. 找特定target，找不到则结果不存在
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
2. 找符合特定条件的最优结果（假设找smallest Larger than target）
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
- null和length=0 特别处理
- right和left的取值取决于
	- mid能否是答案
	- 根据题目要求，在获知mid的信息后扩展答案的区间
	- 相关题目：[[Clostest In sorted array]]
	
- 必须postprocessing：left和right可能均不是答案，只是不断收缩的结果
	- 按照模板操作，left一定小于等于right
	- 如果问first occur，先看left； 问last occur，先看right

- ==即使给定的解区间对应数组无序，甚至不是数组（e.g.字符串）,只要解区间有序，就可以用二分查找一个“最大值最小”“最小值最大”类型的题目==
	- 解区间有序：对任意i < len; 如果a[i]是一个可行解，那么对任意j>i（或j<i）,a[j]都是可行解
	- 找满足条件的第一个值
	- 相关题目1：[[Search In Bitonic Array]]
	- 相关题目2：[[Search In Shifted Sorted Array I]]
