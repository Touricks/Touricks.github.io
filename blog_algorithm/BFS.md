---
layout: default
title: BFS
narrow: true
---

```table-of-contents

```

## 综述

定义：从根节点开始，沿着图的宽度遍历图的节点，所有节点被不重复的访问一次
实现方法：Queue(BFS1) / PriorityQueue(BFS2)

答题步骤
Step1：Data Structure：Queue/PriorityQueue, 装的类型是什么
Step2：Corner Case && Initial State
Step3：每一轮 Expand（queue.pop()）的意义是什么
Step4：Generate 的条件是什么？如何 Generate？
Step5：Termination Condition 是什么
Step6：Deduplication 策略是什么？在入队前置 visited=true 是否可行

## Tree 层次遍历

- 核心：记录当前层的节点个数
- 如果当前节点的信息来源于"同一个深度的子树"，则我们必须使用双参数对左右子树同时处理，换句话说，如果不想极大提高空间复杂度，就不要尝试从左右子树的返回值中收集信息
  - [Cousin in Binary Tree](/algorithmn-notes/cousin-in-binary-tree.html)
- 常见题型：zig-zag
  - 使用 Deque，可以快速对字符串/列表的首尾进行 O(1)的增删
  - [Print Tree in zig-zag ways](/algorithmn-notes/print-tree-in-zig-zag-ways.html)
- 使用 Inorder 和 LevelOrder 进行树的还原
  - [Reconstruct Binary Tree With Level Order](/algorithmn-notes/reconstruct-binary-tree-with-level-order.html)

## 图相关

- 二分图：要把一个图里面的每个点分且之分成两个组，使得同组之间的点一定不互相连接，不同组之间的点可以互相连接
  - 二分图不需要联通
- 二分图染色问题 - [BipartiteGraph](/algorithmn-notes/bipartitegraph.html)
- 七巧板问题
  - 将图信息压缩到固定位数的数字 -> 字符串中
  - 可转移状态数取决于 0 的位置
  - [SevenPuzzle](/algorithmn-notes/sevenpuzzle.html)
- Word Ladder
  - 将图信息压缩到字符串中
  - 可转移状态数取决于词典字符串与当前状态的关系
  - [WordLadder](/algorithmn-notes/wordladder.html)

### 拓扑排序

- 我们需要两个数据结构来存图的关系，两个数据结构维持拓扑排序：
  - 边集`Map<Node, Set<Node>>`
  - 点集`Map<Node, Integer>`
  - 拓扑排序实现：Queue
  - 结果记录：List/StringBuilder
- 例题
  - [CourseSchedule](/algorithmn-notes/courseschedule.html)
    - 使用 Integer 表示 Node
  - [AlienDictionary](/algorithmn-notes/aliendictionary.html)
    - 使用 Character 表示 Node

### 启发式搜索：双向 BFS+按层遍历

对于 WordLadder 这一题，我们有明确的起点和终点，因此我们可以不再仅仅从 `beginWord` 开始搜索，而是同时从 `beginWord` 和 `endWord` 开始两个独立的 BFS 搜索，当这两个搜索在中间相遇时即停止。
首先我们要明确以下观点：

#### **为什么双向 BFS 更快？**

可以将搜索过程想象成一个不断扩大的圆圈。

- 单向 BFS 需要将其搜索范围（半径/深度）扩大到 `D`。访问的节点（圆圈面积）数量大约与 bD 成正比（其中 `b` 是分支因子）。
- 双向 BFS 则扩展两个圆圈，每个圆圈的半径仅为 `D/2`。访问的节点总数大约为 **2×b^D/2**。
  对于大多数情况而言，`2×b^D/2` 的值远小于 `b^D`。这极大地减少了需要探索的节点数量。

#### **如何实现双向 BFS**

1. **数据结构**：您需要为两个搜索方向分别准备一套数据结构。
   - `Queue<String> q_start`, `Queue<String> q_end` （两个队列）
   - `HashMap<String, Integer> dist_start`, `HashMap<String, Integer> dist_end` （两个哈希表，用于记录距离和已访问状态）
2. **初始化**：
   - 将 `beginWord` 添加到 `q_start` 和 `dist_start` (距离为 1)。
   - 将 `endWord` 添加到 `q_end` 和 `dist_end` (距离为 1)。
   - **重要**：首先检查 `endWord` 是否存在于字典中。如果不存在，直接返回 0。
3. **搜索循环**：
   - 在主循环的每一次迭代中，选择扩展两个队列中**size 较小的一个**。这是一个关键的启发式策略，能让两个搜索范围大致保持同等大小，从而最大化效率。
   - 假设您从 `start` 方向扩展，先记录下当前 q_start 的大小，然后对 q_start 取 size 次元素。这个策略的目标是让从起点和终点开始的两个搜索"圆圈"能以相近的速度扩张，从而尽可能在中间相遇。（有些类似层次遍历，但双向 BFS 里我们通过层次遍历控制两个方向的扩展深度相似）
   - 对于每个邻居 `next`：
     - **检查相遇**：在做任何其他事情之前，检查 `next` 是否存在于**另一个方向**的距离哈希表中 (`dist_end.containsKey(next)`)。如果存在，说明两个搜索已经相遇！最短路径总长度为 `dist_start.get(cur) + dist_end.get(next)`。
     - 如果未相遇，则检查 `next` 是否已被**当前方向**的搜索访问过 (`!dist_start.containsKey(next)`)。如果未访问，则将其加入 `q_start` 和 `dist_start`。

