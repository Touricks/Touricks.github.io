---
layout: default
title: LFU
narrow: true
---
- https://leetcode.com/problems/lfu-cache/
- 与LRU的区别

| 方面   | LRU       | **LFU**                            |
| ---- | --------- | ---------------------------------- |
| 维度   | 仅按 “最近使用” | 先按 “使用频次”，频次相同再按最近使用               |
| 结构   | 一个链表      | **多条**链表，分别对应不同 freq               |
| 额外字段 | 无         | `freq` + `minFreq`                 |
| 淘汰   | 删链表头      | 删 `minFreq` 链表头；若该链表空，再增 `minFreq` |
-  `get(key)`
	1. key 不存在 → 返回 `null`（或 -1）。
	2. 取出 node，记下 `oldFreq`。
	3. 从 `freqList.get(oldFreq)` 链表删除 node；若链表空且 `oldFreq == minFreq`，则 `minFreq++`。
	4. `node.freq++`，将 node 加到 `freqList.get(newFreq)` 的尾部（如无链表则先新建）。
	5. 返回 `node.val`
	    
-  `put(key, value)`
- **容量为 0**：直接返回。
- **已存在**：跟 `get()` 流程一样先提频次，再改 `val`。
- **新 key**：
    1. 若当前 size == capacity：
        - 找到 `freqList.get(minFreq)`；弹出其头节点 → 删掉其 key 在两张表中的记录。
    2. 新建节点 `freq = 1`，插入 `freqList.get(1)` 尾部；`minFreq = 1`。
    3. `keyNodeMap.put(key, node)`。

- Code
```java
import java.util.*;

public class LFUCache<K, V> {
    /* --------------- Node & DoublyList --------------- */
    private static class Node<K, V> {
        K key; V val;
        int freq = 1;
        Node<K, V> prev, next;
        Node(K k, V v) { key = k; val = v; }
    }
    private static class DoublyList<K, V> {
        Node<K, V> head = new Node<>(null, null);   // dummy
        Node<K, V> tail = new Node<>(null, null);   // dummy
        DoublyList() { head.next = tail; tail.prev = head; }
        boolean isEmpty() { return head.next == tail; }
        void addLast(Node<K, V> x) {
            x.prev = tail.prev; x.next = tail;
            tail.prev.next = x; tail.prev = x;
        }
        Node<K, V> removeFirst() {                 // 弹出最旧
            if (isEmpty()) return null;
            Node<K, V> first = head.next;
            remove(first);
            return first;
        }
        void remove(Node<K, V> x) {
            x.prev.next = x.next; x.next.prev = x.prev;
        }
    }

    /* --------------- Fields --------------- */
    private final int cap;
    private int size = 0, minFreq = 0;
    private final Map<K, Node<K, V>> keyNode = new HashMap<>();
    private final Map<Integer, DoublyList<K, V>> freqList = new HashMap<>();

    public LFUCache(int capacity) {
        this.cap = capacity;
    }

    /* --------------- Public API --------------- */
    public V get(K key) {
        Node<K, V> node = keyNode.get(key);
        if (node == null) return null;
        bump(node);
        return node.val;
    }

    public void put(K key, V value) {
        if (cap == 0) return;

        if (keyNode.containsKey(key)) {               // 更新
            Node<K, V> node = keyNode.get(key);
            node.val = value;
            bump(node);
            return;
        }

        // 新键
        if (size == cap) {                            // 先淘汰
            DoublyList<K, V> minList = freqList.get(minFreq);
            Node<K, V> evict = minList.removeFirst();
            keyNode.remove(evict.key);
            size--;
        }
        Node<K, V> fresh = new Node<>(key, value);
        keyNode.put(key, fresh);
        freqList.computeIfAbsent(1, k -> new DoublyList<>()).addLast(fresh);
        minFreq = 1;
        size++;
    }

    /* --------------- Helpers --------------- */
    private void bump(Node<K, V> node) {     // 频次 +1 并迁移至另一条双向链表
        int oldFreq = node.freq;
        DoublyList<K, V> oldList = freqList.get(oldFreq);
        oldList.remove(node);
        if (oldFreq == minFreq && oldList.isEmpty()) minFreq++;

        int newFreq = node.freq++;
        DoublyList<K,V> list = freqList.get(newFreq);
		if (list == null) {
		    list = new DoublyList<>();
		    freqList.put(newFreq, list);
		}
		list.addLast(node);
    }
}

```