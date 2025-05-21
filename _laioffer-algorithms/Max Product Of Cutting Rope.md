https://app.laicode.io/app/problem/87?plan=3
Given a rope with positive integer-length _n_, how to cut the rope into _m_ integer-length parts with length _p_[0], _p_[1], ...,_p_[_m_-1], in order to get the maximal product of _p_[0]*_p_[1]* ... *_p_[_m_-1]? _m_ **is determined by you** and must be greater than 0 **(at least one cut must be made**). Return the max product you can have.

**Assumptions**

- n >= 2

**Examples**

- n = 12, the max product is 3 * 3 * 3 * 3 = 81(cut the rope into 4 pieces with length of each is 3).
***
State：dp[i] the largest product ending at length = i
Base Case dp[0] = 0 
Induction Rule `dp[i] = Math.max(Max(dp[j],j)*(i-j))`
Result dp[n]

```java
public int maxProduct(int length) {  
    int[] dp = new int[length+1];  
    dp[0] = 0;  
    for(int i=1;i<=length;i++){  
        for(int j=0;j<i;j++){  
            dp[i] = Math.max(dp[i],Math.max(dp[j],j)*(i-j));  
        }  
    }  
    return dp[length];  
}
```

