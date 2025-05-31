---
layout: default
title: Array-Deduplication-III
narrow: true
---
Given a sorted integer array, remove duplicate elements. For each group of elements with the same value do not keep any of them. Do this in-place, using the left side of the original array and and maintain the relative order of the elements of the array. Return the array after deduplication.

**Assumptions**
- The given array is not null
**Examples**
- {1, 2, 2, 3, 3, 3} → {1}

***
去留问题：关注的点是==怎么个留法==
在这题中：连续的重复元素 - 一个都不留

- Step1: 定义双指针
	- i的定义：表示i左边不包含i的部分都是我要的，==i指向了array中第一个不要的元素==
	- j的定义：负责遍历 - 循环变量 - 一定要看完所有元素

- Step2： 指针怎么移动 - 到什么位置终止 - ==尽量通俗易懂==
- i j 从谁开始？ i=j=0
- i和j也可以从1开始，第一个元素就算按照算法处理一定会先要，之后重复了再删

- 怎么判断要不要：回头看看兜里的元素
	- 要：要么兜里没有元素，要么看到现在的元素和兜里的不一样
	- 赋值operation: `array[slow] = array[fast]`

	- 不要：兜里装的元素和现在看的一样，不仅不要这个，额外：
		- 未来所有跟我兜里一样的全部跳过
		- 兜里元素掏出

- 返回结果： `[0,slow)`
	- 返回的是array: `Arrays.copyOfRange(array,0,i)`
	- 返回的是List: `listInstance.subList(0,i)`
	- 返回的是String: `new String(array,0,i)`
