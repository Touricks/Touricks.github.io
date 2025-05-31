---
layout: default
title: LongestSlope
narrow: true
---
https://app.laicode.io/app/problem/217?plan=3

Given an array of 2D coordinates of points (all the coordinates are integers), find the largest number of points that can form a set such that any pair of points in the set can form a line with positive slope. Return the size of such a maximal set.

**Assumptions**

- The given array is not null
- Note: if there does not even exist 2 points can form a line with positive slope, should return 0.

**Examples**

- <0, 0>, <1, 1>, <2, 3>, <3, 3>, the maximum set of points are {<0, 0>, <1, 1>, <2, 3>}, the size is 3.
***
 - 易错点：
	- Comparator class在声明之后需要实例化，sort或priorityQueue接受的比较器是一个instance，不是class
	- 注意题目要求：
		- 如果没有两个点符合要求时返回什么
		- 按x轴排序后就和LIS一模一样了吗？还有什么需要注意的细节？
- 注意：
	- globalMax为1时的特殊处理
	- 横坐标相等时的处理
	- Comparator的应用，需要实例化后再作为参数传入method（这里可没有injection）
```java
package DP;  
  
import java.util.Arrays;  
import java.util.Comparator;  
  
class Point {  
   public int x;  
   public int y;  
   public Point(int x, int y) {  
     this.x = x;  
     this.y = y;  
   }  
 }  
class PointComparator implements Comparator<Point>{  
    @Override  
    public int compare(Point one, Point two){  
        return Integer.compare(one.x,two.x);  
    }  
}  
  
public class p217 {  
    public int largest(Point[] points) {  
        if (points == null || points.length == 0){  
            return 0;  
        }  
        PointComparator pc = new PointComparator();  
        Arrays.sort(points,pc);  
        int[] dp = new int[points.length];  
        for(int i=0;i<dp.length;i++){  
            dp[i] = 1;  
        }  
        int globalMax = 1;  
        for(int i=0;i<points.length;i++){  
            for(int j=0;j<i;j++){  
                if (points[i].x > points[j].x && points[i].y > points[j].y && dp[i] < dp[j]+1){  
                    dp[i] = dp[j]+1;  
                }  
            }  
            globalMax = Math.max(globalMax,dp[i]);  
        }  
        if (globalMax == 1){  
            return 0;  
        }  
        return globalMax;  
    }  
}
```