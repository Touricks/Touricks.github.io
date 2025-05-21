Given a target integer T and an integer array A sorted in ascending order, find the index i in A such that A[i] is closest to T.

**Assumptions**
- There can be duplicate elements in the array, and we can return any of the indices with same value.

**Examples**
- A = {1, 2, 3}, T = 2, return 1
- A = {1, 4, 6}, T = 3, return 1
- A = {1, 4, 6}, T = 5, return 1 or 2
- A = {1, 3, 3, 4}, T = 2, return 0 or 1 or 2

**Corner Cases**
- What if A is null or A is of zero length? We should return -1 in this case.
***
Processing
- target = T
- array[mid] == target => 直接返回
- array[mid] < target => mid可能是答案 > left = mid
- array[mid] > target => mid可能是答案 > right = mid

PostProcessing
- left可能是答案？Math.abs(a[left]-target)
- right可能是答案？Math.abs(a[right]-target)