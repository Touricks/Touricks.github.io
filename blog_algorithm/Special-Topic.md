---
layout: default
title: Special-Topic
narrow: true
---

```table-of-contents

```

## 字符串 API

[StringAPI](/algorithmn-notes/StringAPI.html)

- Group Anagram
  - 将相同组成的字符串归为一组
  - 如果能排序就好了
  - 思考：虽然 string 没有排序 API，但是 charArray 有呀！
  - [GroupAnagram](/algorithmn-notes/GroupAnagram.html)

## HashSet, TreeSet 与 PriorityQueue

| 结构            | **排序依据**                | **唯一性** | **判重依据**          |
| --------------- | --------------------------- | ---------- | --------------------- |
| `PriorityQueue` | `Comparator` / `Comparable` | **不**去重 | _无_（可重复）        |
| `TreeSet`       | `Comparator` / `Comparable` | 去重       | `compare(x,y)==0`     |
| `HashSet`       | 无序                        | 去重       | `hashCode` + `equals` |
|                 |                             |            |                       |

- API：
  [HashSet-TreeSet-PriorityQueue-API](/algorithmn-notes/HashSet-TreeSet-PriorityQueue-API.html)

- 因此，若`compareTo(x,y)==0` **但** `x.equals(y)==false`，则`add(x)` 之后再 `add(y)` → 第二次会被视为"重复"并被忽略；
- `x.equals(y)==true` **但** `compareTo(x,y)!=0` -> - 把 _逻辑上相等_ 的两个对象加入 `TreeSet` — 它们会被当成**不同节点**存两份；

TreeMap 和 HashMap 的比较:维持"全局有序"——TreeMap 最核心的额外工作

1. **比较而非取哈希**
   - 每一次 `put` / `get` 都要 `compare()`（或 `compareTo()`）。
2. **自平衡（红黑树约束）**
   - 插入或删除可能破坏平衡，TreeMap 通过 **O(1)** 次旋转 + 重染色修复。
   - 任何时刻树高 ≤ `2 log₂(n+1)`，保证操作 `O(log n)`。
3. TreeMap 基于"有序"特性提供的**前驱 / 后继 / 区间**检索方法
   • `firstKey()` / `lastKey()` — 最小 / 最大键  
   • `lowerKey(k)` — `‹ k` 的最大键  
   • `floorKey(k)` — `≤ k` 的最大键  
   • `ceilingKey(k)` — `≥ k` 的最小键  
   • `higherKey(k)` — `› k` 的最小键

## 2SUM

Determine if there exist two elements in a given array, the sum of which is the given target number.

- 这道问题的核心在于明确题目的要求：使用 CART 方案明确（有序性，范围多大）
- 基本解题思路为：
  - 双指针（sorted）(sorted)
    - 核心思路：对于 target，我们让左 pointer=0,右 pointer=len-1,则有

```
		int lv = nums[left], rv = nums[right]; //保存边界值
		if (lv+rv == target) add result // 保存结果
		// 找下一个备选值
		- while (left < right && nums[left]  == lv) left++;
        - while (left < right && nums[right] == rv) right--;
		- if (sum < target) left++;
		- if (sum < target) right--;
```

- `Hashset<Integer>`: unsorted，但仅需要判断解的存在性 - [2SUM-I](/algorithmn-notes/2SUM-I.html)
- `HashMap<Integer, List>` 存值出现的位置`（unsorted + List<index>）` - output: 2SUM pair 的所有可能位置 - [2SUM-II](/algorithmn-notes/2SUM-II.html)
- `HashMap<Integer, Integer>` 存值出现的次数（unsorted + count） - output: 2SUM pair 的所有可能方案 - [2SUM-III](/algorithmn-notes/2SUM-III.html)
- 拓展：3SUM
  - 注意 3SUM 和 2SUM 的非常大的区别
    - 2SUM 的期望复杂度是 O(N),因此**我们不能对数进行排序**
    - 3SUM 的期望复杂度是 O(N2)，因此**为了操作简单，使用双指针方案，我们可以对数进行排序。哪怕不使用双指针方案，为了防止重复，我们也要进行排序**
  - [3SUM](/algorithmn-notes/3SUM.html)
- 拓展：4SUM
  - 如果对值 target,我们能找到一对数，使得`i1+j1 = target`,**且 j1 尽量小**，那么我便能 O（1）判断给定的另外一对数`i2,j2`是否满足 存在一对数`i1,j1` 满足：
    - 1）`j2>i2>j1>i1`;
    - 2）`target+i2+j2==n`
    - 从而获得答案是否存在
  - [4SUM](/algorithmn-notes/4SUM.html)

### 需要 Clarify 的点

- return value OR return true/false OR return index
- data size
- duplication exist? (assume NO duplication)
- sorted vs unsorted
- data type: int?
- **optimize for time or optimize for space**

## K-way Sort and Finding Common Element

- K 个排序后数组合并

  - [KwayMerge](/algorithmn-notes/KwayMerge.html)

- K 个排序后数组找公共值
  - [KwayFindCommon](/algorithmn-notes/KwayFindCommon.html)

## 二维平面上共线的点的最大值

- 给定二维平面上 N 个点，求最多共线点的数量
  - [MostPointsInALine](/algorithmn-notes/MostPointsInALine.html)

## LRU

- 牢记以下需要使用的数据结构和技巧
  - **HashMap<K, Node>** O(1) 找到对应节点
  - **双向链表** 按时间顺序排列：尾部是最近使用，头部是最久未使用
  - **dummyHead / dummyTail** 把"链表为空 / 节点为首尾"这类特判全部统一掉
- [LRU](/algorithmn-notes/LRU.html)

- LRU 应用
- [FirstNonrepeatingCharacter](/algorithmn-notes/FirstNonrepeatingCharacter.html)

- LFU
- 不可能要求直接写的，但大致思路需要学习
- [LFU](/algorithmn-notes/LFU.html)

## 归并求逆序对

- [CountArray](/algorithmn-notes/CountArray.html)
  - 一个貌似简单的 MergeSort，但是实践上需要考虑一个重要的问题
  - 牢记：mergesort 的两个 helper function 都没有返回值(void)
  - **不要在递归函数中开额外的数组**

## Trie

[Trie](/algorithmn-notes/Trie.html)
