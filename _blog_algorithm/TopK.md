---
layout: default
title: TopK
narrow: true
---

```table-of-contents

```

## 综述

> ==Compare（CompareTo）返回小于 0 的数，表示第一个参数（原参数对象）优先级更高==
> ==Compare（CompareTo）返回大于 0 的数，表示第二个参数（传入的参数对象）优先级更高==

- Comparator Class：

```java
private static final Comparator<Map.Entry<String, Integer>> ENTRY_COMPARATOR =
	new Comparator<Map.Entry<String, Integer>>() {
		@Override
		public int compare(Map.Entry<String, Integer> a,
						   Map.Entry<String, Integer> b) {
			if (!a.getValue().equals(b.getValue())) {
				return a.getValue() - b.getValue();          // 频率小的在前
			}
			// 频率相同，字典序大的放前（为了堆顶是"最差"元素）
			return b.getKey().compareTo(a.getKey());
		}
	};
PriorityQueue<Map.Entry<String, Integer>> heap =
		new PriorityQueue<Map.Entry<String, Integer>>(K, ENTRY_COMPARATOR);

	for (Map.Entry<String, Integer> e : freq.entrySet()) {
		if (heap.size() < K) {
			heap.offer(e);
		} else if (ENTRY_COMPARATOR.compare(e, heap.peek()) > 0) {
			heap.poll();
			heap.offer(e);
		}
	}
```

- Nested Comparator：

```java
PriorityQueue<Cell> pQueue = new PriorityQueue<>(16, new Comparator<Cell>() {
    @Override
    public int compare(Cell c1, Cell c2) {
        if (c1.value == c2.value) {
            return 0;
        }
        return c1.value < c2.value ? -1 : 1;
    }
});
```

- Lambda Comparator:

```java
PriorityQueue<Cell> pQueue = new PriorityQueue<>(16, (Cell c1, Cell c2) -> {
    if (c1.value == c2.value) {
        return 0;
    }
    return c1.value < c2.value ? -1 : 1;
});
```

- implements Comparable

```java
class Person implements Comparable<Person> {
    private String name;
    private int age;
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    @Override
    public int compareTo(Person other) {
        return Integer.compare(this.age, other.age);
    }
}
```

## 例题

- 这里我们考虑两种特殊情况
  - 1.  使用 Map.Entry
  - 2.  Override hashCode & equals
- TopK 题最重要的是 corner case 的处理，
- [TopK-Frequent-Words](/algorithmnnotes/topk-frequent-words.html)
  - k 的值比不同单词的数量高怎么办
    - 最后创建 String 数组时明确 k 值不一定等于真实容量
  - 单词列表可不可以出现 null
    - HashMap 统计时去除
  - k<=0 怎么办
    - 返回空数组
  - 离线还是在线？如果要求在线 topK 怎么办？
    - 注：将 PriorityQueue 变为 TreeSet 就可以了，改下对应 API
- [Kth-Smallest-In-Matrix](/algorithmnnotes/kth-smallest-in-matrix.html)

  - Override 关键词只有在 implements 的接口需要时才使用，否则报错
  - 比如实现 Comparable 的时候给 compare 加 Override decorator

- [Ksmallestwith357](/algorithmnnotes/ksmallestwith357.html)

  - 注意变量范围（int/long）

- [Kth Closest Point To (0,0,0)](/algorithmnnotes/kth-closest-point-to-0-0-0.html)
  - 需要 override 比较器和相关函数
