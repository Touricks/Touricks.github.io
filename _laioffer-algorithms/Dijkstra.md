---
layout: default
title: Dijkstra
narrow: true
---

[1928. Minimum Cost to Reach Destination in Time](https://leetcode.com/problems/minimum-cost-to-reach-destination-in-time/)
There is a country of `n` cities numbered from `0` to `n - 1` where **all the cities are connected** by bi-directional roads. The roads are represented as a 2D integer array `edges` where `edges[i] = [xi, yi, timei]` denotes a road between cities `xi` and `yi` that takes `timei` minutes to travel. There may be multiple roads of differing travel times connecting the same two cities, but no road connects a city to itself.

Each time you pass through a city, you must pay a passing fee. This is represented as a **0-indexed** integer array `passingFees` of length `n` where `passingFees[j]` is the amount of dollars you must pay when you pass through city `j`.

In the beginning, you are at city `0` and want to reach city `n - 1` in `maxTime` **minutes or less**. The **cost** of your journey is the **summation of passing fees** for each city that you passed through at some moment of your journey (**including** the source and destination cities).

Given `maxTime`, `edges`, and `passingFees`, return _the **minimum cost** to complete your journey, or_ `-1` _if you cannot complete it within_ `maxTime` _minutes_.

---

普通的 Dijkstra 可以使用`List<List<neighbour>> graph`建图后通过 visited 限制重复访问同一个点，但根本原因是 priorityqueue 后面 poll 出的节点代价不可能比第一次大

然而在这题中，dist 的不确定可能使一个 cost 更低的方案事实上无效。我们必须确定每一个 dist 对应的 cost，因为我们的 visited 数组必须是二维 —— `visited[len][maxTime+1]`，或者，不用这个优化

同时，注意边是否有向，以及我们关注的第一优先级，是 "距离" 还是 "费用"

```java
class Plan implements Comparable<Plan>{
    int vertex;
    int dist;
    int cost;
    public Plan(int v, int dist, int cost){
        this.vertex = v;
        this.dist = dist;
        this.cost = cost;
    }
    @Override
    public int compareTo(Plan other){
        return this.cost - other.cost;
    }
}
class Node{
    int nxt;
    int dist;
    public Node(int x, int d){
        this.nxt = x;
        this.dist = d;
    }
}
public int minCost(int maxTime, int[][] edges, int[] passingFees) {
    List<List<Node>> adj = new ArrayList<>();
    int len = passingFees.length;
    for(int i=0;i<len;i++){
        adj.add(new ArrayList<>());
    }
    for(int i=0;i<edges.length;i++){
        List<Node> cur = adj.get(edges[i][0]);
        cur.add(new Node(edges[i][1],edges[i][2]));
        cur = adj.get(edges[i][1]);
        cur.add(new Node(edges[i][0],edges[i][2]));
    }
    int[][] dp = new int[len][maxTime+1];
    for(int i=0;i<dp.length;i++){
        for(int j=0;j<dp[0].length;j++){
            dp[i][j] = Integer.MAX_VALUE;
        }
    }
    dp[0][0] = passingFees[0];
    PriorityQueue<Plan> pq = new PriorityQueue<>();
    pq.add(new Plan(0,0,passingFees[0]));
    while (!pq.isEmpty()){
        Plan cur = pq.poll();
        if (cur.vertex == len-1){
            return cur.cost;
        }
        if (cur.dist > maxTime){
            continue;
        }
        List<Node> neighbour = adj.get(cur.vertex);
        for (Node nei: neighbour){
            if (nei.dist + cur.dist > maxTime){
                continue;
            }
            if (dp[nei.nxt][nei.dist+cur.dist] > dp[cur.vertex][cur.dist] + passingFees[nei.nxt]){
                dp[nei.nxt][nei.dist+cur.dist] = dp[cur.vertex][cur.dist] + passingFees[nei.nxt];
                pq.add(new Plan(nei.nxt,nei.dist+cur.dist,cur.cost+passingFees[nei.nxt]));
            }
        }
    }
    return -1;
}
```
