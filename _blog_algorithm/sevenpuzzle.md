---
layout: default
title: SevenPuzzle
narrow: true
---
https://app.laicode.io/app/problem/681?plan=3

Given eight cards with number 0, 1, 2, ..7 on them, the cards are placed in two rows with 4 cards in each row. In each step only card 0 could swap with one of its adjacent(top, right, bottom, left) card. Your goal is to make all cards placed in order like this:

0 1 2 3

4 5 6 7

Find the minimum number of steps from the given state to the final state. If there is no way to the final state, then return -1.

The state of cards is represented by an array of integer, for example [0,1,2,3,4,5,6,7] where the first four numbers are in the first row from left to right while the others are placed in the second row from left to right. 

Example: 

Input: [4,1,2,3,5,0,6,7]       Output: 2

Explanation:

Initial state is:

4 1 2 3

5 0 6 7

First swap 0 with 5, then the state is:

4 1 2 3

0 5 6 7

Then swap 0 with 4, then we get the final state:

0 1 2 3

4 5 6 7
***
- Step1： BFS，`Queue<String>`存储以String表示的待探索的棋盘状态
- Step2：Base Case： 01234567是目标状态，我们从它作为basecase，放到queue中，开始搜索
	- 同时维护一个`Hashmap<String,Integer>`表示到达一个状态所需的步数
- Step3:  每次我们从queue中取head，尝试从这个head表示的棋盘状态扩展到新的状态。如果新的状态没有在Hashmap中出现过，则入队并加入Hashmap。由于这是一个无权图，所以我们不需要设置新的visited去重，每个状态第一次入队时距离一定为最优。
- Step4：Termination condition：找到目标棋盘，直接返回距离；否则当queue空时返回-1
- Step5：deduplication：通过hashset防止相同状态入队多次
***
Gemini修正版：
解决这个问题的最优方法是**反向广度优先搜索 (BFS)**。我们从最终的目标状态开始，反向探索，直到找到给定的初始状态。这种方法比从初始状态开始搜索效率更高。
数据结构
- **`Queue<String>` 队列**: 存储待探索的棋盘状态。
- **`HashMap<String, Integer>` 哈希表**: 核心数据结构，一举两得。
    1. **记录步数**: `key` 是棋盘状态 (字符串)，`value` 是从**目标状态**到达该状态所需的步数。
    2. **充当 visited 集合**: 通过检查 `map.containsKey()` 来判断一个状态是否已被访问，避免重复搜索。
Step1: Base Case
    - 将目标状态 `"01234567"` 添加到队列 `queue` 中。
    - 将目标状态和步数 `0` 存入哈希表 `map`，即 `map.put("01234567", 0)`。
Step2: Generate
    - 当队列不为空时，循环执行以下操作：
        - 从队列头部取出一个状态 `current_state`。
        - 找到 `current_state` 中字符 '0' 的位置（index）。
        - 根据 '0' 的位置，生成所有可以通过**一次交换**得到的相邻新状态 `next_state`。
        - 对于每一个新状态 `next_state`，检查它是否存在于哈希表 `map` 中。
            - 如果**不存在**，说明这是一个未曾访问过的新状态。将其存入哈希表，步数为 `map.get(current_state) + 1`，并将其加入队列尾部等待探索。
            - 如果**已存在**，则忽略，因为 BFS 保证了我们第一次遇到该状态的路径就是最短的。
Step3: Termination Rule
    - BFS 过程（即第二步）会一直执行直到队列为空，此时 `map` 中已经存储了从目标状态可以到达的**所有状态**及其对应的最少步数。
    - 此时，在 `map` 中查找问题给出的**初始状态**。
    - 如果 `map` 中**包含**初始状态，则返回其对应的步数 `map.get(initial_state)`。
***
易错点：如果我们用字符串表示棋盘状态，那么从一个状态上下左右转移时有什么限制？
- 上下：不越界(>=0, <8)
- 左右：不越界Only?

- 另外，要明确method的用途，切勿在method加入不属于这个method的代码来”节约“其他地方的代码

```java
public String swap(String str, int i, int j){  
    StringBuilder sb = new StringBuilder(str);  
    char temp = sb.charAt(i);  
    sb.setCharAt(i,sb.charAt(j));  
    sb.setCharAt(j,temp);  
    return sb.toString();  
}  
public List<String> getValidNeighbour(String str){  
    int index0 = str.indexOf('0');  
    List<Integer> opt = new ArrayList<>();  
    List<String> res = new ArrayList<>();  
    opt.add(index0-4);  
    opt.add(index0+4);  
    for(Integer next: opt){  
        if (next >= 0 && next < 8){  
            String candidate = swap(str,index0,next);  
            res.add(candidate);  
        }  
    }  
    if (index0 % 4 != 0){  
        res.add(swap(str,index0,index0-1));  
    }  
    if (index0 % 4 != 3){  
        res.add(swap(str,index0,index0+1));  
    }  
    return res;  
}  
public int bfs(String target){  
    Queue<String> queue = new LinkedList<>();  
    HashMap<String,Integer> dist = new HashMap<>();  
    String start = "01234567";  
    queue.offer(start);  
    dist.put(start,0);  
    if (start.equals(target)){  
        return 0;  
    }  
    while(!queue.isEmpty()){  
        String cur = queue.poll();  
        int dis = dist.get(cur);  
        List<String> next = getValidNeighbour(cur);  
        for(String nxt : next){  
            if (nxt.equals(target)){  
                return dis+1;  
            }  
            if (!dist.containsKey(nxt)){  
                queue.offer(nxt);  
                dist.put(nxt,dis+1);  
            }  
        }  
    }  
    return -1;  
}  
public int numOfSteps(int[] values) {  
    StringBuilder target = new StringBuilder();  
    for(int i=0;i<values.length;i++){  
        target.append(values[i]);  
    }  
    return bfs(target.toString());  
}
```