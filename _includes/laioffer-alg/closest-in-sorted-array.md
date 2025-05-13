![[Pasted image 20250512145838.png]]

Processing
- target = T
- array[mid] == target => 直接返回
- array[mid] < target => mid可能是答案 > left = mid
- array[mid] > target => mid可能是答案 > right = mid

PostProcessing
- left可能是答案？Math.abs(a[left]-target)
- right可能是答案？Math.abs(a[right]-target)