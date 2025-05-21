Check if a given binary tree is symmetric.

**Examples**

        5

      /    \

    3        3

  /   \    /   \

1      4  4      1

is symmetric.

        5

      /    \

    3        3

  /   \    /   \

1      4  1      4

is not symmetric.

**Corner Cases**

- What if the binary tree is null? Return true in this case.

***
- Function
public boolean isSymmetric(TreeNode root)
- return true if tree whose root is given is symmetric

- Base case
	- root == null -> return true
	- root.left == null && root.right == null -> return true
	- root.left == null || root.right == null -> return false
- Subproblem
	- isSymmetric（ root.left ）
	- isSymmetric ( root.right )

- Recursive rule:
	- 发现问题：如果只写 `isSymmetric(root.left)` 和 `isSymmetric(root.right)`，你只能各自检查左右子树本身是不是对称结构，但无法保证「左子树的左节点」对应「右子树的右节点」，「左子树的右节点」对应「右子树的左节点」之间的值和结构相同。
	- 为此，由于每一步都要同时知道两个节点（一个来自左子树、一个来自右子树）才能判断它们的值是不是相等，以及它们的子树是否镜像对称。
	- 为了对称检查要求“左的左” ⇄ “右的右”，“左的右” ⇄ “右的左”。这种交叉的关系，必须在一个函数里同时持有两个指针才能自然地往下递归。

- Function
```
public boolean isMirror(TreeNode one, TreeNode two)
```
如果两个分别以one，two为根的子树相互对称，则返回true

- Base Case
	- one== null && two == null -> return true
	- one== null || two == null -> return false
	- one.key != two.key -> return false

 - Cost
```java
public boolean isSymmetric(TreeNode root) {
    if (root == null){
      return true;
    }
    return isSymmetric(root.left,root.right);
  }
  public boolean isSymmetric(TreeNode r1, TreeNode r2){
    if (r1 == null && r2 == null){
      return true;
    }
    if (r1 == null || r2 == null){
      return false;
    }
    if (r1.key != r2.key){
      return false;
    }
    return isSymmetric(r1.left,r2.right) && isSymmetric(r1.right,r2.left);
  }
```