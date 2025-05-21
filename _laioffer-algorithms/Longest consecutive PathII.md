https://www.lintcode.com/problem/614/
给定一棵二叉树，找到最长连续序列(单调且相邻节点值相差为1)路径的长度(节点数)。  
路径起点跟终点可以为二叉树的任意节点。
```
输入:
{1,2,0,3}
输出:
4
解释:
    1
   / \
  2   0
 /
3
0-1-2-3
```
```
输入:
{3,2,2}
输出:
2
解释:
    3
   / \
  2   2
2-3
```
***
Step1 Signature
```
int[] dfs(root,ans)
```
- 由于从子树出发，升序和降序对当前节点是有影响的，所以我们返回两个值，装在一个int[]中
- int[0] 从root出发的最长递增序列长度
- int[1] 从root出发的最长递减序列长度

Step2 Base Case
root = null return {0,0}
root = leaf return {1,1}

Step3 Subproblem
left = dfs(root.left,ans)
right = dfs(root.right,ans)

Step4: Recursive Rule
left[0] = 0 if left.key != root.key+1
left[1] = 0 if left.key != root.key-1
right同理

ans = MAX(left[0]+right[1]+1,left[1]+right[0]+1)
Inc = MAX(left[0],right[0])+1
Dec = MAX(left[1],right[1])+1
return new int[]{Inc,Dec};

- Code
```java
public int longestConsecutive2(TreeNode root) {
        int[] ans = new int[]{Integer.MIN_VALUE};
        dfs(root,ans);
        return ans[0];
    }
public int[] dfs(TreeNode root, int[] ans){
	if (root == null){
		return new int[]{0,0};
	}
	int[] left = dfs(root.left,ans);
	int[] right = dfs(root.right,ans);
	left[0] = (root.left != null && root.left.val == root.val+1)? left[0] : 0;
	left[1] = (root.left != null && root.left.val == root.val-1)? left[1] : 0;
	right[0] = (root.right != null && root.right.val == root.val + 1)? right[0] : 0;
	right[1] = (root.right != null && root.right.val == root.val - 1)? right[1] : 0;
	int cand = Math.max(left[0]+right[1]+1,left[1]+right[0]+1);
	ans[0] = Math.max(ans[0],cand);
	int Inc = Math.max(left[0],right[0]) + 1;
	int Dec = Math.max(left[1],right[1]) + 1;
	return new int[]{Inc,Dec};
}
```