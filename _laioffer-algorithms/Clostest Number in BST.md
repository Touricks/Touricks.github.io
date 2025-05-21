https://app.laicode.io/app/problem/504?plan=3
In a binary search tree, find k nodes containing the closest numbers to the given target number. return them in sorted array

**Assumptions:**

- The given root is not null.
- There are no duplicate keys in the binary search tree.

**Examples:**

    5

  /    \

2      11

     /    \

    6     14

closest number to 4 is 5

closest number to 10 is 11

closest number to 6 is 6

***
```java
public int[] closestKValues(TreeNode root, double target, int k) {  
    // slow: the left bound  
    // fast: the right element to be processing    
    // solution region: [slow,fast), where fast-slow=k   
    List<Integer> inorder = new ArrayList<>();  
    getInorder(inorder,root);  
    int slow = 0;  
    int fast = k;  
    // corner case
    if (k >= inorder.size()){  
        int[] res = new int[inorder.size()];  
        for(int i=0;i<inorder.size();i++){  
            res[i] = inorder.get(i);  
        }  
        return res;  
    }  
    while(fast < inorder.size()){  
        if (Math.abs(inorder.get(fast)-target)-Math.abs(inorder.get(slow)-target)>0){  
            break;  
        }  
        fast++;  
        slow++;  
    }  
    int[] res = new int[k];  
    for(int i=0;i<k;i++){  
        res[i] = inorder.get(i+slow);  
    }  
    return res;  
}  

public void getInorder(List<Integer> inorder, TreeNode root){  
    if (root == null){  
        return;  
    }  
    TreeNode helper = root;  
    Deque<TreeNode> stack = new LinkedList<>();  
    while(!stack.isEmpty() || helper != null){  
        if (helper != null){  
            stack.push(helper);  
            helper = helper.left;  
        }else{  
            helper = stack.pop();  
            inorder.add(helper.key);  
            helper = helper.right;  
        }  
    }  
}
```