---
layout: default
title: Kth-Smallest-In-Matrix
narrow: true
---
- https://app.laicode.io/app/problem/26?plan=3

Given a matrix of size N x M. For each row the elements are sorted in ascending order, and for each column the elements are also sorted in ascending order. Find the Kth smallest number in it.

**Assumptions**

- the matrix is not null, N > 0 and M > 0
- K > 0 and K <= N * M

**Examples**

{ {1,  3,   5,  7},

  {2,  4,   8,   9},

  {3,  5, 11, 15},

  {6,  8, 13, 18} }

- the 5th smallest number is 4
- the 8th smallest number is 6
***
- 核心在于如何去重，这里我们使用了最复杂的方法：抽象每个位置为一个node，设立class，override相关函数实现HashSet来进行去重
```java
class Node implements Comparable<Node> {  
    int x;  
    int y;  
    int value;  
    public Node(int x, int y, int value) {  
        this.x = x;  
        this.y = y;  
        this.value = value;  
    }  
    @Override  
    public int compareTo(Node other){  
        return compare(this,other);  
    }  
    public int compare(Node o1, Node o2) {  
        return Integer.compare(o1.value, o2.value);  
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
        return this.x * 31 + this.y;  
    }  
}  
public int kthSmallest(int[][] matrix, int k) {  
    // 类似kway merge的图形版  
    HashSet<Node> visited = new HashSet<>();  
    PriorityQueue<Node> pq = new PriorityQueue<>();  
    if (matrix == null || matrix.length == 0 || matrix[0].length == 0){  
        return -1;  
    }  
    if (k > matrix.length*matrix[0].length){  
        return -1;  
    }  
    pq.add(new Node(0,0,matrix[0][0]));  
    Node curNode = null;  
    for(int i=0;i<k;i++){  
        curNode = pq.poll();  
        if (i == k-1){  
           break;  
        }  
        if (curNode.x+1 < matrix.length){  
            int nx = curNode.x+1;  
            int ny = curNode.y;  
            int nvalue = matrix[nx][ny];  
            if (!visited.contains(new Node(nx,ny,nvalue))){  
                Node newNode = new Node(nx,ny,nvalue);  
                pq.add(newNode);  
                visited.add(newNode);  
            }  
        }  
        if (curNode.y+1 < matrix[0].length){  
            int nx = curNode.x;  
            int ny = curNode.y+1;  
            int nvalue = matrix[nx][ny];  
            if (!visited.contains(new Node(nx,ny,nvalue))){  
                Node newNode = new Node(nx,ny,nvalue);  
                pq.add(newNode);  
                visited.add(newNode);  
            }  
        }  
    }  
    return curNode.value;  
}
```