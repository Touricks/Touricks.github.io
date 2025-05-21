Implement an iterative, in-order traversal of a given binary tree, return the list of keys of each node in the tree as it is in-order traversed.

**Examples**

        5

      /    \

    3        8

  /   \        \

1      4        11

In-order traversal is [1, 3, 4, 5, 8, 11]

**Corner Cases**

- What if the given binary tree is null? Return an empty list in this case.

**How is the binary tree represented?**

We use the level order traversal sequence with a special symbol "#" denoting the null node.

**For Example:**

The sequence [1, 2, 3, #, #, 4] represents the following binary tree:

    1

  /   \

 2     3

      /

    4


***

- 核心思路：
- cur表示当前处理的节点，但是当前处理的节点不一定是目标节点，因为左-根-右
- 用一个指针 `cur` 从根开始，**不断往左压栈**，直到 `cur==null`。然后 **弹出栈顶**（此时它没有未访问的左孩子了），做访问操作；再令 `cur = 弹出节点.right`，回到第一步，继续往左压栈。

```java
public List<Integer> inOrder(TreeNode root) {
    Deque<TreeNode> stack = new LinkedList<>();
    List<Integer> res = new ArrayList<>();
    if (root == null){
      return res;
    }
    TreeNode cur = root;
    while(cur != null || !stack.isEmpty()){
    // 不断往左，沿途把当前节点“自己”压栈，下一步要回头访问它
      while(cur != null){
        stack.push(cur);
        cur = cur.left;
      }
    // 左边走到头了，弹出最近压的节点，访问它
      cur = stack.pop();
      res.add(cur.key);
	// 访问完，就转向它的右子树，继续“压左”流程
      cur = cur.right;
    }
    return res;
  }
```