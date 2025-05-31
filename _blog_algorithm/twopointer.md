---
layout: default
title: TwoPointer
narrow: true
---

```table-of-contents

```

## 综述

slow-fast 的含义在 sliding window / 双指针 题目背景下具有不同的意义
slow-fast：就是 slow-fast 双指针
Sliding Window：Alias - 攘外必先安内

| 模式                    | 指针移动方向 | 区域划分                                      | 保序性   | 常见用途                               |
| ----------------------- | ------------ | --------------------------------------------- | -------- | -------------------------------------- |
| 同向隔板（Slow→Fast）   | 同方向       | `[0..slow)` + `[slow..fast)` + `[fast]`       | 稳定保序 | 滑动窗口、过滤、去重、移动零、隔板插入 |
| 相向隔板（Left←→Right） | 相向         | `[0..left)` + `[left..right]` + `[right+1..]` | 可打乱   | 原地分区（快速排序、Rainbow Sort）     |

- 对于相向隔板
  - `left` 标记左边"已放好"区的右边界；
  - `right` 标记右边"已放好"区的左边界；
  - 中间区 `[left .. right]` 是待处理的元素
  - [QuickSort LinkedList](/algorithmnotes/quicksort-linkedlist.html)
  - [Rainbow Sort](/algorithmnotes/rainbow-sort.html)

## Stack+two-pointer

- Basic Calculator
  - 包含乘除号
  - [BasicCalculator](/algorithmnotes/basiccalculator.html)
- Advanced Calculator
  - 包含乘除号和括号
  - [AdvancedCalculator](/algorithmnotes/advancedcalculator.html)
- Array Duduplication IV
  - [RemoveAllAdjcentDuplicates](/algorithmnotes/removealladjcentduplicates.html)
  - 去留问题：但这一题我们要保留长度小于 k 的子串
  - 考虑到 k 的范围，我们不能用 O(k)的时间判断一个字符该不该回退
  - 必须使用记忆化搜索思想（在 stack 里加一个计数器）

## 双指针 - Array/String

slow-fast：slow 左边是处理好的元素（不含 slow），当前指针 fast 是正在探索的元素，fast 右边是未处理的元素；`[slow,fast)`是无用的，任何时候不应该用到

`[0,slow)` keep
`[slow,fast)` useless
`fast` processing
`(fast,end]` unexplored

- 去除所有的重复元素

  - [Array Deduplication III](/algorithmnotes/array-deduplication-iii.html)
  - 去留问题：关注的点是==怎么个留法==
  - 在这题中：连续的重复元素 - 一个都不留
  - slow-fast 代替 stack 工作

- [Move-0s-to-end](/algorithmnotes/move-0s-to-end.html)
- 需要把一个特征对应的元素挪到一边，同时保持剩余元素的相对顺序。

- 字符串翻转问题
  - 有额外空格版（truncate all heading/trailing/duplicate space characters）
  - 当字符串长度可能发生变化时，使用 StringBuilder 比较方便
  - 如果两端都可能接字符，使用`Deque<Character>`,最后再 O（N）构建字符串
  - [ReverseWordsInASentenceII](/algorithmnotes/reversewordsinasentenceii.html)

## Linked List

Slow–Fast（快慢指针）是一种"**在同一遍历里，以不同步长同时推进两个指针**"的技巧。设：

- `slow` 每次走 1 步：`slow = slow.next;`
- `fast` 每次走 2 步：`fast = fast.next.next;`
  应用：查找中点，检测环

## Sliding Window

- Sliding Window 最重要的特征是：
  - `[slow,fast)` processing
  - `[0,slow)` useless
  - `(fast,end]` unexplored
- 对 fast 的处理步骤： - 移动 slow - 得到一个以 fast 为右边界的解集: `[slow2,fast]` - 更新答案
  [Longest Substring Without Repeating Characters](/algorithmnotes/longest-substring-without-repeating-characters.html)
- Sliding Window + Hashset
  [All anagram](/algorithmnotes/all-anagram.html)
- Sliding Window + HashMap
  [Longest subarray contains only 1s](/algorithmnotes/longest-subarray-contains-only-1s.html)
- Sliding Window + HashMap, 变种
  [Clostest Number in BST](/algorithmnotes/clostest-number-in-bst.html)
- Sliding Window + BST 的 inorder 性质

## MonoStack

### 综述

#### 问题特征

单调栈问题通常具有以下一些显著特征：

