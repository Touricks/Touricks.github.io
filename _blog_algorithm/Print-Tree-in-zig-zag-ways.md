---
layout: default
title: Print-Tree-in-zig-zag-ways
narrow: true
---
Get the list of keys in a given binary tree layer by layer in zig-zag order.
**Examples**
        5

      /    \

    3        8

  /   \        \

 1     4        11

the result is [5, 3, 8, 11, 4, 1]

**Corner Cases**
- What if the binary tree is null? Return an empty list in this case.

**How is the binary tree represented?**
We use the level order traversal sequence with a special symbol "#" denoting the null node.

***
- S1：datastructure
	- `Deque<Integer>`
- S2: initial state:
	- put root in the deque
	- return empty list if null
	- maintain a variable indicating pollFirst/pollLast in next level
	- initially, leftToRight = false , means pollLast
- S3 expand
	- poll() means the current element in zig-zag order
- S4 generate
	- offer() elements of children
- S5: termination
	- empty deque

- 易错点：如何熟练运用Deque的性质，通过双端队列的插入+size（）的保存控制当前访问的元素合法性

```java
public List<Integer> zigZag(TreeNode root) {  
    List<Integer> res = new ArrayList<>();  
    if (root == null){  
        return res;  
    }  
    Deque<TreeNode> inQueue = new LinkedList<>();  
    inQueue.addLast(root);  
    boolean leftToRight = false;  
    while(!inQueue.isEmpty()) {  
        int size = inQueue.size();  
        for (int i = 0; i < size; i++) {  
            if (leftToRight){  
                TreeNode cur = inQueue.pollFirst();  
                res.add(cur.key);  
                if (cur.left != null) inQueue.offerLast(cur.left);  
                if (cur.right != null) inQueue.offerLast(cur.right);  
            }else{  
                TreeNode cur = inQueue.pollLast();  
                res.add(cur.key);  
                if (cur.right != null) inQueue.offerFirst(cur.right);  
                if (cur.left != null) inQueue.offerFirst(cur.left);  
            }  
        }  
        leftToRight = !leftToRight;  
    }  
    return res;  
}
```
