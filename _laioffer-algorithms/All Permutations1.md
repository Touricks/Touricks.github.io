https://app.laicode.io/app/problem/64?plan=3
Given a string with no duplicate characters, return a list with all permutations of the characters.

Assume that input string is not null.

**Examples**

Set = “abc”, all permutations are [“abc”, “acb”, “bac”, “bca”, “cab”, “cba”]

Set = "", all permutations are [""]

***
dfs rule： 考虑第k个元素，将其与后续元素交换得到一个新state。对于每个新state扩展到下一层
base case: k=len,收集解
level:len层，level=k 表示考虑第k个位置的元素是什么
分支：len-k+1个

```java
public List<String> permutations(String input) {  
   char[] cur = new char[input.length()];  
   List<String> res = new ArrayList<>();  
   for(int i=0;i<input.length();i++){  
       cur[i] = input.charAt(i);  
   }  
   dfs(input,0,res,cur);  
   return res;  
}  
public void dfs(String input, int index, List<String> res, char[] cur){  
    if (index == input.length()){  
        res.add(new String(cur));  
        return;  
    }  
    for(int i = index;i < input.length();i++){  
        swap(cur,index,i);  
        dfs(input,index+1,res,cur);  
        swap(cur,index,i);  
    }  
}  
public void swap(char[] cur, int i, int j){  
    char temp = cur[i];  
    cur[i] = cur[j];  
    cur[j] = temp;  
}
```