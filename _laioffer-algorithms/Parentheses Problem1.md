https://app.laicode.io/app/problem/66?plan=3
Given N pairs of parentheses “()”, return a list with all the valid permutations.

**Assumptions**

- N > 0

**Examples**

- N = 1, all valid permutations are ["()"]
- N = 3, all valid permutations are ["((()))", "(()())", "(())()", "()(())", "()()()"]
***
- 每层决定一个位置
	- left表示当前已经放的左括号个数，right表示当前还需要放的右括号个数
	- Base Case：left == N && right == 0 收集结果
	- level：2N
	- 分支：如果left<N, 可以放左括号，如果right>0,可以放右括号
- 复杂度（4^N）
```
[root]
|
[(]
|    \
[(()]  [()]
|
...
```
- 思考：为什么每层决定一个元素的方法，以及swap-swap方法不适合

>“每层决定一个元素” = 针对 _元素集合_ 做 include/exclude（顺序无关）
- 这里的元素只有两种括号，而且它们**出现多次且不可区分**；如果把“第 i 层 = 把元素 `'('` 是否放进结果”——
    - 你得连放几次都要记录（因为 `'('` 有 N 个副本），
    - 还得在某处再排列这些元素形成序列 → 又回到了“按位置”。
- 写出来会变成“两层嵌套”（先决定选几个 `'('`，再给它们排顺序），复杂且没有优势。
    
> swap-swap 是典型的 **全排列生成器**，默认所有元素互不相同。
- 括号串里有大量重复字符：
    - 直接交换会产生 `C(2N, N)` 条 _所有左/右括号的排列_，需要 O(2N) 再检查是否平衡；    
    - 绝大多数都是非法或重复序列，时间浪费巨大。    
- 如果这题使用swap-swap
	- 1. 把 2N 个字符当成完全不同的元素；
	- 2. 第 i 层把第 i 个位置与后面任何一个元素交换。
- **枚举条数**：`(2N)!`
- **每条串还得 O(2N) 检验是否合法**。
- TC:(2N)!

```java
public List<String> validParentheses(int n) {  
    List<String> res = new ArrayList<>();  
    StringBuilder sb = new StringBuilder();  
    dfs(n,0,0,res,sb);  
    return res;  
}  
public void dfs(int len, int left, int right,List<String> res, StringBuilder sb){  
    if (left == len && right == 0){  
        res.add(sb.toString());  
        return;  
    }  
    if (left < len){  
        sb.append('(');  
        dfs(len,left+1,right+1,res,sb);  
        sb.deleteCharAt(sb.length()-1);  
    }  
    if (right > 0){  
        sb.append(')');  
        dfs(len,left,right-1,res,sb);  
        sb.deleteCharAt(sb.length()-1);  
    }  
}
```