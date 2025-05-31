---
layout: default
title: DFS
narrow: true
---

# 综述

## DFS 和 Recursion 的区别

### 核心差别：状态回滚 vs 无状态回滚

- **DFS（深度优先搜索）**:
  - 特点是每次探索一条路径到底，然后**回退并清理状态**，再探索其他可能性
  - **关键操作**：`add` → `递归调用` → `remove`（恢复状态）
  - 目的是遍历所有可能的路径或组合
- **Recursion（递归）**:
  - 特点是将问题分解为更小的子问题，**无需显式维护全局状态**
  - **关键操作**：直接根据子问题的结果构建当前问题的解
  - 目的是通过分治的方式求解问题

### 典型例子对比

- **DFS 例子 - 排列组合问题**:

```java
void dfs(List<Integer> path, boolean[] used) {
    if (path.size() == n) {
        result.add(new ArrayList<>(path));
        return;
    }
    for (int i = 0; i < nums.length; i++) {
        if (!used[i]) {
            path.add(nums[i]);      // 状态改变
            used[i] = true;         // 状态改变
            dfs(path, used);        // 递归探索
            used[i] = false;        // 状态回滚
            path.remove(path.size()-1); // 状态回滚
        }
    }
}
```

- **Recursion 例子 - 树的最大深度**:

```java
int maxDepth(TreeNode root) {
    if (root == null) return 0;
    int leftDepth = maxDepth(root.left);   // 子问题1
    int rightDepth = maxDepth(root.right); // 子问题2
    return 1 + Math.max(leftDepth, rightDepth); // 合并结果
}
```

### 解法特点

- **DFS 解法特点**
  - 需要显式维护状态（如当前路径、访问标记等）
  - 从上到下地构建解，一直建到叶子，从叶子节点处收集解
  - 先在当前层做完自己的事情，以干完的状态去不同的下一层，从上到下
- **Recursion 解法特点**
  - 不需要维护全局状态，通过参数传递必要信息
  - 从下到上地构建解，先获得子问题答案，再构建当前层答案
  - 先在当前层做完自己的事情，以干完的状态去不同的下一层，从上到下
- 相同点：都是基于 Recursion 实现（自己调用自己）的，不同的是构建解的顺序
- 不同点：
  - 只要算法里出现"撤销 / 恢复"步骤，多半是 DFS；
  - 只出现"拆 & 合"的，多半是 Recursion

## Linear

### Permutation 类问题（先后顺序不同是不同解）

- 常用解题方法：每层思考一个位置
- [Parentheses Problem1](/algorithmnnotes/parentheses-problem1.html)
  - 括号序列问题 1，只能用每层决定一个位置才能得到最优解
- [All Permutations1](/algorithmnnotes/all-permutations1.html)
  - 字符串全排列，字母不会重复
- [Parentheses Problem2](/algorithmnnotes/parentheses-problem2.html)
  - 括号序列问题，三种括号但没有优先级，对右括号的放置有限制
- [Parentheses Problem3](/algorithmnnotes/parentheses-problem3.html)
  - 括号序列问题，三种括号有优先级，对左括号的放置也有限制了
  - 和 Problem2 的差别只有左括号放置时的条件有所改变，一行差别
- [All Permutations2](/algorithmnnotes/all-permutations2.html)
  - 字符串全排列-允许字符重复，求长度为 s.length 的全排列
  - 使用 HashSet 去重，保证**要固定到同一位置的两个元素的 value 不会有重复**
  - 对于每个尝试换过来的位置，都用一个 set 确保换过来的点没有重复
- [All Permutations3](/algorithmnnotes/all-permutations3.html)
  - 字符串的全排列-允许字符重复，求任意长度的全排列
  - 即：元素数量可以不同
  - 当前层的意义：`[0,index)的内容`，需要加入解
- [N Queen](/algorithmnnotes/n-queen.html)
  - 经典 N Queens 问题

### Combination 类问题（仅先后顺序不同是相同解）

- 常用解题方法：每次考虑一个元素的个数
  - 也可以使用每层考虑一个位置，但是**每个位置可以采用的元素必须是单调的（见 AllSubset1）**
- [AllSubset1](/algorithmnnotes/allsubset1.html)
  - 找字符串的所有子集，不包含重复元素
  - Combination 问题,字符串的任意子集
- [Combination-Sum](/algorithmnnotes/combination-sum.html)
  - Combination 问题，完全背包，物品数量不限，问是否能正好装满，但要输出方案
- [Combination Of Coins](/algorithmnnotes/combination-of-coins.html) （99Cents）
  - Combination 问题：完全背包
