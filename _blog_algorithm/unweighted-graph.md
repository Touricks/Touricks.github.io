---
layout: default
title: 无权图
narrow: true
---
https://leetcode.com/problems/shortest-path-in-binary-matrix/description/
Given an `n x n` binary matrix `grid`, return _the length of the shortest **clear path** in the matrix_. If there is no clear path, return `-1`.

A **clear path** in a binary matrix is a path from the **top-left** cell (i.e., `(0, 0)`) to the **bottom-right** cell (i.e., `(n - 1, n - 1)`) such that:

- All the visited cells of the path are `0`.
- All the adjacent cells of the path are **8-directionally** connected (i.e., they are different and they share an edge or a corner).

The **length of a clear path** is the number of visited cells of this path
```
**Input:** grid = [[0,0,0],[1,1,0],[1,1,0]]
**Output:** 4

**Input:** grid = [[1,0,0],[1,1,0],[1,1,0]]
**Output:** -1
```
***
无权图最短路径 - BFS
`Queue<Node>`, Node: x,y
Corner Case: Node = target return
Expand: 在第k轮我们扩展到的位置
Generate：如果目标未被访问，则访问并标记。由于是无权图，第一次访问即为最短路，标记visit防止重复入队
Deduplication：设置visit，表示某个位置上的节点是否入队

```java
	final int[] dx = new int[]{0,0,1,1,1,-1,-1,-1};
    final int[] dy = new int[]{-1,1,1,0,-1,1,0,-1};
    class Node{
        int x;
        int y;
        int step;
        public Node(int x, int y,int step){
            this.x = x;
            this.y = y;
            this.step = step;
        }
        @Override
        public boolean equals(Object other){
            if (this == other){
                return true;
            }
            if (other == null || this.getClass() != other.getClass()){
                return false;
            }
            Node node = (Node)other;
            return this.x == node.x && this.y == node.y;
        }
        @Override
        public int hashCode(){
            return this.x*100+this.y;
        }
    }
    public boolean inBound(int len,int[][] grid,int x,int y){
        if (x >= 0 && x < len && y >= 0 && y < len && grid[x][y] == 0){
            return true;
        }
        return false;
    }
    public int shortestPathBinaryMatrix(int[][] grid) {
        if (grid == null || grid.length == 0){
            return 0;
        }
        boolean[][] visited = new boolean[grid.length][grid.length];
        Deque<Node> queue = new LinkedList<>();
        visited[0][0] = true;
        if (grid[0][0] == 1){
            return -1;
        }
        queue.addLast(new Node(0,0,1));
        int len = grid.length;
        while(!queue.isEmpty()){
            Node cur = queue.pollFirst();
            if (cur.x == len-1 && cur.y == len-1){
                return cur.step;
            }
            for(int i=0;i<8;i++){
                int nextx = cur.x+dx[i];
                int nexty = cur.y+dy[i];
                int step = cur.step + 1;
                if (inBound(len,grid,nextx,nexty) && !visited[nextx][nexty]){
                    queue.addLast(new Node(nextx,nexty,step));
                    visited[nextx][nexty] = true;
                }
            }
        }
        return -1;
    }

```