1. **寻找下一个/上一个更大/更小的元素**： 核心需求往往是对于数组中的每一个元素，找到它左边（或右边）第一个比它大（或小）的元素的位置或值。在"接雨水"问题中，对于当前的柱子 `height[i]`，我们需要找到它左边最高的柱子和右边最高的柱子，才能确定它上方能接多少水。
2. **局部与整体的关系**： 问题的解通常依赖于当前元素与其左右两侧特定元素的关系。单调栈通过维护一个具有单调性（单调递增或单调递减）的栈，来高效地找到这些相关的左右边界。
3. **一次遍历（或少量遍历）**： 单调栈算法通常只需要对输入数组进行一次（或常数次）遍历。每个元素最多进栈一次、出栈一次，因此时间复杂度通常是 O(N)。
4. **计算面积/贡献**： 很多单调栈问题最终会归结为计算由当前元素和其左右边界所形成的区域的某种属性（如"柱状图中的最大矩形"中的面积，"接雨水"中的水量）。当一个元素出栈时，往往是计算其贡献的最佳时机。
5. **方向性**： 有时需要从左到右遍历一次，再从右到左遍历一次（或者使用两个单调栈，一个处理左边界，一个处理右边界），来获取完整的左右边界信息。不过，"接雨水"用一个单调栈配合巧妙的逻辑也能解决。

#### 框架

- Coding 之前，明确"单调栈"的意义：
  - **选择栈的单调性：** 根据问题需求，决定是单调递增栈还是递减栈。
    - 找右边第一个更大元素 -> 通常用单调递减栈。
    - 找右边第一个更小元素 -> 通常用单调递增栈。
  - **确定栈中存储内容：** 存储**索引**。
  - **思考入栈/出栈逻辑：**
    - **何时入栈？** 通常在处理完栈顶比较后，当前元素（的索引）会入栈。
    - **何时出栈？** 当新来的元素破坏了栈的单调性时，栈顶元素出栈。
    - **出栈后做什么？** 出栈的元素 (`top`) 找到了它的一个重要边界（通常是新来的元素）。利用栈中（`pop`之后）的下一个元素作为另一个边界，计算 `top` 元素的贡献或属性。
  - **处理边界情况：**
    - 空输入。
    - 栈为空时（`pop` 或 `peek` 时）。
    - 遍历完成后栈中仍有元素。
- **初始化**：
  - 创建一个栈，用于存储元素的**索引**（通常是索引，因为我们需要用索引去访问原数组的值，并计算宽度等）。
  - 如果更新结果时需要用到栈顶 pop 后的栈顶，则预先给栈中塞一个默认元素（比如直方图最大矩形这道题目，塞一个-1）
  - 初始化结果变量（例如 `maxArea`, `totalWater`）。
- **遍历数组**：
  - 对于数组中的每一个元素 `nums[i]`（或 `height[i]`）：
    - **维护单调性（核心逻辑）**：
      - `while` 循环：当栈不为空，并且当前元素 `nums[i]` **破坏了栈的单调性**时，进入
        - **确定左边界**：
          - 如果栈为空，说明弹出的 `top` 元素左边没有比它更高的元素了（或者说没有形成凹槽的左壁）
            - 一个 corner case，直接得出结果（或退出）。
          - 如果栈不为空，那么新的栈顶元素 `stack.peek()` 就是 `top` 元素的左边界。
        - **计算贡献**：根据 `top` 元素、其左边界、其右边界（即当前 `nums[i]`）来计算相关的量（例如面积、水量）。
- **处理栈中剩余元素**：
  - 遍历结束后，如果栈中仍然有元素，可能需要进行一些后处理。
  - 对于"最大矩形面积"，需要处理栈中剩余的元素，此时它们的右边界可以认为是整个数组的末尾。
  - 对于"接雨水"的单调递减栈解法，在主循环中处理完毕，通常不需要这一步，因为水是"实时"计算的。

### Histogram Question

- 直方图接水问题
  - [MaxWaterTrapped](/algorithmnotes/maxwatertrapped.html)
  - 一道 1D monostack，但有两个更好的方法
  - 注意：单次弹栈计算的是一个特定高度层的水量，而不是某个特定柱子作为"最低点"的完整凹槽的总水量。整个凹槽的总水量是通过这些水层不断叠加计算得到的
- 3D 直方图接水问题
  - [MaxWaterTrapped3D](/algorithmnotes/maxwatertrapped3d.html)
- 直方图最大矩形问题
  - [LargestRectangleInHistogram](/algorithmnotes/largestrectangleinhistogram.html)
- 最大全为 1 矩形大小问题
  - [LargestRectangleOf1s](/algorithmnotes/largestrectangleof1s.html)

### 其他单调栈问题

- 最近更大的数字问题
  - [NextGreaterNumberI](/algorithmnotes/nextgreaternumberi.html)
- 最长上升子序列的 O(nlogn)写法
  - [LIS](/algorithmnotes/lis.html)

### 滑动窗口最大值问题

- [MaximumValueOfSizeKSlidingWindow](/algorithmnotes/maximumvalueofsizekslidingwindow.html)
  - 询问窗口大小为 k 时每个窗口的最大值
  - 单调栈/前缀后缀数组+分块