- [All Subset2](/algorithmnnotes/all-subset2.html)
  - 找字符串的所有长度为 k 的子集
  - 虽然结果长度固定，但是先后顺序在答案里不构成区分，决定这题是一个 combination 问题
- [All Subset3](/algorithmnnotes/all-subset3.html)
  - 找字符串的所有子集，包含重复元素
  - 需要先给字符串排序，才能开始烤肉
- [All Subset4](/algorithmnnotes/all-subset4.html)
  - 找字符串的所有长度为 k 的子集，包含重复元素
- [FactorCombination](/algorithmnnotes/factorcombination.html)
  - 因数模拟，target 的修改从加减变成整除

## Tree

### Top-Down/Bottom-Up

- 什么是 Top-Down/Bottom-Up

| 特征                       | Top Down - DFS (自顶向下)                                                                                                                                                                                      | Bottom Up - Recursion (自底向上)                                                                                                                                                                                            |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 当前 node 处处理问题的逻辑 | 从根节点（root）开始往下走，在 第一次遇到 node 的时候 就处理问题。逻辑是 "以当前节点 cur node 为结尾（ending at cur node）" 的问题的解。                                                                       | 从根节点往下走，第一次经过 node 时不处理。等到它的所有子节点都返回了结果后，在 第二次遇到 node 的时候 再处理。逻辑是 "以当前节点 cur node 为起点（starting from cur node）" 的问题的解。                                    |
| 是否已知下一层的结果？     | 否。因为是第一次遇到节点，子节点还没被访问，所以你对子节点一无所知。                                                                                                                                           | 是。因为子节点的递归调用已经全部返回，你已经拿到了子问题（下一层）的答案。                                                                                                                                                  |
| 是否依赖下一层的结果？     | 不依赖。处理当前节点时，只基于从上层（父节点）传下来的信息。                                                                                                                                                   | 依赖。当前节点的解通常是根据其子节点返回的结果计算出来的。                                                                                                                                                                  |
| 是否需要往下传参？         | 一般需要。通常要把从根节点到当前节点路径上累积的 path 信息 传递给左右孩子。比如，在"寻找路径和为某个值的路径"问题中，你需要把当前的路径和往下传。                                                              | 一般不需要。需要的信息通常都包含在子节点的返回值里了。父节点等待子节点告诉它答案，而不是主动把信息传下去。                                                                                                                  |
| Base case                  | 走到 base case（通常是叶子节点或 null）时，已经收集了足够的信息（比如从 root 到 leaf 的完整路径），可以直接更新结果。                                                                                          | base case 通常是 最轻松的那个点。比如，对于空节点 null，它返回一个初始值（如 0 或空列表），上层节点基于这个初始值进行计算。                                                                                                 |
| 最优解在哪里得到           | 走到叶子节点 leaf 或 null 时，得到了一条完整路径的信息，可以得到一个解，并用它来更新全局最优解。&lt;br>&lt;br>或者，在遍历到 任意一个节点 时，根据从根到当前节点的信息，也可能得到一个局部解或更新全局最优解。 | 最优解是 自下而上生成的。根据左右子树返回的关于子问题的解，生成当前节点的解，然后继续向上传递。&lt;br>&lt;br>最终的全局最优解可能来自于 最后的返回值（即 root 节点的返回值），也可能来自于 全局变量在递归过程中被不断更新。 |
| 优缺点                     | 优点： 思维上更直观，更贴近 DFS"一条路走到黑"的原始概念。缺点： 可能需要传递较多参数或使用全局变量来维护状态。                                                                                                 | 优点： 代码结构性更强，更贴近递归"解决子问题，合并结果"的本质。r>缺点： 对于某些问题，思考方式可能不如 Top-down 直观。                                                                                                      |

#### 判断 Top-down/Bottom-up 标准

> 如何判断题目适合 top-down 还是适合 bottom-up？

- 问自己一个问题：**"当我在节点 `N` 时，为了做出计算或判断，我需要的信息是来自它的【祖先】还是来自它的【子孙】？"**

1. 如果节点 `N` 的计算**依赖于它的祖先信息**（例如，从根节点到 `N` 的路径、`N` 的深度、从根到 `N` 的路径和），那么就用 **Top-Down (自顶向下)**。
2. 如果节点 `N` 的计算**依赖于它的子树的聚合信息**（例如，`N` 的左右子树的高度、节点数、最大/小值），那么就用 **Bottom-Up (自底向上)**。

#### Top-Down 题目类型

