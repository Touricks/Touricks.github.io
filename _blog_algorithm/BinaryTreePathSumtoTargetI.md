---
layout: default
title: BinaryTreePathSumtoTargetI
narrow: true
---
https://app.laicode.io/app/problem/141

Given a binary tree in which each node contains an integer number. Determine if there exists a path **(the path can only be from one node to itself or to any of its descendants),** the sum of the numbers on the path is the given target number.

**Examples**

    5

  /    \

2      11

     /    \

    6     14

  /

 3  

If target = 17, There exists a path 11 + 6, the sum of the path is target.

If target = 20, There exists a path 11 + 6 + 3, the sum of the path is target.

If target = 10, There does not exist any paths sum of which is target.

If target = 11, There exists a path only containing the node 11.

**How is the binary tree represented?**

We use the level order traversal sequence with a special symbol "#" denoting the null node.
***
- Signature：`void dfs(TreeNode root, HashSet prefixSum, int sum)`
- 表示到当前节点root，从根节点到当前节点之间每个节点路径之和存在prefixSum中,根节点到当前节点之间路径和为sum
- Base Case: `root == Root, prefixSum = [0] , sum=0`
- 有height层，每层扩展两个节点
- 收集解的存在性：prefixSum.contains(target-root.key)
***
```java
public boolean exist(TreeNode root, int target) {  
    HashSet<Integer> set = new HashSet<>();  
    set.add(0);  
    return dfs(root,target,set,0);  
}  
public boolean dfs(TreeNode root, int target, HashSet<Integer> prefixSum, int sum){  
    if (root == null){  
        return false;  
    }  
    int curSum = sum+root.key;  
    if (prefixSum.contains(curSum-target)){  
        return true;  
    }  
    boolean isAdd = prefixSum.add(curSum);  
    boolean isSucceed = dfs(root.left,target,prefixSum,sum+root.key) ||  
            dfs(root.right,target,prefixSum,sum+root.key);  
    if (isAdd){  
        prefixSum.remove(curSum);  
    }  
    return isSucceed;  
}
```