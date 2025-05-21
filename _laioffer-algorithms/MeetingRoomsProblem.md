## 题面
https://leetcode.com/problems/non-overlapping-intervals/description/
```
Given an array of intervals `intervals` where `intervals[i] = [starti, endi]`, return _the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping_.

**Note** that intervals which only touch at a point are **non-overlapping**. For example, `[1, 2]` and `[2, 3]` are non-overlapping.

**Example 1:**
**Input:** intervals = [[1,2],[2,3],[3,4],[1,3]]
**Output:** 1
**Explanation:** [1,3] can be removed and the rest of the intervals are non-overlapping.

**Example 2:**

**Input:** intervals = [[1,2],[1,2],[1,2]]
**Output:** 2
**Explanation:** You need to remove two [1,2] to make the rest of the intervals non-overlapping.

**Example 3:**

**Input:** intervals = [[1,2],[2,3]]
**Output:** 0
**Explanation:** You don't need to remove any of the intervals since they're already non-overlapping.
```

## 解法1：贪心

**贪心策略**
1. 把所有区间按结束时间 `eᵢ` 升序排序；
2. 依次扫描：遇到第一条与当前选中最后一条 **不冲突** 的区间就选进解集。
证明：
3. 最优子结构
若最优解 `OPT` 选了区间 `a`，把与 `a` 冲突的所有区间去掉，就得到一个**子问题**：

> 在剩下且开始时间 ≥ `eₐ` 的区间里选最大兼容集。  
> 该子问题的最优解 + `a` 构成原问题的最优解。 —— 这就是 **最优子结构**。

 4. 交换性质（核心）
- 设 `f` 是按结束时间最早的区间；`OPT` 的第一条区间记为 `o`。
- **若 `o = f`**：贪心与 `OPT` 同步，递归思路成立。
- **若 `o ≠ f`**：因为 `f` 的结束时间 ≤ `o`，所以 `f` 与 `o` 一定 **兼容** 后续所有 `OPT` 中的区间。  
    把 `o` 换成 `f` 得到新解 `OPT'`，区间个数不减。
    > 这样不断把最优解前缀“换成”贪心选区间，就能把任何 `OPT` 转成贪心解而丝毫不劣。
    
- 因此贪心方案至少与 `OPT` 等大 ⇒ **最优**。

## 解法2：DP
- 预处理：按结束时间升序排序
- State：dp[i] = 以第 i 个区间作为最后一个选择时，能得到的 “最多互不重叠区间” 数量
- 由于dp[i]并不是单调递增，但是我们可以让TreeMap里保存的entry做到value单调递增，从而在更新值时保证：`end越大，value一定越大`的单调属性，从而保证dp的最优子结构性质
```java
int eraseMin(int[][] iv) {
    Arrays.sort(iv, (a, b) -> a[1] - b[1]);         // 按 end 升序
    int n = iv.length;
    int[] dp = new int[n];

    TreeMap<Integer, Integer> best = new TreeMap<>();
    for (int i = 0; i < n; i++) {
        int s = iv[i][0], e = iv[i][1];

        // ① 查询 ≤ s 的最大 dp
        Map.Entry<Integer, Integer> ent = best.floorEntry(s);
        int prev = ent == null ? 0 : ent.getValue();
        dp[i] = prev + 1;

        // ② 仅当刷新前缀最大时才插入
        int prefixMax = best.isEmpty() ? 0 : best.lastEntry().getValue();
        if (dp[i] > prefixMax) {
            best.put(e, dp[i]);
        }
    }
    int keep = Arrays.stream(dp).max().getAsInt();
    return n - keep;              
}

```