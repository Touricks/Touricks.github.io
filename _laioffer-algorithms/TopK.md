## 综述
Comparator：
```java
private static final Comparator<Map.Entry<String, Integer>> ENTRY_COMPARATOR =
	new Comparator<Map.Entry<String, Integer>>() {
		@Override
		public int compare(Map.Entry<String, Integer> a,
						   Map.Entry<String, Integer> b) {
			if (!a.getValue().equals(b.getValue())) {
				return a.getValue() - b.getValue();          // 频率小的在前
			}
			// 频率相同，字典序大的放前（为了堆顶是“最差”元素）
			return b.getKey().compareTo(a.getKey());
		}
	};
```
- 后续应用
```java
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

## 例题
- 这里我们考虑两种特殊情况
	- 1. 使用Map.Entry
	- 2. Override hashCode & equals
- TopK题最重要的是corner case的处理，比如
[[TopK-Frequent-Words]]
- k的值比不同单词高怎么办
	- 最后创建String数组时明确k值不一定等于真实容量
- 单词列表可不可以出现null
	- HashMap统计时去除
- k<=0怎么办
	- 返回空数组
- 离线还是在线？如果要求在线topK怎么办？
	- 注：将PriorityQueue变为TreeSet就可以了，改下对应API
[[Kth-Smallest-In-Matrix]]
- Override关键词只有在implements的接口需要时才使用，否则报错
- 比如实现Comparable的时候给compare加Override decorator