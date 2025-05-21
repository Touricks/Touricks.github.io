---
layout: default
title: BFS
narrow: true
"aliases:": BFS_alg
---

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

## Tree-层次遍历

- 核心：记录当前层的节点个数
  [Cousin in Binary Tree](/algorithmn-notes/cousininbinarytree.html)
  [Print Tree in zig-zag ways](/algorithmn-notes/printtreeinzig-zagways.html)
  [Reconstruct Binary Search Tree With Level Order](/algorithmn-notes/reconstructbinarysearchtreewithlevelorder.html)

## 最短路相关

| 场景           | 主要算法     | 边权特点           | 标记数组名称        | 何时置 `true`      | 还能否再入队/堆       |
| -------------- | ------------ | ------------------ | ------------------- | ------------------ | --------------------- |
| **无权图**     | BFS          | 全部权 = 1         | `visited`           | **入队时**         | 否                    |
| **可能含负边** | SPFA         | 可正、可负         | `inQueue`           | 入队时；出队时清   | 可以（当距 离被松弛） |
| **无负边**     | **Dijkstra** | we≥0 \,w_e \ge 0\, | `visited`/`settled` | **从最小堆弹出时** | 否 ⇒ 距离已确定       |

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

[UnweightedGraph](/algorithmn-notes/unweightedgraph.html)
[Dijkstra](/algorithmn-notes/dijkstra.html)

- HashSet, TreeSet 与 PriorityQueue

| 结构            | **排序依据**                | **唯一性** | **判重依据**          |
| --------------- | --------------------------- | ---------- | --------------------- |
| `PriorityQueue` | `Comparator` / `Comparable` | **不**去重 | _无_（可重复）        |
| `TreeSet`       | `Comparator` / `Comparable` | 去重       | `compare(x,y)==0`     |
| `HashSet`       | 无序                        | 去重       | `hashCode` + `equals` |

[HashSet-TreeSet-PriorityQueue-API](/algorithmn-notes/hashset-treeset-priorityqueue-api.html)

- 因此，若`compareTo(x,y)==0` **但** `x.equals(y)==false`，则`add(x)` 之后再 `add(y)` → 第二次会被视为"重复"并被忽略；
- `x.equals(y)==true` **但** `compareTo(x,y)!=0` -> - 把 _逻辑上相等_ 的两个对象加入 `TreeSet` — 它们会被当成**不同节点**存两份；

TreeMap 和 HashMap 的比较:维持"全局有序"——TreeMap 最核心的额外工作

1. **比较而非取哈希**
   - 每一次 `put` / `get` 都要 `compare()`（或 `compareTo()`）。
2. **自平衡（红黑树约束）**
   - 插入或删除可能破坏平衡，TreeMap 通过 **O(1)** 次旋转 + 重染色修复。
   - 任何时刻树高 ≤ `2 log₂(n+1)`，保证操作 `O(log n)`。
3. TreeMap 基于"有序"特性提供的**前驱 / 后继 / 区间**检索方法
   • `firstKey()` / `lastKey()` — 最小 / 最大键  
   • `lowerKey(k)` — `‹ k` 的最大键  
   • `floorKey(k)` — `≤ k` 的最大键  
   • `ceilingKey(k)` — `≥ k` 的最小键  
   • `higherKey(k)` — `› k` 的最小键
