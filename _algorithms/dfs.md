---
layout: post
title: DFS
date: 2024-05-13
categories: [算法]
tags: [算法, 深度优先搜索, 图论]
---

# DFS

深度优先搜索（Depth-First Search）是一种重要的图遍历算法，也常用于树形结构的遍历。

## 基本概念

1. 深度优先

   - 沿着一条路径一直搜索到底
   - 回溯时继续搜索其他路径

2. 应用场景
   - 图的遍历
   - 树的遍历
   - 迷宫问题
   - 排列组合问题

## 实现方式

### 1. 递归实现

```java
public void dfs(TreeNode node) {
    // Base case
    if (node == null) {
        return;
    }
    // 处理当前节点
    System.out.println(node.val);
    // 递归处理子节点
    dfs(node.left);
    dfs(node.right);
}
```

### 2. 迭代实现（使用栈）

```java
public void dfsIterative(TreeNode root) {
    if (root == null) {
        return;
    }
    Stack<TreeNode> stack = new Stack<>();
    stack.push(root);
    while (!stack.isEmpty()) {
        TreeNode node = stack.pop();
        System.out.println(node.val);
        if (node.right != null) {
            stack.push(node.right);
        }
        if (node.left != null) {
            stack.push(node.left);
        }
    }
}
```

## 常见应用

### 1. 二叉树遍历

```java
public List<Integer> preorderTraversal(TreeNode root) {
    List<Integer> result = new ArrayList<>();
    dfs(root, result);
    return result;
}

private void dfs(TreeNode node, List<Integer> result) {
    if (node == null) {
        return;
    }
    result.add(node.val);
    dfs(node.left, result);
    dfs(node.right, result);
}
```

### 2. 图的连通分量

```java
public int countComponents(int n, int[][] edges) {
    List<List<Integer>> graph = new ArrayList<>();
    for (int i = 0; i < n; i++) {
        graph.add(new ArrayList<>());
    }
    for (int[] edge : edges) {
        graph.get(edge[0]).add(edge[1]);
        graph.get(edge[1]).add(edge[0]);
    }
    boolean[] visited = new boolean[n];
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(graph, i, visited);
            count++;
        }
    }
    return count;
}

private void dfs(List<List<Integer>> graph, int node, boolean[] visited) {
    visited[node] = true;
    for (int neighbor : graph.get(node)) {
        if (!visited[neighbor]) {
            dfs(graph, neighbor, visited);
        }
    }
}
```

## 相关题目

- [Recursion]({{ "/algorithms/recursion.html" | relative_url }})
- [QuickSort LinkedList]({{ "/algorithms/quicksort-linkedlist.html" | relative_url }})

# 综述

- DFS 核心特征：问题的解不需要合并，探索到树底部即可获得答案（的一部分）
- DFS 题目的 Comment 需要包含：

  - Base Case，什么时候收集解
  - 有多少层，每层代表的意思 (How many level, Each level meaning)
  - 每层可以扩展的状态数 (Possible states from each level)

- Recursion 和 DFS 比较
- Pure Recursion
  - 从下到上地构建 solution，一定是先拿到子问题的结果，再做原问题
- DFS Backtracking
  - 先在当前层做完自己的事情，以干完的状态去不同的下一层，从上到下
- 相同点：都是基于 Recursion 实现（自己调用自己）的，不同的是构建解的顺序

## Linear

## Tree

## Graph
