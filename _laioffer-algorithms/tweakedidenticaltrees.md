---
layout: default
title: TweakedIdenticalTrees
narrow: true
---

Determine whether two given binary trees are identical assuming any number 'tweak's are allowed. A tweak is defined as a swap of the children of one node in the tree.

**Examples**

       5

     /    \

3 8

/ \

1 4

and

       5

     /    \

8 3

        /    \

       1       4

the two binary trees are tweaked identical.

**How is the binary tree represented?**

We use the level order traversal sequence with a special symbol "#" denoting the null node.

---

- Function

```java
boolean isTweakedIdentical(TreeNode one, TreeNode two)
```

Given two root of binary tree , find if the two tree is tweaked identical

- Base Case
  if (one == null && two == null) -> true
  if (one == null && two != null) -> false
  if (one != null && two == null) -> false

- Subproblem
  由于能有无数个 tweaked，因此两个子树如何交换后相等，也可以返回 true
  isTweakedIdentical(one.left,two.right) && isTweakedIdentical(one.right,two.left)
  当然也可以不交换
  isTweakedIdentical(one.left,two.left) && isTweakedIdentical(one.right,two.right)
- Recursive Rule
  // one and two are both not null after running base case
  if (one.value != two.value) -> false
  之后，如果在满足 base case 条件后两个 subproblem 有一个能返回 true，则返回 true

- Code

```java
public boolean isTweakedIdentical(TreeNode one, TreeNode two) {
    if (one == null && two == null){
      return true;
    }
    if (one == null || two == null){
      return false;
    }
    if (one.key != two.key){
      return false;
    }
    boolean plan1 = isTweakedIdentical(one.left,two.right) && isTweakedIdentical(one.right,two.left);
    boolean plan2 = isTweakedIdentical(one.left,two.left) && isTweakedIdentical(one.right,two.right);
    return plan1 || plan2;
  }
```
