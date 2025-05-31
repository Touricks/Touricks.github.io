---
layout: default
title: N Queen
narrow: true
---

https://app.laicode.io/app/problem/233?plan=3

Get all valid ways of putting N Queens on an N \* N chessboard so that no two Queens threaten each other.

**Assumptions**

- N > 0

**Return**

- A list of ways of putting the N Queens
- Each way is represented by a list of the Queen's y index for x indices of 0 to (N - 1)

**Example**

N = 4, there are two ways of putting 4 queens:

[1, 3, 0, 2] --> the Queen on the first row is at y index 1, the Queen on the second row is at y index 3, the Queen on the third row is at y index 0 and the Queen on the fourth row is at y index 2.

[2, 0, 3, 1] --> the Queen on the first row is at y index 2, the Queen on the second row is at y index 0, the Queen on the third row is at y index 3 and the Queen on the fourth row is at y index 1.

---

Signature： dfs(len, index, cand, res)
有 len 个皇后，目前在第 index 行放第 index 个皇后，目前的解是 cand，解集是 res
Base Case：index == len, 收集解
level：棋盘大小：len
分支：每列，共 len 个
dfs rule：如果我决定放在第 index 行的第 yi 列，则对于小于 index 的每个放置皇后，需满足
`|yi-yk| != |index-k|`
使用 swapswap 方法：使我们不需要判断是否列上有重复皇后

```java
public List<List<Integer>> nqueens(int n) {
    List<List<Integer>> res = new ArrayList<>();
    List<Integer> cand = new ArrayList<>();
    for(int i=0;i<n;i++){
        cand.add(i);
    }
    dfs(n,0,cand,res);
    return res;
}

private void dfs(int n, int index, List<Integer> cand, List<List<Integer>> res) {
    if (index == n){
        res.add(new ArrayList<>(cand));
        return;
    }
    for(int i=index;i<n;i++){
        swap(cand,index,i);
        if (isValid(cand,index)){
            dfs(n,index+1,cand,res);
        }
        swap(cand,index,i);
    }
}
private boolean isValid(List<Integer> cand, int row){
    int col = cand.get(row);
    for(int i=0;i<row;i++){
        if (Math.abs(row-i) == Math.abs(col-cand.get(i))){
            return false;
        }
    }
    return true;
}
private void swap(List<Integer> s, int i, int j){
    int temp = s.get(i);
    s.set(i,s.get(j));
    s.set(j,temp);
}
```
