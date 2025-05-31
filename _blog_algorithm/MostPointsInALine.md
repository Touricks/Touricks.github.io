---
layout: default
title: MostPointsInALine
narrow: true
---
https://app.laicode.io/app/problem/216

Given an array of 2D coordinates of points (all the coordinates are integers), find the largest number of points that can be crossed by a single line in 2D space.

**Assumptions**

- The given array is not null and it has at least 2 points

**Examples**

- <0, 0>, <1, 1>, <2, 3>, <3, 3>, the maximum number of points on a line is 3(<0, 0>, <1, 1>, <3, 3> are on the same line)
***
- 对一个固定点o，使用HashMap表示和o连成的线的斜率为x的数量
- 特殊情况：
	- 原点：额外维护一个值same
	- 斜率为正无穷：额外维护一个值slopeInfinite

```java
public int most(Point[] points) {  
    int res = 0;  
    if (points == null || points.length == 0){  
        return 0;  
    }  
    for(int i=0;i<points.length;i++){  
        Point cur = points[i];  
        HashMap<Double, Integer> count = new HashMap<>();  
        int same = 0;  
        int slopeInf = 0;  
        int best = 0;  
        for(int j=0;j<points.length;j++){  
            Point other = points[j];  
            if (cur.x == other.x && cur.y == other.y){  
                same++;  
            }else if (cur.x == other.x){  
                slopeInf++;  
            }else{  
                double slope = 1.0*(other.y-cur.y)/(other.x-cur.x);  
                count.putIfAbsent(slope,0);  
                count.put(slope,count.get(slope)+1);  
                if (count.get(slope) > best){  
                    best = count.get(slope);  
                }  
            }  
        }  
        res = Math.max(res,same+Math.max(best,slopeInf));  
    }  
    return res;  
}
```