---
layout: default
title: LRU
narrow: true
---
https://app.laicode.io/app/problem/205?plan=3

Implement a least recently used cache. It should provide set(), get() operations. If not exists, return null (Java), false (C++), -1(Python).

***
- LRU是一个有capacity的map  
- set: 插入一对key,value pair，这个数如果在cache则更新时间戳，否则加入cache尾部  
	-  如果cache已经满了则把头部元素踢了再插入
	-  踢出元素时除了要从ll中移除还要从map中移除  
-  get: 一个数对应的map值，如果这个数在cache里则返回并且更新时间戳，否则返回null  
	- 更新时间戳：把节点cache拿出来，放回尾部  
- Data Structure: 
	- 双向链表 
	- dummy head + dummy tail 把“链表为空 / 节点为首尾”这类特判全部统一掉，简化代码实现
	- HashMap<K, Node(k,v)> O（1）找到对应节点
	- int capacity
- 易错点：**在把元素从双向链表中去除时不要忘记从map中去除记录**

- 泛型相关
	- 为什么带泛型的class要在new的时候带上<>
	-  `<…>`：表明这是一个“参数化类型 (parameterized type)”。  编译器会在 **编译期** 做 _泛型检查_（元素只能是 `String`，自动推断返回值类型等），  同时生成桥接方法确保类型擦除后仍安全。
	-  **左侧 `<T>`**：声明或使用参数化类型，获得编译期类型检查。
    - **右侧 `<>`**：使用菱形语法，让编译器依据左侧推断实参。
```java
public class LRUcache<K,V> {  
    private static class Node<K,V>{  
        K key;  
        V value;  
        Node<K,V> prev;  
        Node<K,V> next;  
        public Node(K k, V v){  
            this.key = k;  
            this.value = v;  
        }  
        public Node(){}  
    }  
    int size;  
    int capacity;  
    Node<K,V> head = new Node<>();  
    Node<K,V> tail = new Node<>();  
    HashMap<K,Node<K,V>> map = new HashMap<>();  
    public LRUcache(int capacity){  
        this.capacity = capacity;  
        if (capacity <= 0){  
            throw new NoSuchElementException("Capacity cannot be zero");  
        }  
        this.size = 0;  
        this.head.next = tail;  
        this.tail.prev = head;  
    }  
    public void set(K key, V value){  
        if (map.containsKey(key)){  
            remove(map.get(key));  
            addTail(map.get(key));  
        }else{  
            if (size == capacity){  
                map.remove(removeHead());  
                size--;  
            }  
            size++;  
            Node<K,V> newNode = new Node<K,V>(key,value);  
            addTail(newNode);  
            map.put(key,newNode);  
        }  
    }  
    public V get(K key){  
        Node<K,V> node = map.get(key);  
        if (node == null){  
            return null;  
        }  
        remove(node);  
        addTail(node);  
        return node.value;  
    }  
  
    private void remove(Node<K,V> node){  
        node.prev.next = node.next;  
        node.next.prev = node.prev;  
    }  
    private void addTail(Node<K,V> node){  
        tail.prev.next = node;  
        node.prev = tail.prev;  
        node.next = tail;  
        tail.prev = node;  
    }  
    private K removeHead(){  
        Node<K,V> first = head.next;  
        if (first == tail){  
            throw new NoSuchElementException("Capacity cannot be zero");  
        }  
        remove(first);  
        return first.key;  
    }  
}
```