- 双向 BFS 优化时间复杂度**只在单点到单点求最短路径中才能体现**
  - 例如 Pacific Atlantic 用双向 BFS 不能降低复杂度

| 特性         | Word Ladder (单词接龙)                                 | Pacific Atlantic (太平洋大西洋水流)                                      |
| ------------ | ------------------------------------------------------ | ------------------------------------------------------------------------ |
| 问题目标     | 找到从 beginWord 到 endWord 的 一条最短路径。          | 找到 所有 既能到达太平洋、又能到达大西洋的 点的集合。                    |
| 起点         | 单个 起点 (beginWord)                                  | 多个 起点（所有太平洋沿岸格子，是一个集合）                              |
| 终点         | 单个 终点 (endWord)                                    | 多个 终点（所有大西洋沿岸格子，是另一个集合）                            |
| 搜索停止条件 | 当从起点开始的搜索与从终点开始的搜索 相遇时 即可停止。 | 必须等待两个方向的搜索都完全结束，得到两个完整的可达集合后，才能求交集。 |
| 优化本质     | 提前中止搜索，避免探索整个图的绝大部分区域。           | 无法提前中止，因为目标是找到完整的可达集合。                             |

- 例题：
  - Word Ladder；题目相同，但使用双向 BFS 实现
  - [WordLadder2](/algorithmn-notes/wordladder2.html)

### 打印路径：单向 BFS+DFS Backtracking

- 对于需要打印路径的 BFS 题目，我们需要在 BFS 基础上维护一个 DAG，表示当前状态可以由哪些状态转移而来
- 因此，在这一步，我们不仅要找最短路径，还要构建 `parents` 哈希表，它代表了一个包含所有最短路径的有向无环图 (DAG)。
- `Map<State,List<State>>`, 不同题目的 State 不同，在 WordLadder 这道题 State 是 String
- 同时，我们还需要一个 `Map<State, Integer> dist` 来记录每个状态距起点的最优值。

- 以 WordLadder 为例
  **BFS 的循环逻辑如下：**
- 对于从队列中取出的每个 `currentWord`，我们找到它的所有邻居 `nextWord`

1. **如果 `nextWord` 从未被访问过**：
   - 这是第一次找到通往 `nextWord` 的最短路径。
   - 记录它的距离：`dist.put(nextWord, dist.get(currentWord) + 1)`。
   - 将 `currentWord` 作为它的**第一个父节点**存入：
   - 将 `nextWord`入队
   - 更新`nextWord`的距离状态

```java
prev = new ArrayList<>()
prev.add(currentWord)
map.put(nextWord,prev)
queue.offer(nextWord)
dist.put(nextWord,curDist+1)
```

2. **如果 `nextWord` 已经被访问过 (最关键的部分)**：
   - 我们需要检查，当前这条通过 `currentWord` 到达 `nextWord` 的路径，是否**也是一条最短路径**。
   - 检查条件：`if (dist.get(nextWord) == dist.get(currentWord) + 1)`
   - 如果条件成立，说明我们找到了另一条长度相同的最短路径。这时，我们**不能覆盖，而是要添加**
   - 将 `currentWord` **追加**到 `nextWord` 的父节点列表中：`parents.get(nextWord).add(currentWord);`
   - 此时，**不需要**将 `nextWord` 再次加入队列，因为它已经在更早的层级被处理过了。

```java
if (dist.get(next) == distToCur+1){
    List<String> pre = prev.get(next);
    pre.add(cur);
    }
```

[WordLadder3](/algorithmn-notes/wordladder3.html)

## 最短路相关

| 场景           | 主要算法     | 边权特点           | 标记数组名称        | 何时置 `true`      | 还能否再入队/堆       |
| -------------- | ------------ | ------------------ | ------------------- | ------------------ | --------------------- |
| **无权图**     | BFS          | 全部权 = 1         | `visited`           | **入队时**         | 否                    |
| **可能含负边** | SPFA         | 可正、可负         | `inQueue`           | 入队时；出队时清   | 可以（当距 离被松弛） |
| **无负边**     | **Dijkstra** | we≥0 \,w_e \ge 0\, | `visited`/`settled` | **从最小堆弹出时** | 否 ⇒ 距离已确定       |

无权图
顶点第一次出现在队列中时，其层数 = 源点到它的最小边数。  
因此把 `visited[v]=true` 放在 **入队** 就等价于"锁定"最短层，后面即便再遇到 `v`，其路径长度 ≥ 已知最短层，不需要再考虑。

Dijkstra

- 当所有边权非负时，从优先队列（最小堆）中第一次弹出的顶点 u 的距离 `dist[u]` 一定已经是最短路；之后再发现更短路不可能。
- 因此只有在 **出堆** 的那一刻才能安全地把 `visited[u] = true`
  SPFA
- `inQueue` ≠ "最短路已确定"
- 入队时 enqueue，出队 dequeue → 保证同一顶点不会并发重复排队。
- 松弛成功 → 允许重新压回队列
- 借助 `relaxCount`（入队次数）即可在 `≥ N` 次时判定负环。

[无权图](/algorithmn-notes/unweighted-graph.html)
[Dijkstra](/algorithmn-notes/dijkstra.html)
