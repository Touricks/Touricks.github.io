---
layout: default
title: Maximum-Path-Sum
narrow: true
---
https://app.laicode.io/app/problem/138?plan=3
Given a binary tree in which each node contains an integer number. Find the maximum possible sum **from one leaf node to another leaf node.** If there is no such path available, return Integer.MIN_VALUE(Java)
```
**Examples**
  -15

  /    \

2      11

     /    \

    6     14
The maximum path sum is 6 + 11 + 14 = 31.
```
***
- Method1
- Step1:Base Case
	- root == null -> 0 
- Step2: Recursive Rule
	- if 有左右儿子
		- 更新：ans = MAX(left+right+root.key)
	- return：
		- 如果只有左右儿子就只能返回左右儿子加上自己
		- 如果左右儿子都有就挑一个大的
		- 如果左右儿子都没有就直接返回自己
- 有没有更好的方法？（见下）
- Code
```java
public int maxPathSum(TreeNode root) {  
    int[] ans = new int[]{Integer.MIN_VALUE};  
    dfs(root,ans);  
    return ans[0];  
}  
public int dfs(TreeNode root, int[] ans){  
    if (root == null){  
        return 0;  
    }  
    int left = dfs(root.left,ans);  
    int right = dfs(root.right,ans);  
    if (root.left != null && root.right != null){  
     ans[0] = Math.max(ans[0],left+right+root.key);  
    }  
    if (root.left == null && root.right == null){  
        return root.key;  
    }else if (root.left == null){  
        return right + root.key;  
    }else if (root.right == null){  
        return left + root.key;  
    }else{  
        return Math.max(left,right)+root.key;  
    }  
}
```

- Method2
- 关键在于如何判断一个节点的左右儿子是否存在
- 自然的想法是如果是叶节点，那么左右儿子不存在，返回一个特定值

- Base Case
- if root == null -> return MIN_VALUE, 表示该节点不存在

- Recursive Rule
	- 更新：如果左右儿子的返回值都不是MIN_VALUE，说明存在，可以更新
		- if left != MIN_VALUE && right != MIN_VALUE -> 
		- ans = MAX(left+right+root.key)
	- return:
		- 如果左右儿子的返回值有一个是MIN_VALUE，一个不是
		- 那么取max就可以把不存在的儿子覆盖掉
		- 但如果都是MIN_VALUE,则不能覆盖，返回自己

```java
public int maxPathSum(TreeNode root) {  
    int[] ans = new int[]{Integer.MIN_VALUE};  
    dfs(root,ans);  
    return ans[0];  
}  
public int dfs(TreeNode root, int[] ans){  
    if (root == null){  
        return Integer.MIN_VALUE;  
    }  
    int left = dfs(root.left,ans);  
    int right = dfs(root.right,ans);  
    if (left != Integer.MIN_VALUE && right != Integer.MIN_VALUE){  
        ans[0] = Math.max(ans[0],left+right+root.key);  
    }  
    int bestChild = Math.max(left,right);  
    if (bestChild != Integer.MIN_VALUE){  
        return bestChild+root.key;  
    }else{  
        return root.key;  
    }  
}
```