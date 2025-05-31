---
layout: default
title: ReconstructBTwithPreorder-Inorder
narrow: true
---
https://app.laicode.io/app/problem/213?plan=3

Given the preorder and inorder traversal sequence of a binary tree, reconstruct the original tree.

**Assumptions**

- The given sequences are not null and they have the same length
- There are no duplicate keys in the binary tree

**Examples**

preorder traversal = {5, 3, 1, 4, 8, 11}

inorder traversal = {1, 3, 4, 5, 8, 11}

the corresponding binary tree is

        5

      /    \

    3        8

  /   \        \

1      4        11

**How is the binary tree represented?**

**We use the pre order traversal sequence with a special symbol "#" denoting the null node.**
***
```
S1: 构建inorderMap<integer, integer> 表示一个整数在树中的相对位置
S2: 从另一个order中提取当前子树的根，并依赖inorderMap找左右子树区间
```

- 方法1：通过preorder找左右子树区间
- 在 `preorder` 中确实先是左子树后是右子树，所以满足 “TTT…FFF…” 的单调性；二分能用，但每层都要 log n，没有必要。
- **二分查找时要注意给定的start和end是否一定合法，如果start和end不一定合法需要判断if start>end 直接返回特定结果，防止ArrayOutOfBound Exception**
```java
public TreeNode reconstruct(int[] inOrder, int[] preOrder) {  
    HashMap<Integer, Integer> inorderMap = new HashMap<>();  
    for(int i=0;i<inOrder.length;i++){  
        inorderMap.put(inOrder[i],i);  
    }  
    TreeNode root = dfs(inorderMap, preOrder, 0, preOrder.length-1);  
    return root;  
}  
public TreeNode dfs(HashMap<Integer, Integer> inorder, int[] preorder, int start, int end){  
    if (start > end){  
        return null;  
    }  
    TreeNode root = new TreeNode(preorder[start]);  
    int LastIdxOfLeftSubtree = find(inorder, preorder, start+1, end, root.key);  
    root.left = dfs(inorder,preorder,start+1,LastIdxOfLeftSubtree);  
    root.right = dfs(inorder,preorder,LastIdxOfLeftSubtree+1,end);  
    return root;  
}  
public int find(HashMap<Integer, Integer> inorder, int[] preorder, int start, int end, int target){  
    // find the last one that satisfied: inorder[i] < inorder[target]  
    if (start > end){  
        return start-1;  
    }  
    int left = start;  
    int right = end;  
    while(left < right-1){  
        int mid = left + (right-left)/2;  
        if (inorder.get(preorder[mid]) < inorder.get(target)){  
            left = mid;  
        }else{  
            right = mid-1;  
        }  
    }  
    if (inorder.get(preorder[right])<inorder.get(target)){  
        return right;  
    }else if (inorder.get(preorder[left])<inorder.get(target)){  
        return left;  
    }else{  
        return start-1;  
    }  
}
```

- 方法2：通过根节点在inorder的位置可以直接得到左子树的大小，相应可以推出右子树的大小
```java
public TreeNode reconstruct(int[] inOrder, int[] preOrder) {  
    HashMap<Integer, Integer> inorderMap = new HashMap<>();  
    for(int i=0;i<inOrder.length;i++){  
        inorderMap.put(inOrder[i],i);  
    }  
    TreeNode root = dfs(inorderMap, 0, preOrder.length-1, preOrder, 0, preOrder.length-1);  
    return root;  
}  
public TreeNode dfs(HashMap<Integer, Integer> inorder, int inStart, int inEnd, int[] preorder, int start, int end){  
    if (start > end){  
        return null;  
    }  
    TreeNode root = new TreeNode(preorder[start]);  
    int leftTreeSize = inorder.get(preorder[start])-inStart;  
    root.left = dfs(inorder,inStart,inorder.get(preorder[start])-1,preorder,start+1,start+leftTreeSize);  
    root.right = dfs(inorder,inorder.get(preorder[start])+1,inEnd,preorder,start+leftTreeSize+1,end);  
    return root;  
}
```

