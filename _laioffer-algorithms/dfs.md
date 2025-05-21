---
layout: default
title: DFS
narrow: true
"aliases:": DFS_alg
---

## 综述

- DFS 核心特征：
  - 问题的解不需要合并，探索到树底部即可获得答案（的一部分）
  - find all possible
- Permutation and Combination
  - Permutation :input 和 output 没有元素个数的区别，只有元素顺序的区别
    - 结果区分元素出现的先后位置
    - 注意：
      - "结果长度固定" 只说明 **每条解都有 _K_ 个元素**；
      - 它与**是否要区分顺序**（排列 vs. 组合）是两条正交维度。
    - 一定可以用 swap-swap，但是剪枝方案可能受限（例如括号序列相关问题）
    - 由于 swap-swap 在检验方案前不会知道
  - Combination：output 的结果的元素个数可以不相同
    - 结果不区分元素出现的先后位置
    - 例如 all subset 类问题

| 递归深度代表什么？                           | 典型适用场景                | 原因                                                                       |
| -------------------------------------------- | --------------------------- | -------------------------------------------------------------------------- |
| **位置层**（depth = 当前要填的下标/槽位）    | 排列、N-Queens、括号生成…   | 顺序是答案的一部分；把"剩余可放的元素"逐个塞进槽位最直观。                 |
| **元素层**（depth = 正在处理第几个候选元素） | 子集、组合、硬币找零、背包… | 只关心"选几次"或"选不选"，先后顺序无意义；一次性决定某元素出现次数最简洁。 |

- 思考问题框架：
  - 每层思考一个位置（常用于 Permutation）结果中一个元素就一个，但是不同元素之间的排列组合，
  - 核心区别==同一个元素如果在不同位置出现，就代表不同解==（NQueen）
    - for 0 - n (所有候选均可考虑)
  - 每层思考一个元素（常用于 Combination）：
    - 每次考虑一个元素加不加；或者一种元素加多少个
    - 对于有重复元素的集合，考虑一个元素加不加，如果不加要跳过所有重复元素
    - for index - n(考虑当前位置及之后的元素，不能考虑当前位置前的元素)
- 讲解问题框架
  - Base Case，什么时候收集解
  - 有多少层，每层代表的意思 (How many level, Each level meaning)
  - 每层可以扩展的状态数 (Possible states from each level)
  - 画 Recustion Tree -> 完整的一行+完整的一个分支（竖列）
  - DFS rule：当前层干什么
- 代码框架
  - base case: `index == len or target == 特定条件`
  - Recursion rule：
    - for 0 - n: 当前元素能加几个
    - while loop: 当前元素构成乘法关系
    - for index - len: 用于表示不再考虑 index 之前的元素
- 该类常见易错点：

  - 忘记 return
    - 什么时候把解加入解集：`index == len or target == 特定条件`
    - 什么时候解无法继续扩展但是不是一个解：`index == len and target != 特定条件`
  - 忘记 deep copy
  - 忘了吃吐(除非 copy 的修改在 dfs 的参数上)
  - 忘记 null 时的特判（千万不能进 dfs）

- Recursion 和 DFS 比较
- Pure Recursion
  - 从下到上地构建 solution，一定是先拿到子问题的结果，再做原问题
- DFS Backtracking
  - 先在当前层做完自己的事情，以干完的状态去不同的下一层，从上到下
- 相同点：都是基于 Recursion 实现（自己调用自己）的，不同的是构建解的顺序
- 不同点：
  - 只要算法里出现"撤销 / 恢复"步骤，多半是 DFS；
  - 只出现"拆 & 合"的，多半是 Recursion

## Linear

### Permutation 类问题（解集元素个数固定）

- [Parentheses Problem1](/algorithmn-notes/parenthesesproblem1.html)
  - 括号序列问题 1，只能用每层决定一个位置才能得到最优解
- [All Permutations1](/algorithmn-notes/allpermutations1.html)
  - 字符串全排列-要求每个字符必须出现
- [Parentheses Problem2](/algorithmn-notes/parenthesesproblem2.html)
  - 括号序列问题，三种括号但没有优先级，对右括号的放置有限制
- [Parentheses Problem3](/algorithmn-notes/parenthesesproblem3.html)
  - 括号序列问题，三种括号有优先级，对左括号的放置也有限制了
  - 和 Problem2 的差别只有左括号放置时的条件有所改变，一行差别
- [All Permutations2](/algorithmn-notes/allpermutations2.html)
  - 字符串全排列-允许字符重复
- [All Permutations3](/algorithmn-notes/allpermutations3.html)
  - 字符串大小为 k 的全排列-允许字符重复
- [N Queen](/algorithmn-notes/nqueen.html)
  - 经典 N Queens 问题

### Combination 类问题（解集元素个数不定）

