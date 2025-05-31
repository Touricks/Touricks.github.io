---
layout: default
title: Reconstruct Binary Search Tree With Level Order
narrow: true
---

Given the levelorder and inorder traversal sequence of a binary tree, reconstruct the original tree.

**Assumptions**

- The given sequences are not null and they have the same length
- There are no duplicate keys in the binary tree

**Examples**

levelorder traversal = {5, 3, 8, 1, 4, 11}

inorder traversal = {1, 3, 4, 5, 8, 11}

the corresponding binary tree is

     5

/ \

3 8

/ \ \

1 4 11

---

Recursion

1. Signature
   `TreeNode dfs(int[] inOrder, int[] levelOrder)`
   给出以当前节点为根的子树的 inorder 和 levelorder，返回构建好树的根
2. Base Case
   if inOrder.length 为 1，返回该节点
   if inOrder.length 为 0，返回 null
3. SubProblem
   root = `levelOrder[0]`
   root.left = dfs(inOrder, levelOrder1)
   root.right = dfs(inOrder,levelOrder2)
   由于 inorder 没有递归性质，但 levelOrder 有，我们用 levelOrder 存储当前子树中剩下的节点
   根据该节点在 inorder 中与 root 在 inorder 中位置的大小决定分到左子树还是右子树
4. Recursion Rule
   return root

```java
public TreeNode reconstruct(int[] inOrder, int[] levelOrder) {
    HashMap<Integer, Integer> inOrderMap = new HashMap<>();
    for(int i=0;i<inOrder.length;i++){
        inOrderMap.put(inOrder[i],i);
    }
    return dfs(inOrderMap,levelOrder);
}
public TreeNode dfs(HashMap<Integer, Integer> inOrder, int[] levelOrder){
    if (levelOrder.length == 0){
        return null;
    }
    TreeNode root = new TreeNode(levelOrder[0]);
    List<Integer> levelOrder1 = new ArrayList<>();
    List<Integer> levelOrder2 = new ArrayList<>();
    for(int i=1;i<levelOrder.length;i++){
        if (inOrder.get(levelOrder[i]) < inOrder.get(root.key)){
            levelOrder1.add(levelOrder[i]);
        }else{
            levelOrder2.add(levelOrder[i]);
        }
    }
    int[] lOrder = new int[levelOrder1.size()];
    int[] rOrder = new int[levelOrder2.size()];
    for(int i=0;i<levelOrder1.size();i++) lOrder[i] = levelOrder1.get(i);
    for(int i=0;i<levelOrder2.size();i++) rOrder[i] = levelOrder2.get(i);
    root.left = dfs(inOrder,lOrder);
    root.right = dfs(inOrder,rOrder);
    return root;
}
```
