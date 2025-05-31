---
layout: default
title: Longest-Incresing-Path
narrow: true
---
https://leetcode.com/problems/binary-tree-longest-consecutive-sequence/description/
https://www.lintcode.com/problem/595/
给一棵二叉树，找到最长连续路径的长度。  
这条路径是指 任何的节点序列中的起始节点到树中的任一节点都必须遵循 父-子 联系。最长的连续路径必须是从父亲节点到孩子节点（`不能逆序`）。
- 要求子.key = 父.key +1
```
输入:
{1,#,3,2,4,#,#,#,5}
输出:3
说明:
这棵树如图所示
   1
    \
     3
    / \
   2   4
        \
         5
最长连续序列是3-4-5，所以返回3.
```
***
返回：直上直下

Step1 Base Case:
root == null, return 0
root is leaf, return 1

Step2 subproblem
left = dfs(root.left) 表示以root.left为根的最长递增子串
right = dfs(root.right) 表示以root.right为根的最长递增子串

Step3 Recursive Rule
left = left  如果root=root.left+1, 否则 left = 0
right = right  如果root=root.right+1, 否则 right = 0
ans: Max(left.right)+1 的全局最大值
return: Max(left.right)+1
```
public int longestConsecutive(TreeNode root) {  
    int[] ans = new int[]{Integer.MIN_VALUE};  
    dfs(root,ans);  
    return ans[0];  
}  
public int dfs(TreeNode root, int[] ans){  
    if (root == null) return 0;  
    int left = dfs(root.left, ans);  
    int right = dfs(root.right, ans);  
    left = (root.left != null && root.left.val == root.val+1)? left : 0;  
    right = (root.right != null && root.right.val == root.val+1)? right : 0;  
    ans[0] = Math.max(ans[0],(Math.max(left,right))+1);  
    return Math.max(left,right)+1;  
}
```
