---
layout: default
title: FlattenBinaryTree
narrow: true
---
https://app.laicode.io/app/problem/523?plan=3

Given a binary tree, flatten it to a linked list in-place.

For example,  
Given

         1
        / \
       2   5
      / \   \
     3   4   6

The flattened tree should look like:  

   1
    \
     2
      \
       3
        \
         4
          \
           5
            \
             6

***
- 利用一个栈（Stack）来模拟先序遍历的过程，并使用一个 `prev` 指针来追踪当前链表中最后一个已处理的节点，以便将新节点连接到其后
- Iterative写法
```java
public TreeNode flatten(TreeNode root) {  
    Deque<TreeNode> stack = new LinkedList<>();  
    if (root == null){  
        return null;  
    }  
    stack.push(root);  
    TreeNode prev = root;  
    while(!stack.isEmpty()){  
        TreeNode cur = stack.pop();  
        if (prev != cur){  
            prev.left = null;  
            prev.right = cur;  
        }  
        if (cur.right != null){  
            stack.push(cur.right);  
        }  
        if (cur.left != null){  
            stack.push(cur.left);  
        }  
        prev = cur;  
    }  
    return root;  
}
```

- Recursion写法（易错）
- 思考：为什么这里对于一个TreeNode - Object我们也要用数组来存全局变量？
```java
public TreeNode flatten(TreeNode root) {  
    TreeNode[] prev = new TreeNode[]{root};  
    dfs(root,prev);  
    return root;  
}  
public void dfs(TreeNode root, TreeNode[] prev){  
    if (root == null){  
        return;  
    }  
    TreeNode left = root.left;  
    TreeNode right = root.right;  
    if (prev[0] != root){  
        prev[0].left = null;  
        prev[0].right = root;  
    }  
    prev[0] = root;  
    dfs(left,prev);  
    dfs(right,prev);  
}
```
- **`prev` 变量的作用域和传递问题 (最核心的问题):**
    - 在Java中，对象引用是按值传递的。当你调用 `dfs(left, prev)` 或 `dfs(right, prev)` 时，你传递的是 `prev` 当前指向的对象的引用的副本。
    - 在 `dfs` 方法内部，当你执行 `prev = root;` 时，你只是改变了该 `dfs` 方法栈帧内的局部变量 `prev` 的指向，使其指向了 `root`。这**不会影响**调用者（上一层 `dfs`）中的 `prev` 变量，也不会影响后续兄弟节点递归调用时 `prev` 的初始值。
    - **后果**：当对左子树的 `dfs(left, prev)` 调用完成后返回时，当前 `dfs` 方法栈帧中的 `prev` 仍然是进入左子树之前的值。因此，当接着调用 `dfs(right, prev)` 时，它使用的 `prev` 是错误的——它应该是左子树展开后链表的尾节点，但实际上它还是当前 `root` 的父节点（或者是最初传入的 `prev`）。
- **`prev.right = root;` 的逻辑错误导致连接覆盖：**
    - 由于问题1，当 `dfs(root, prev)` 处理完其左子树 `dfs(left, prev)` 后，`prev` 并没有更新为左子树链表的尾部。
    - 然后调用 `dfs(right, prev)`，此时的 `prev` 仍然是 `root` 节点的“前一个”节点（即当前递归层次的父节点对应的 `prev`）。如果此时 `prev.right` 已经被左子树中的某个节点占据，那么在处理右子树时，它会被 `prev.right = root;` (这里的 `root` 是右子节点) 覆盖，从而丢失了左子树的连接。