https://app.laicode.io/app/problem/641?plan=3
Given a set of characters represented by a String, return a list containing all subsets of the characters whose size is K. Notice that each subset returned will be sorted for deduplication.

Assumptions  

There could be duplicate characters in the original set.  


Examples

Set = "abc", K = 2, all the subsets are [“ab”, “ac”, “bc”].

Set = "abb", K = 2, all the subsets are [“ab”, “bb”].

Set = "abab", K = 2, all the subsets are [“aa”, “ab”, “bb”].

Set = "", K = 0, all the subsets are [""].

Set = "", K = 1, all the subsets are [].

Set = null, K = 0, all the subsets are [].
***
- Signature(index, curPos) 考虑到原串第index个元素，目前正在添加subset的第curPos个元素
- Base Case: k=curPos, 返回结果； index=len但curPos<k,无效结果
- level：最多len个,len=set.length();
- 分支：
	- 加当前元素
	- 不加当前元素，同时跳过之后所有相同元素

```java
public List<String>  subSetsIIOfSizeK(String set, int k) {  
    List<String> res = new ArrayList<>();  
    if (set == null){  
        return res;  
    }  
    char[] arr = new char[set.length()];  
    for(int i=0;i<set.length();i++){  
        arr[i] = set.charAt(i);  
    }  
    Arrays.sort(arr);  
    StringBuilder sb = new StringBuilder();  
    dfs(arr,arr.length,k,0,0,res,sb);  
    return res;  
}  
public void dfs(char[] arr, int len, int k, int curPos, int index, List<String> res, StringBuilder sb){  
    if (k == curPos){  
        res.add(sb.toString());  
        return;  
    }  
    if (len == index){  
        return;  
    }  
    sb.append(arr[index]);  
    dfs(arr,len,k,curPos+1,index+1,res,sb);  
    sb.deleteCharAt(sb.length()-1);  
    while(index+1 < len && arr[index+1] == arr[index]){  
        index++;  
    }  
    dfs(arr,len,k,curPos,index+1,res,sb);  
    // 不加当前元素，此时subset长度不变
}
```