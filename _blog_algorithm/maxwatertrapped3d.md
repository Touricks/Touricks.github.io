---
layout: default
title: MaxWaterTrapped3D
narrow: true
---
https://app.laicode.io/app/problem/200?plan=3

Given a non-negative integer 2D array representing the heights of bars in a matrix. Suppose each bar has length and width of 1. Find the largest amount of water that can be trapped in the matrix. The water can flow into a neighboring bar if the neighboring bar's height is smaller than the water's height. Each bar has 4 neighboring bars to the left, right, up and down side.

**Assumptions**

- The given matrix is not null and has size of M * N, where M > 0 and N > 0, all the values are non-negative integers in the matrix.

**Examples**

{ { 2, 3, 4, 2 },

  { 3, **1, 2,** 3 },

  { 4, 3, 5, 4 } }

the amount of water can be trapped is 3, 

at position (1, 1) there is 2 units of water trapped,

at position (1, 2) there is 1 unit of water trapped.
***
- 考虑1D接雨水的第三种解法：两边高度较低的那个决定了相邻位置接水的高度
- 套用到2D情景下：高度最低的外围墙面的相邻位置可以确定接水的最大高度，并成为新的”外围墙面“

```
visited[i][j] 表示对应位置是否已经尝试贡献结果
PriorityQueue<Point>表示进入队列的墙体
每次获取一个Point的坐标，其周围坐标如果没有被访问过，则最大高度为该Point对应的高度，更新答案
```
- 易错点：当在BFS中加入新的点`(nextx,nexty)`入队时，其 `height` 应该代表从这个节点出发去探索内部时，它能提供的“有效边界高度”，而不是这个节点本身的高度。
	1. **如果 `nexth < curh`**: 这意味着邻居节点 `(nextx, nexty)` 比当前的边界点 `curNode` 要低。水可以被 `curNode` (高度 `curh`) 困住，所以对于 `(nextx, nexty)` 这个点，可以计算 `curh - nexth` 的储水量。当 `(nextx, nexty)` 自身也成为新的边界去探索更内部的区域时，它能提供的“挡水高度”实际上还是由外围的 `curh` 决定的，因为它比 `curh` 低。如果此时将 `nexth` 加入优先队列，当它被取出时，`curh` 将会是 `nexth` 这个较低的值，导致后续基于这个低“水面”计算的储水量偏少或为0。   
	2. **如果 `nexth >= curh`**: 这意味着邻居节点 `(nextx, nexty)` 不低于（甚至高于）当前的边界点 `curNode`。它自身形成了一个新的、可能更高的边界。此时，它加入优先队列的高度自然就是 `nexth`。

- Code
```java
class Node implements Comparable<Node>{  
    int x;  
    int y;  
    int height;  
    @Override  
    public int compareTo(Node other){  
        return Integer.compare(this.height,other.height);  
    }  
    public Node(int x, int y, int z){  
        this.x = x;  
        this.y = y;  
        this.height = z;  
    }  
}  
public final int[] dx = new int[]{-1,1,0,0};  
public final int[] dy = new int[]{0,0,-1,1};  
  
public boolean inbound(int x,int y,int[][] matrix){  
    return x >= 0 && x < matrix.length && y >= 0 && y < matrix[0].length;  
}  
  
public int maxTrapped(int[][] matrix) {  
    if (matrix.length == 0 || matrix[0].length == 0){  
        return 0;  
    }  
    int result = 0;  
    PriorityQueue<Node> pq = new PriorityQueue<>();  
    int lenx = matrix.length;  
    int leny = matrix[0].length;  
    boolean[][] visited = new boolean[lenx][leny];  
    for(int i=0;i<lenx;i++){  
        Node node1 = new Node(i,0,matrix[i][0]);  
        Node node2 = new Node(i,leny-1,matrix[i][leny-1]);  
        visited[i][0] = true;  
        visited[i][leny-1] = true;  
        pq.add(node1);  
        pq.add(node2);  
    }  
    for(int i=1;i<leny-1;i++){  
        Node node1 = new Node(0,i,matrix[0][i]);  
        Node node2 = new Node(lenx-1,i,matrix[lenx-1][i]);  
        visited[0][i] = true;  
        visited[lenx-1][i] = true;  
        pq.add(node1);  
        pq.add(node2);  
    }  
    while(!pq.isEmpty()){  
        Node curNode = pq.poll();  
        int curx = curNode.x;  
        int cury = curNode.y;  
        int curh = curNode.height;  
        for(int i=0;i<4;i++){  
            int nextx = curx+dx[i];  
            int nexty = cury+dy[i];  
            if (inbound(nextx,nexty,matrix) && !visited[nextx][nexty]){  
                int nexth = matrix[nextx][nexty];  
                result += Math.max(0,curh-nexth);  
                Node newNode = new Node(nextx,nexty,Math.max(curh,nexth));  
                pq.add(newNode);  
                visited[nextx][nexty] = true;  
            }  
        }  
    }  
    return result;  
}
```