---
layout: default
title: TopK-Frequent-Words
narrow: true
---
https://app.laicode.io/app/problem/67?plan=3
Given a composition with different kinds of words, return a list of the top K most frequent words in the composition.

**Assumptions**

- the composition is not null and is not guaranteed to be sorted
- K >= 1 and K could be larger than the number of distinct words in the composition, in this case, just return all the distinct words

**Return**

- a list of words ordered from most frequent one to least frequent one (the list could be of size K or smaller than K)

**Examples**

- Composition = ["a", "a", "b", "b", "b", "b", "c", "c", "c", "d"], top 2 frequent words are [“b”, “c”]
- Composition = ["a", "a", "b", "b", "b", "b", "c", "c", "c", "d"], top 4 frequent words are [“b”, “c”, "a", "d"]
- Composition = ["a", "a", "b", "b", "b", "b", "c", "c", "c", "d"], top 5 frequent words are [“b”, “c”, "a", "d"]
***
- topK最大考虑容量为k的最小堆，堆顶就是答案
- 当堆中元素大于k时，比较新元素和堆顶大小，如果比堆顶小直接忽略，否则移除堆顶，加入新元素
- O(Nlogk)

```java
public String[] topKFrequent(String[] combo, int k) {  
    HashMap<String,Integer> lookup = new HashMap<>();  
    for(int i=0;i<combo.length;i++){  
        if (!lookup.containsKey(combo[i])){  
            lookup.put(combo[i],1);  
        }else{  
            lookup.put(combo[i],lookup.get(combo[i])+1);  
        }  
    }  
    PriorityQueue<Map.Entry<String, Integer>> pq = new PriorityQueue<>(new Comparator<Map.Entry<String,Integer>>(){  
        @Override  
        public int compare(Map.Entry<String,Integer> o1, Map.Entry<String,Integer> o2){  
            return Integer.compare(o1.getValue(),o2.getValue());  
        }  
    });  
    for(Map.Entry<String,Integer> entry: lookup.entrySet()){  
        if (pq.size()<k){  
            pq.add(entry);  
        }else{  
            if (entry.getValue()>pq.peek().getValue()){  
                pq.poll();  
                pq.add(entry);  
            }  
        }  
    }  
    k = Math.min(pq.size(),k);  
    String[] res = new String[k];  
    for(int i=k-1;i>=0;i--){  
        res[i] = pq.poll().getKey();  
    }  
    return res;  
}
```