---
layout: default
title: Kth-Closest-Point-To-(0,0,0)
narrow: true
---
Given three arrays sorted in ascending order. Pull one number from each array to form a coordinate <x,y,z> in a 3D space. Find the coordinates of the points that is k-th closest to <0,0,0>.

We are using euclidean distance here.

**Assumptions**

- The three given arrays are not null or empty, containing only non-negative numbers
- K >= 1 and K <= a.length * b.length * c.length

**Return**

- a size 3 integer list, the first element should be from the first array, the second element should be from the second array and the third should be from the third array

**Examples**

- A = {1, 3, 5}, B = {2, 4}, C = {3, 6}
    
- The closest is <1, 2, 3>, distance is sqrt(1 + 4 + 9)
    
- The 2nd closest is <3, 2, 3>, distance is sqrt(9 + 4 + 9)
***
- 易错点：
	- 循环终止条件一定要一开始写上（在这里为count++）
	- 明确题目要我们返回的值是什么：是index还是`a[index]`
	- hashCode函数产生方法:`Objects.hash(需要考虑的值)`
	- 对于double类型的问题，需要额外考虑
		- 避免浮点数和开方运算：用平方和代替取根号，节约空间
	- 可以使用`Array.asList`快速创建ArrayList列表

```java
public double getDis(int[] a, int[] b, int[] c, int posa, int posb, int posc) {  
    return Math.sqrt(Math.pow(a[posa], 2) + Math.pow(b[posb], 2) + Math.pow(c[posc], 2));  
}  
  
public List<Integer> closest(int[] a, int[] b, int[] c, int k) {  
    PriorityQueue<Node> pq = new PriorityQueue<>();  
    HashSet<Node> visited = new HashSet<>();  
    Node start = new Node(0, 0, 0, a[0] + b[0] + c[0]);  
    pq.add(start);  
    visited.add(start);  
    int count = 0;  
    Node cur = null;  
    while (count < k) {  
        cur = pq.poll();  
        if (cur.posInA < a.length - 1) {  
            Node next = new Node(cur.posInA + 1, cur.posInB, cur.posInC, getDis(a, b, c, cur.posInA + 1, cur.posInB, cur.posInC));  
            if (!visited.contains(next)) {  
                pq.add(next);  
                visited.add(next);  
            }  
        }  
        if (cur.posInB < b.length - 1) {  
            Node next = new Node(cur.posInA, cur.posInB + 1, cur.posInC, getDis(a, b, c, cur.posInA, cur.posInB + 1, cur.posInC));  
            if (!visited.contains(next)) {  
                pq.add(next);  
                visited.add(next);  
            }  
        }  
        if (cur.posInC < c.length - 1) {  
            Node next = new Node(cur.posInA, cur.posInB, cur.posInC + 1,  getDis(a, b, c, cur.posInA, cur.posInB, cur.posInC + 1));  
            if (!visited.contains(next)) {  
                pq.add(next);  
                visited.add(next);  
            }  
        }  
        count++;  
    }  
    List<Integer> result = new ArrayList<>();  
    result.add(cur.posInA);  
    result.add(cur.posInB);  
    result.add(cur.posInC);  
    return result;  
}
```