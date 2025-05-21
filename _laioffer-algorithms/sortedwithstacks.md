Given one stack with integers, sort it with two additional stacks (total 3 stacks). 

After sorting the original stack should contain the sorted integers and from top to bottom the integers are sorted in ascending order.

**Assumptions:**

- The given stack is not null.
- The time complexity should be O(n log n).
***
- 对于奇怪的递归题，锚定四个基本规则：

- Function 能做什么
	mergesort(ori,aux,res,size)接受三个栈+第一个栈的大小。其中第一个栈中有待排序的数
	返回排好序的栈，放在ori里
- Base Case
	如果ori长度不大于1，直接返回
- Subproblem
	将ori的一半元素划到aux中,使用aux和res辅助ori排序，使用ori和res辅助aux排序
	- mergesort(ori,aux,res,size)
	- mergesort(aux,ori,res,size)
- Recursion Rule
	- 执行完毕后,ori和aux栈中元素有序
	- 归并结果到res，再返回ori，即可获得一个从top到bottom ascending的栈ori


- Code
```java
 public void sort(LinkedList<Integer> s1) {
    LinkedList<Integer> s2 = new LinkedList<Integer>();
    LinkedList<Integer> s3 = new LinkedList<Integer>();
    mergesort(s1,s2,s3,s1.size());
  }
  public void mergesort(LinkedList<Integer> origin, LinkedList<Integer> aux, LinkedList<Integer> res, int sizeOrigin){
    // suppose method makes elements in origin sorted in ascending order 
    // origin: the number to be sorted
    // aux: the stack accepted half numbers
    // res: the stack collect the result
    // postprocessing: do merge for smaller number, we have a stack with largest element on the top. 
    // Then we pour these elements back to origin, receive a stack which the smallest element on the top.
    if (sizeOrigin <= 1){
      return;
    }
    int sizeAux = sizeOrigin/2;
    int sizeLeft = sizeOrigin-sizeAux;
    for(int i=0;i<sizeAux;i++){
      aux.push(origin.pop());
    }
    mergesort(origin,aux,res,sizeLeft);
    mergesort(aux,origin,res,sizeAux);
    int indexOrigin = 0;
    int indexAux = 0;
    while(indexOrigin < sizeLeft && indexAux < sizeAux){
      if (origin.peek() <= aux.peek()){
        res.push(origin.pop());
        indexOrigin++;
      }else{
        res.push(aux.pop());
        indexAux++;
      }
    }
    while(indexOrigin < sizeLeft){
      res.push(origin.pop());
      indexOrigin++;
    }
    while(indexAux < sizeAux){
      res.push(aux.pop());
      indexAux++;
    }
    while(!res.isEmpty()){
      origin.push(res.pop());
    } 
  }
```