
Given a collection of candidate numbers (C) and a target number (T), find all unique combinations in C where the candidate numbers sums to T. The same repeated number may be chosen from C unlimited number of times.

All numbers (including target) will be positive integers.
Elements in a combination (a1, a2, … , ak) must be in non-descending order.
The solution set must not contain duplicate combinations.

Example
    given candidate set 2,3,6,7 and target 7,
    A solution set is:
     [7]
     [2, 2, 3]
***
- Method1: 每层思考一个元素，思考加几个
	- 层数：input中元素的个数
	- 分支：当前rem最多能被累加几个当前层考虑的candidate
	- base case: index = length, target = 0时加结果


- Method2：每层思考一个位置
	- 分支：input中的所有元素
	- 层数：最小的那个input中的元素能够被减几次
- dfs rule: 从当前index开始往后看，依次尝试加一个元素来到当前的位置，dfs往下走
- 代码中使用candidate.length表示选项个数，index表示已经走到哪一个元素。为了避免重复，我们不能选index之前的元素
- base case：rem == 0加结果，index == len做base case的保障
```
               [root]
          /    |     \      \
        [2]   [3]   [6]    [7]
       / | \    |  …      (直接就是 [7] 完成)
    [2,3,6,7] [3,6,7]

```

- Method1
```java
class Solution {
    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        // for each level, could choose 0 or more element to fill
        List<List<Integer>> result = new ArrayList<>();
        if (candidates == null || candidates.length == 0) {
            return result;
        }
        List<Integer> cur = new ArrayList<>();
        helper(candidates, 0, cur, result, target);
        return result;
    }
    // dfs signature: input, cur path, index, result
    private void helper(int[] nums, int index, List<Integer> cur, List<List<Integer>> result, int target) {
        // base case
        if (index == nums.length) {
            if (target == 0) {
                result.add(new ArrayList<>(cur));
            }
            return;
        }
        // add one or more ele
        for (int i = 0; i <= target / nums[index]; i++) {
            int times = i; // i表示我加几个
            while (times > 0) { // 用来做add的，加几个
                cur.add(nums[index]);
                times--;
            }
            helper(nums, index + 1, cur, result, target - i * nums[index]);
            while (times < i) { // 帮助吐
                cur.remove(cur.size() - 1);
                times++;
            } 
        }
    }
}
```

- Method2
```java
class Solution {
    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        // for each level, pick from index i, only care the last index we pick
        if (candidates == null || candidates.length == 0) {
            return new ArrayList<>();
        }
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> cur = new ArrayList<>();
        helper(candidates, target, 0, cur, result);
        return result;
    }
    
    private void helper(int[] candidates, int remain, int level, List<Integer> cur, List<List<Integer>> result) {
        // base case
        if (remain == 0) {
            result.add(new ArrayList<>(cur));
            return;
        }
	  // 帮你兜底
        if (level == candidates.length || remain < 0) {
            return;
        }
        // induction rule
        for (int i = level; i < candidates.length; i++) {
            cur.add(candidates[i]);
            helper(candidates, remain - candidates[i], i, cur, result);
            cur.remove(cur.size() - 1);
        }
    }
}
```