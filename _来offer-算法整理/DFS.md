# 综述
- DFS核心特征：问题的解不需要合并，探索到树底部即可获得答案（的一部分）
- DFS题目的Comment需要包含：
	- Base Case，什么时候收集解
	- 有多少层，每层代表的意思 (How many level, Each level meaning)
	- 每层可以扩展的状态数 (Possible states from each level)

- Recursion和DFS比较
- Pure Recursion
	- 从下到上地构建solution，一定是先拿到子问题的结果，再做原问题
- DFS Backtracking
	- 先在当前层做完自己的事情，以干完的状态去不同的下一层，从上到下
- 相同点：都是基于Recursion实现（自己调用自己）的，不同的是构建解的顺序

## Linear
## Tree
## Graph
