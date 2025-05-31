---
layout: default
title: RemoveAllAdjcentDuplicates
narrow: true
---
https://leetcode.com/problems/remove-all-adjacent-duplicates-in-string-ii/description/

You are given a string `s` and an integer `k`, a `k` **duplicate removal** consists of choosing `k` adjacent and equal letters from `s` and removing them, causing the left and the right side of the deleted substring to concatenate together.

We repeatedly make `k` **duplicate removals** on `s` until we no longer can.

Return _the final string after all such duplicate removals have been made_. It is guaranteed that the answer is **unique**.

**Example 1:**

**Input:** s = "abcd", k = 2
**Output:** "abcd"
**Explanation:** There's nothing to delete.

**Example 2:**

**Input:** s = "deeedbbcccbdaa", k = 3
**Output:** "aa"
**Explanation:** 
First delete "eee" and "ccc", get "ddbbbdaa"
Then delete "bbb", get "dddaa"
Finally delete "ddd", get "aa"

**Example 3:**

**Input:** s = "pbbcggttciiippooaais", k = 2
**Output:** "ps"

Constraints
- `1 <= s.length <= 10^5`
- `2 <= k <= 10^4`
***
- 我需要一堆数，而且需要具备回头看的能力 -> stack
- 我要回头看多少 -> `10^4`, 因此不能用slow一步步回退的方式回头看
- 我们构造一个node来表示一个数已经连续出现的次数
```java
class Node{
	char ch;
	int count;
}
```

High level: Iterate each elements based on stack, for each elements, check back its last elements and update occurrence if needed, if one elements occurs k times, remove it
- Iterate each elements and update stack
	- stack is empty -> add to stack
	- stack is NOT empty
		- char = top's character => count++
			- if count == stopCount => pop()
		- char != top's character => add to stack

- Finally, add to result

```java
class Node{  
    Character ch;  
    int count;  
    public Node(char ch){  
        this.ch = ch;  
        this.count = 1;  
    }  
}  
public String removeDuplicates(String s, int k) {  
    Deque<Node> stack = new LinkedList<>();  
    for(int i=0;i<s.length();i++){  
        char ch = s.charAt(i);  
        if (stack.isEmpty() || stack.peek().ch != ch){  
            stack.push(new Node(ch));  
        }else{  
            if (stack.peek().count+1 == k){  
                stack.pop();  
            }else{  
                stack.peek().count++;  
            }  
        }  
    }  
    StringBuilder sb = new StringBuilder();  
    while(!stack.isEmpty()){  
        Node cur = stack.pop();  
        for(int i=0;i<cur.count;i++){  
            sb.append(cur.ch);  
        }  
    }  
    sb.reverse();  
    return sb.toString();  
}
```