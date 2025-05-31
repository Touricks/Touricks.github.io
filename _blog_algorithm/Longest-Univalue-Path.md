---
layout: default
title: Longest-Univalue-Path
narrow: true
---
https://leetcode.com/problems/longest-univalue-path/description/
Given the `root` of a binary tree, return _the length of the longest path, where each node in the path has the same value_. This path may or may not pass through the root.
**The length of the path** between two nodes is represented by the number of edges between them.

- Step1: function定义
```
longestUnivaluePath(TreeNode root)
```
给我一个root，我能返回从root出发到anynode的直上直下path的最大长度

- Step2： Base Case
	- root is null return 0
	- root is leaf (root.left, root.right is null) return 0， 因为没有链长

- Step3： Subproblem
	-  left返回从left出发到anyNode的最大长度
	- right返回从right出发到anyNode的最大长度

- Step4： Recursive Rule
	- 要么人字形: left+right+2
	- 要么直上直下：left/right +1
	- 要么东山再起：0（没有链长）

- 我们将不合法时的left/right设置为0，就可以把直上直下/东山再起统一到人字形中处理

```java
public int longestUnivaluePath(TreeNode root) {  
    int[] ans = new int[]{Integer.MIN_VALUE};  
    dfs(root,ans);  
    return ans[0];  
}  
public int dfs(TreeNode root, int[] ans){  
    if (root == null){  
        return 0;  
    }  
    // left返回从left出发到anyNode的最大长度  
    // right返回从right出发到anyNode的最大长度  
    int left = dfs(root.left,ans);  
    int right = dfs(root.right,ans);  
    // extendLeft表示左子树和root合并后链的长度，如果不能合并则为0  
    // extendRight表示左子树和root合并后链的长度，如果不能合并则为0  
    int extendLeft = (root.left != null && root.left.val == root.val)? left+1 : 0;  
    int extendRight = (root.right != null && root.right.val == root.val)? right+1 : 0;  
    ans[0] = Math.max(ans[0], extendLeft + extendRight);  
    return Math.max(extendLeft, extendRight);  
}
```