- 何时选择 Top-Down (自顶向下)
- 当解法需要"从上往下"传递信息时，选择 Top-Down。
- **信号 (Signals):**
  - 问题涉及到"**从根节点出发的路径**"。
  - 问题的状态与节点的**深度 (depth) 或层级 (level)** 相关。
  - 节点的计算需要知道它的**父节点**或**所有祖先**的状态。
  - 函数签名通常是 `void solve(TreeNode node, State stateFromParent)`，其中 `stateFromParent` 是从父节点传下来的状态。

**思维过程：**"我（父节点）把我这里的信息告诉你（子节点），你基于这些信息继续向下处理。"

**经典例子:**

- **Path Sum II (路径总和 II)**: 找出所有从根到叶子节点路径总和等于给定目标和的路径。
  - **判断**: 在任何一个节点，你需要知道**从根到当前节点的路径**以及**到目前为止的路径和**，这些都是祖先信息。因此，必须使用 Top-Down，将 `currentPath` 和 `currentSum` 向下传递。
- **Path Sum III (路径总和 III)**: 找出路径和等于目标值的路径数量（路径不需要从根开始或在叶子结束）。
  - **判断**: 高效解法需要知道**从根到当前节点的路径前缀和**，这是典型的祖先信息。所以使用 Top-Down，把前缀和的哈希表向下传递。
- **Sum Root to Leaf Numbers (求根到叶子节点数字之和)**: `1->2->3` 代表数字 123。
  - **判断**: 在节点 `3`，你需要知道它前面的路径是`1->2`（代表数字 12），这是祖先信息。所以使用 Top-Down，把 `12` 这个值向下传递。

---

#### Bottom-Up 题目类型

当解法需要"从下往上"返回和汇总信息时，选择 Bottom-Up。

**信号 (Signals):**

- 问题涉及到计算整棵树的**聚合属性**，如**高度 (height)**、**直径 (diameter)**、节点总数。
- 问题需要比较左右子树的**某种属性**。
- 一个节点的计算必须**等待**其左右子树的计算结果。
- 函数签名通常是 `Result solve(TreeNode node)`，其中 `Result` 是子树计算后返回给父节点的信息。

**思维过程：**"我（父节点）需要什么信息？我不知道，我去问我的孩子们。等它们（左右子树）把结果告诉我后，我再根据它们的结果计算我自己的结果，然后报告给我的上级（父节点的父节点）。"

**一个非常重要的模式：【全局变量】+【递归返回值】** 在很多 Bottom-Up 问题中，递归函数**返回的值**是给**父节点**用的，而**最终答案**则是在递归过程中通过一个全局变量（或成员变量）来更新的。

**经典例子:**

- **Maximum Depth of Binary Tree (二叉树的最大深度)**:
  - **判断**: 一个节点的高度是 `1 + max(左子树高度, 右子树高度)`。显然，它需要先知道两个子树的高度。这是典型的 Bottom-Up。
- **Balanced Binary Tree (平衡二叉树)**:
  - **判断**: 你需要知道左右子树的高度来判断当前节点是否平衡。同上，Bottom-Up。
- **Diameter of a Binary Tree (二叉树的直径)**:
  - **判断**: 经过一个节点的"最长路径"是它的 `左子树高度 + 右子树高度`。你需要从子树获取高度信息。
  - **全局变量模式**: `solve(node)` **返回**其高度给父节点，但在函数内部，它用 `左高度+右高度` 来**更新**一个全局的 `max_diameter` 变量。
- **Maximum Path Sum (最大路径和)**:
  - **判断**: 与"直径"问题异曲同工。你需要知道从左右子树出发的"单向最大路径和"。
  - **全局变量模式**: `solve(node)` **返回**单向最大路径和给父节点，但在内部，它用 `node.val + 左单向路径 + 右单向路径` 来**更新**一个全局的 `max_sum` 变量。
- **Lowest Common Ancestor (最近公共祖先)**:
  - **判断**: 一个节点是不是 LCA，取决于 `p` 和 `q` 是否在它的左右子树中。它需要等孩子节点的搜索结果。典型的 Bottom-Up。

#### 树上路径问题(Top-Down:信息自顶而下)

[树上路径问题(TopDown)](/algorithmnnotes/topdown.html)

#### 树上路径问题（Bottom-up:信息自底而上）

[树上路径问题(Bottomup)](/algorithmnnotes/bottomup.html)

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

#### 例题

[Lowest Common Ancestor VI](/algorithmnnotes/Lowest Common Ancestor VI.html)

## Graph
