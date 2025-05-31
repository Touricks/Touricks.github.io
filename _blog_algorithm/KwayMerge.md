---
layout: default
title: KwayMerge
narrow: true
---
https://app.laicode.io/app/problem/133?plan=3

- Merge K sorted array into one big sorted array in ascending order.
- **Assumptions**
- The input arrayOfArrays is not null, none of the arrays is null either.
***
- **初始化：**
    - 创建一个 `Node` 类来存储元素的值、它所属数组的索引 (`idxArray`) 以及它在该数组中的索引 (`idxInArray`)。
    - 初始化一个空的最小优先队列 (`pq`)。优先队列将存储 `Node` 对象，并按它们的 `value` 排序。
    - 初始化一个空列表 (`res`) 来存储合并后的元素。
- **填充初始堆：**
    - 遍历 `arrayOfArrays` 中的每个输入数组。
    - 如果一个数组不为 null 且不为空，则为其第一个元素创建一个 `Node`。
    - 将这个 `Node` 添加到优先队列中。
- **合并过程：**
    - 当优先队列不为空时：
        - 从优先队列中提取具有最小 `value` 的 `Node`（即 `cur`）。
        - 将 `cur.value` 添加到 `res` 列表中。
        - 确定 `cur` 来自哪个数组 (`arrayOfArrays[cur.idxArray]`)。
        - 如果该数组中还有更多元素（即 `arr.length > cur.idxInArray + 1`），则为该数组中的下一个元素 (`arr[cur.idxInArray+1]`) 创建一个新的 `Node`。
        - 将这个新的 `Node` 添加到优先队列中。
- **最终结果：**
    - 将 `res` 列表（现在包含所有按排序顺序排列的元素）转换为一个整型数组并返回。

- 思考：如果数组的数量 `k` 非常大，以至于由于内存限制，您无法将 `k` 个 `Node` 对象放入优先队列中，应该如何处理：
- Solution：
	- **分治（生成初始顺串/归并段）：**
	    - 确定一次可以在优先队列中舒适地管理多少个数组
	    - 将 `k` 个输入数组分成若干组，每组 `m` 个数组。
	    - 对于每组，执行 `m` 路合并。
	    - 每次 `m` 路合并的结果将是一个新的、更大的有序数组。这些顺串通常会写入临时存储
	- **递归合并（合并顺串）：**
	    - 现在有了 `k/m` 个新的有序顺串。
	    - 如果 `k/m` 仍然太大，无法将其首元素放入优先队列，则重复此过程：将这 `k/m` 个顺串分成可管理的 `m'` 个一组，然后合并它们。
	    - 递归地继续此过程，直到只剩下一个最终的有序顺串。

```java
class Node{  
    int value;  
    int idxInArray;  
    int idxArray;  
    public Node(int value,int idxarr,int idxInarr){  
        this.value = value;  
        this.idxArray = idxarr;  
        this.idxInArray = idxInarr;  
    }  
  
}  
public int[] merge(int[][] arrayOfArrays) {  
    PriorityQueue<Node> pq = new PriorityQueue<>(new Comparator<Node>(){  
        @Override  
        public int compare(Node one, Node other){  
            return one.value-other.value;  
        }  
    });  
    for(int i=0;i<arrayOfArrays.length;i++){  
        if (arrayOfArrays[i] == null || arrayOfArrays[i].length == 0){  
            continue;  
        }  
        Node num = new Node(arrayOfArrays[i][0],i,0);  
        pq.add(num);  
    }  
    List<Integer> res = new ArrayList<>();  
    while(!pq.isEmpty()){  
        Node cur = pq.poll();  
        res.add(cur.value);  
        int[] arr = arrayOfArrays[cur.idxArray];  
        if (arr.length > cur.idxInArray+1){  
            Node newNum = new Node(arr[cur.idxInArray+1],cur.idxArray,cur.idxInArray+1);  
            pq.add(newNum);  
        }  
    }  
    int[] result = new int[res.size()];  
    for(int i=0;i<res.size();i++){  
        result[i] = res.get(i);  
    }  
    return result;  
}
```