- [AllSubset1](/algorithmn-notes/allsubset1.html)
  - 找字符串的所有子集，不包含重复元素
  - Combination 问题,字符串的任意子集
- [Combination-Sum](/algorithmn-notes/combination-sum.html)
  - Combination 问题，完全背包，物品数量不限，问是否能正好装满，但要输出方案
- [Combination Of Coins](/algorithmn-notes/combinationofcoins.html) （99Cents）
  - Combination 问题：完全背包
- [All Subset2](/algorithmn-notes/allsubset2.html)
  - 找字符串的所有长度为 k 的子集
  - 虽然结果长度固定，但是先后顺序在答案里不构成区分，决定这题是一个 combination 问题
- [All Subset3](/algorithmn-notes/allsubset3.html)
  - 找字符串的所有子集，包含重复元素
  - 需要先给字符串排序，才能开始烤肉
- [All Subset4](/algorithmn-notes/allsubset4.html)
  - 找字符串的所有长度为 k 的子集，包含重复元素
- [FactorCombination](/algorithmn-notes/factorcombination.html)
  - 因数模拟，target 的修改从加减变成整除

## Tree

### 树上路径问题

![TreePathProblems](/algorithmn-notes/treepathproblems.html)

### LCA

#### 模型

- 总体思路：遍历
- 遍历：通过某种方式 traverse 这个 tree，找到点 or 收集一些信息
- 例如，基本模板：BinaryTree 中如何找到一个 Value

```java
public TreeNode find(TreeNode root, int toSearch){
	if (root == null || root.value == toSearch){
		return root;
	}
	TreeNode left = find(root.left, toSearch);
	TreeNode right = find(root.right, toSearch);
	return left != null? left : right;
}
```

- 那我们的 LCA 呢？

```java
public TreeNode find(TreeNode root, TreeNode to1, TreeNode to2){
	if (root == null || root == to1 || root == to2){
		return root;
	}
	TreeNode left = lowestCommonAncestor(root.left, to1,to2);
	TreeNode right = lowestCommonAncestor(root.right, to1,to2);
	if (left != null  && right != null) return root;
	return (left != null)? left : right;
}
```

- 对于无父结点 LCA 来说，我们需要 LCA 出现的两种形态

1. 左右分叉型
   观察某个结点 `subtree_root`，它的 **不同孩子子树** 中都各自包含了目标集合里的点

```
          subtree_root        ← 这里会命中 ≥2 个不同子树
         /          \
  … one(目标) …   … two(目标) …
```

- **第一次** 出现「某结点在 _至少两个_ 孩子分支里各找到 ≥1 个目标」的地方，路径已经"岔开"了，再往上走不会再同时覆盖所有目标，所以它就是最近的公共祖先。

2. 上下包含型
   目标节点全部落在 **同一条根-叶路径** 上

```
    one(祖先·目标)
      |
 subtree_root(子·目标)
      |
    two(孙·目标)
```

若只有 **1** 个孩子子树含全部剩余目标, 则 第一次满足 "自己就是目标" 且 "下方仍有目标" 的那个祖先即为 LCA

- 总结
- **若 ≥ 2 个孩子子树都各含目标**  
   再向上走就只会把这些子树包进同一分支，因此不会出现"更近"的公共祖先——这就是 **多分支分叉 (Generalized Case 1)**。
- **若所有目标都在同一孩子子树里**  
   继续往下直到那条链第一个出现目标的结点，此时"自己 + 那个孩子"正好构成两个来源，因此它成为 **链式包含 (Generalized Case 2)**。
- 对于 K-nary Tree 中找 N 个节点的 LCA，把"左右"替换成"孩子列表"，把"祖先-后代链"视为"只有一个方向命中"，即可

#### 解题思路（以二叉找 2 个节点的 LCA 为例）

- Step1： Function 定义

```
TreeNode LCA(root, one, two): 给我一个root和两个要找的点，我返回LCA是谁
```

- 我先找到了谁 -> 能判断位置关系（左右，上下）

- Step2：Base Case

  - root == null return null
  - root is one or two (遇到了其中一个) 找到一个就 return

- Step3：Subproblem

  - root.left
  - root.right

- Step4: Recursion Rule
  - 在任何一个点都可以看到两边子树查找的结果
  - Case1： 如果两边都没找到（left,right return 的都是 null）
    - 你肯定不是 LCA，报告给父节点
  - Case2： 如果两边都找到了呢(left,right 都不是 null)
    - 这种一定是左右结构，而且该节点就是这棵树中唯一的最特殊的那个点
    - 直接 return 自己
  - Case3：左边和右边有一边找到了
    - 不能确定 one 和 two 的位置，还需要等待其他
    - 只能报告给父节点：只找到一个，另一个不清楚在它下面，还是其他的子树里

#### 例题：

[Lowest Common Ancestor VI](/algorithmn-notes/lowestcommonancestorvi.html)

## Graph
