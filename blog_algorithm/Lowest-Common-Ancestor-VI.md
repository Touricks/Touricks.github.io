---
layout: default
title: Lowest-Common-Ancestor-VI
narrow: true
---
https://app.laicode.io/app/problem/648?plan=3
Given M nodes in a K-nary tree, find their lowest common ancestor.

Assumptions

- M >= 2.

- There is no parent pointer for the nodes in the K-nary tree.

- The given M nodes are guaranteed to be in the K-nary tree.

Examples

        5  

      /   \

     9   12

   / | \      \

  1 2 3     14
  
The lowest common ancestor of 2, 3, 14 is 5.
The lowest common ancestor of 2, 3, 9 is 9.
***
```java
public KnaryTreeNode lowestCommonAncestor(KnaryTreeNode root, List<KnaryTreeNode> nodes) {  
    HashSet<KnaryTreeNode> set = new HashSet<>();  
    for(KnaryTreeNode node: nodes){  
        set.add(node);  
    }  
    return find(root,set);  
}  
public KnaryTreeNode find(KnaryTreeNode root, HashSet<KnaryTreeNode> set){  
    if (root == null || set.contains(root)){  
        return root;  
    }  
    KnaryTreeNode find1 = null;  
    KnaryTreeNode find2 = null;  
    for(KnaryTreeNode child: root.children){  
        if (find1 == null){  
            find1 = find(child,set);  
        }else if (find2 == null){  
            find2 = find(child,set);  
        }else{  
            return root;  
        }  
    }  
    if (find1!= null && find2 != null){  
        return root;  
    }  
    return find1;  
}
```