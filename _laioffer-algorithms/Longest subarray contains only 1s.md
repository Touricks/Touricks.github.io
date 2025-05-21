https://app.laicode.io/app/problem/625?plan=3
Given an array of integers that contains only 0s and 1s and a positive integer k, you can flip at most k 0s to 1s, return the longest subarray that contains only integer 1 after flipping.

Assumptions:

1. Length of given array is between [1, 20000].

2. The given array only contains 1s and 0s.

3. 0 <= k <= length of given array.

Example 1:

Input: array = [1,1,0,0,1,1,1,0,0,0], k = 2

Output: 7

Explanation: flip 0s at index 2 and 3, then the array becomes [1,1,1,1,1,1,1,0,0,0], so that the length of longest subarray that contains only integer 1 is 7.

Example 2:

Input: array = [1,1,0,0,1,1,1,0,0,0], k = 0

Output: 3

Explanation: k is 0 so you can not flip any 0 to 1, then the length of longest subarray that contains only integer 1 is 3.
***
- 由于可以把k个0翻成1，我们设一个变量存储还可以翻的次数

```java
public int longestConsecutiveOnes(int[] nums, int k) {  
    // Write your solution here  
    int slow = 0;  
    int fast = 0;  
    int best = 0;  
    int flipLeft = k;  
    while(fast < nums.length){  
        if (nums[fast] == 1 || (nums[fast] == 0 && flipLeft>0)){  
            best = Math.max(best,fast-slow+1);  
            if (nums[fast] == 0){  
               flipLeft--;  
           }  
        }else{  
            while(nums[slow] == 1){  
                slow++;  
            }  
            slow++;  
        }  
        fast++;  
    }  
    return best;  
}
```