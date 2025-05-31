---
layout: default
title: BipartiteGraph
narrow: true
---
Determine if an undirected graph is bipartite. A bipartite graph is one in which the nodes can be divided into two groups such that no nodes have direct edges to other nodes in the same group.
**目标**：判定无向图是否为二分图，并给出（可选的）两色着色方案。

**Examples**

1  --   2

    /   

3  --   4

is bipartite (1, 3 in group 1 and 2, 4 in group 2).

1  --   2

    /   |

3  --   4

is not bipartite.

**Assumptions**
- The graph is represented by a list of nodes, and the list of nodes is not null.
***
- 答题思路：
- BFS + 双色着色。时间 `O(V + E)`
- 维护HashMap用于表示节点的颜色
- Initial State: 遍历所有节点，如果该节点没有颜色，则着色并入队，开始bfs
- 在每轮bfs中
	- Expand: 提取队首x
	- Generate：遍历x的所有临界点y，同时检查
		- 若 `y` 尚未着色 → 赋对应颜色并入队。  
		- 若 `y` 已着色 → 检查颜色是否与 `x` 相反；
	- Termination: 队列空或检测出冲突
	- Deduplicate：标记了颜色的点不需要再入队
***
```java
public boolean isBipartite(List<GraphNode> graph) {  
    if (graph == null || graph.size() <= 1){  
        return true;  
    }  
    Queue<GraphNode> queue = new LinkedList<>();  
    HashMap<GraphNode,Integer> color = new HashMap<>();  
    for (GraphNode graphNode : graph) {  
        if (!color.containsKey(graphNode)) {  
            queue.offer(graphNode);  
            color.put(graphNode, 0);  
            if (!bfs(queue, color)) {  
                return false;  
            }  
        }  
    }  
    return true;  
}  
public boolean bfs(Queue<GraphNode> q, HashMap<GraphNode,Integer> color){  
    while(!q.isEmpty()){  
        GraphNode cur = q.poll();  
        Integer anoColor = color.get(cur) ^ 1;  
        for(GraphNode next: cur.neighbors){  
            if (!color.containsKey(next)){  
                color.put(next,anoColor);  
                q.offer(next);  
            }else{  
                if (color.get(next).equals(color.get(cur))){  
                    return false;  
                }  
            }  
        }  
    }  
    return true;  
}
```