---
layout: default
title: Parentheses-Problem3
narrow: true
---
https://app.laicode.io/app/problem/642?plan=3
Get all valid permutations of l pairs of (), m pairs of <> and n pairs of {}, subject to the priority restriction: {} higher than <> higher than ().

Assumptions

    l, m, n >= 0

    l + m + n >= 0

Examples

    l = 1, m = 1, n = 0, all the valid permutations are ["()<>", "<()>", "<>()"].

    l = 2, m = 0, n = 1, all the valid permutations are [“()(){}”, “(){()}”, “(){}()”, “{()()}”, “{()}()”, “{}()()”].
***
```java
public List<String> validParenthesesIII(int l, int m, int n) {  
    int[] left = new int[3];  
    int[] right = new int[3];  
    int[] target = new int[]{l, m, n};  
    List<String> res = new ArrayList<>();  
    StringBuilder sb = new StringBuilder();  
    if (l==0 && m==0 && n==0){  
        return res;  
    }  
    int total = (l+m+n)*2;  
    char[] par = new char[]{'(','<','{',')','>','}'};  
    Deque<Integer> stack = new LinkedList<>();  
    dfs(par,target,left,right,total,0,res,sb,stack);  
    return res;  
}  
public void dfs(char[] par, int[] target, int[] left, int[] right, int total, int cur, List<String> res, StringBuilder sb,Deque<Integer> stack){  
    if (cur == total){  
        res.add(sb.toString());  
        return;  
    }  
    for(int i=0;i<3;i++){  
        if (left[i] < target[i] && (stack.isEmpty() || i<stack.peek())){  
            sb.append(par[i]);  
            left[i]++;  
            stack.push(i);  
            dfs(par,target,left,right,total,cur+1,res,sb,stack);  
            sb.deleteCharAt(sb.length()-1);  
            left[i]--;  
            stack.pop();  
        }  
    }  
    for(int i=0;i<3;i++){  
        if (right[i]<left[i] && !stack.isEmpty() && stack.peek() == i){  
            sb.append(par[i+3]);  
            right[i]++;  
            stack.pop();  
            dfs(par,target,left,right,total,cur+1,res,sb,stack);  
            sb.deleteCharAt(sb.length()-1);  
            right[i]--;  
            stack.push(i);  
        }  
    }  
}
```