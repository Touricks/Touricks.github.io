---
layout: default
title: HashSet-TreeSet-PriorityQueue-API
narrow: true
---
### PriorityQueue 主要 API
- **构造**
    - `PriorityQueue()`
    - `PriorityQueue(int initialCapacity)`
    - `PriorityQueue(Comparator<? super E> comparator)`
- **插入 / 删除 / 访问**
    - `boolean offer(E e)`   
    - `E poll()`  
    - `E peek()`   
    - `void clear()`
- **容量 / 内容**
    - `int size()`
    - `boolean isEmpty()`
    - `Object[] toArray()`
    - `<T> T[] toArray(T[] a)`   
- **线性搜索相关**
    - `boolean contains(Object o)`  
    - `boolean remove(Object o)`    
    - `Iterator<E> iterator()`    
    - `Spliterator<E> spliterator()`    
---
### TreeMap 主要 API
- **构造**
    - `TreeMap()`
    - `TreeMap(Comparator<? super K> comparator)`
    - `TreeMap(Map<? extends K,? extends V> m)`
- **基本操作**
    - `V put(K key, V value)`
    - `V get(Object key)`  
    - `V remove(Object key)`    
    - `void clear()`    
    - `boolean containsKey(Object key)`    
    - `boolean containsValue(Object value)`
    - `int size()`
    - `boolean isEmpty()`
- **最值 / 弹出**
    - `K firstKey()`
    - `K lastKey()`
    - `Map.Entry<K,V> pollFirstEntry()`
    - `Map.Entry<K,V> pollLastEntry()`
- **导航查询** (`NavigableMap`)
    - `K lowerKey(K key)`
    - `K floorKey(K key)`
    - `K ceilingKey(K key)`
    - `K higherKey(K key)`
    - `Map.Entry<K,V> lowerEntry(K key)`
    - `Map.Entry<K,V> floorEntry(K key)`
    - `Map.Entry<K,V> ceilingEntry(K key)`
    - `Map.Entry<K,V> higherEntry(K key)`

| 方法                  | 方向   | 是否包含 `key` | 语义一句话                  | 若找不到   | 对应的 “TreeSet” 版本  |
| ------------------- | ---- | ---------- | ---------------------- | ------ | ----------------- |
| `lowerEntry(key)`   | ← 更小 | **不含**     | _严格小于_ `key` 的最大键对应的条目 | `null` | `lowerKey(key)`   |
| `floorEntry(key)`   | ← 更小 | **包含**     | _小于或等于_ `key` 的最大键条目   | `null` | `floorKey(key)`   |
| `ceilingEntry(key)` | → 更大 | **包含**     | _大于或等于_ `key` 的最小键条目   | `null` | `ceilingKey(key)` |
| `higherEntry(key)`  | → 更大 | **不含**     | _严格大于_ `key` 的最小键条目    | `null` | `higherKey(key)`  |
- **视图**
    - `NavigableMap<K,V> subMap(K fromKey, boolean fromInclusive, K toKey, boolean toInclusive)`
    - `NavigableMap<K,V> headMap(K toKey, boolean inclusive)`
    - `NavigableMap<K,V> tailMap(K fromKey, boolean inclusive)`
    - `NavigableSet<K> navigableKeySet()`
    - `NavigableSet<K> descendingKeySet()`
    - `NavigableMap<K,V> descendingMap()`
---
### TreeSet 主要 API
- **构造**
    - `TreeSet()`
    - `TreeSet(Comparator<? super E> comparator)`
    - `TreeSet(Collection<? extends E> c)`
- **基本操作**
    - `boolean add(E e)`
    - `boolean remove(Object o)`
    - `boolean contains(Object o)`
    - `void clear()`
    - `int size()`    
    - `boolean isEmpty()`
- **最值 / 弹出**
    - `E first()`
    - `E last()`
    - `E pollFirst()`
    - `E pollLast()`
- **导航查询** (`NavigableSet`)
    - `E lower(E e)`
    - `E floor(E e)`
    - `E ceiling(E e)`
    - `E higher(E e)`