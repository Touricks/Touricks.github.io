---
layout: default
title: FirstNonrepeatingCharacter
narrow: true
---
https://www.lintcode.com/problem/960/

Given an unlimited stream of characters, find the first non-repeating character from stream. You need to tell the first non-repeating character in O(1) time at any moment.

我们需要实现一个叫 `DataStream` 的数据结构。并且这里有2个方法需要实现：
1. `void add(number)` // 加一个新的数
2. `int firstUnique()` // 返回第一个独特的数

- 与LRU非常相似

| 维度             | **首个唯一数数据结构** (`DataStream`)                                    | **LRU Cache**                                      |
| -------------- | --------------------------------------------------------------- | -------------------------------------------------- |
| **目标**         | 实时返回“迄今只出现过一次且最早出现”的元素                                          | 在固定容量内，快速读/写并按最近最少使用策略驱逐                           |
| **链表语义**       | 只保存 _frequency == 1_ 的节点，顺序＝插入顺序—一旦元素重复就从链表移除                   | 保存 _所有_ 缓存项，顺序＝最近使用→尾—`get/put` 都把命中节点移到尾部         |
| **驱逐机制**       | 没有容量上限；节点被“打重复”时立刻删除                                            | 有固定 `capacity`；满时**强制**删除链表头（最旧）                   |
| **HashMap 映射** | `num → node / null` - `null` 表示“出现过两次及以上” - 需判断 map 值是否为 `null` | `key → node` 永不设 `null`；键不会重复插入                    |
| **更新操作**       | `add(num)`： 已出现一次 → 删链表节点，置； `null`首次出现 → 新节点挂尾 ；已重复 → 忽略       | `get(k)`：命中移尾`put(k,v)`； 已存在 → 改值＋移尾； 新键且满 → 删头＋插尾 |
| **查询接口**       | `firstUnique()` 始终是 `head.next.key`                             | `get(k)` 返回值；若不存在返回 -1（或 `null`）                   |
| **易错点**        | 要用 `null` 区分“曾重复”与“未见过”                                         | 要同时更新链表和 map，保持大小一致                                |
```java
public class DataStream {  
    class Node{  
        int key;  
        Node prev;  
        Node next;  
        public Node(int key){  
            this.key = key;  
        }  
        public Node(){}  
    }  
    Node head = new Node();  
    Node tail = new Node();  
    HashMap<Integer, Node> map = new HashMap<>();  
      
    public DataStream(){  
         head.next = tail;  
         tail.prev = head;  
    }  
    /**  
     * @param num: next number in stream  
     * @return: nothing  
     */    public void add(int num) {  
        if (map.containsKey(num) && map.get(num) != null){  
            remove(map.get(num));  
            map.put(num,null);  
        }else if (!map.containsKey(num)){  
            Node cur = new Node(num);  
            addToTail(cur);  
            map.put(num,cur);  
        }  
    }  
  
    /**  
     * @return: the first unique number in stream  
     */    public int firstUnique() {  
        return getFirst();  
    }  
      
    private void addToTail(Node cur){  
        tail.prev.next = cur;  
        cur.prev = tail.prev;  
        tail.prev = cur;  
        cur.next = tail;  
    }  
    private void remove(Node cur){  
        cur.prev.next = cur.next;  
        cur.next.prev = cur.prev;  
    }  
    private int getFirst(){  
        return head.next.key;  
    }  
}
```