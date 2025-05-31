---
layout: default
title: CourseSchedule
narrow: true
---

https://app.laicode.io/app/problem/430?plan=3

There are a total of *n* courses you have to take, labeled from `0` to `n - 1`.

Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is expressed as a pair: `[0,1]`

Given the total number of courses and a list of prerequisite pairs, return the ordering of courses you should take to finish all courses.

There may be multiple correct orders, you just need to return one of them. If it is impossible to finish all courses, return an empty array.

For example:

2, [1,0]

There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is `[0,1]`

4, [[1,0],[2,0],[3,1],[3,2]]

There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0. So one correct course order is `[0,1,2,3]`. Another correct ordering is`[0,2,1,3]`.

---

DataStructure

```java
Map<Integer, Set<Integer>> edges
Map<Integer, Integer> inDegree
Queue<Integer> topoQueue
List<Integer> res
```

```java
public int[] findOrder(int numCourses, int[][] prerequisites) {
    Map<Integer, Set<Integer>> edges = new HashMap<>();
    Map<Integer, Integer> inDegree = new HashMap<>();
    Queue<Integer> topoQueue = new LinkedList<>();
    List<Integer> res = new ArrayList<>();

    for(int i=0;i<numCourses;i++){
        edges.put(i,new HashSet<>());
        inDegree.put(i,0);
    }
    for(int i=0;i<prerequisites.length;i++){
        int[] rule = prerequisites[i];
        if (edges.get(rule[1]).add(rule[0])){
            inDegree.put(rule[0],inDegree.get(rule[0])+1);
        }
    }
    for(Map.Entry<Integer, Integer> entry : inDegree.entrySet()){
        if (entry.getValue() == 0){
            topoQueue.offer(entry.getKey());
        }
    }
    while(!topoQueue.isEmpty()){
        Integer course = topoQueue.poll();
        res.add(course);
        for(Integer next: edges.get(course)){
            inDegree.put(next,inDegree.get(next)-1);
            if (inDegree.get(next) == 0){
                topoQueue.offer(next);
            }
        }
    }
    if (res.size() != inDegree.size()){
        return new int[]{};
    }
    int[] result = new int[res.size()];
    int index = 0;
    for(Integer cur:res){
        result[index++] = cur;
    }
    return result;
}
```
