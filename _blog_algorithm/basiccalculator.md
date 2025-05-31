---
layout: default
title: BasicCalculator
narrow: true
---
https://app.laicode.io/app/problem/450
Implement a basic calculator to evaluate a simple expression string.

The expression string contains only non-negative integers, `+`, `-`, `*`, `/` operators and empty spaces . The integer division should truncate toward zero.

You may assume that the given expression is always valid.

Some examples:  

"3+2*2" = 7
" 3/2 " = 1
" 3+5 / 2 " = 5

Note: Do not use the `eval` built-in library function.
***
- 对于包含加减乘除号的计算器，我们需要考虑优先级问题
- 不同于只有加减号的计算器，两个数压进栈后，不一定可以立刻开始计算

- High Level： 我们将运算符即将压入栈的时候，取决于运算符的优先级，决定是否将当前运算符直接压栈，还是将栈中已知一定可以运算的元素提取出来进行运算后，再将当前运算符压栈。最后栈中一定只有从栈顶开始优先级递减的运算符，这时再将栈中元素拉出进行运算。
- Details
	- Stack:开两个栈，一个存数字，一个存运算符
	- 遍历表达式
		- 遇到数字 - 遍历连续的数字，放到num stack中
		- 遇到运算符：
			- 当栈为空时，直接放
			- 当栈不为空，但栈顶运算符比当前运算符优先级高或相同时
				- （e.g. 栈顶为X，当前为+）(e.g. 栈顶为+，当前也是+)
				- 这时进行计算
			- 当栈不为空，但栈顶运算符比当前运算符优先级低
				- (e.g. 栈顶为+，当前为X)
				- 这时只能将运算符压入栈
	- 最后将剩余栈中的运算符从栈顶向下计算得出最终结果
- 注意：可以把“运算符栈”视为 **按优先级维护的单调递减栈**。
	- **单调键**：运算符的优先级
	- **弹栈触发条件**：优先级高/相等
	- **弹栈动作**：立即计算得到简化结果
- 运算符栈本质上就是一支 **按优先级维护单调递减性** 的栈；每当单调性被破坏就弹栈并做计算，这与单调栈在数组题目中的角色高度一致，唯一差异是弹栈后的“副作用”不同。
- 和单调栈的比较

| 单调栈典型问题（如滑动窗口最大值问题）                             | 本题的运算符栈                                                                                           |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| 栈内元素在某种“键值”上保持单调（递增/递减）。若新元素破坏了单调性，就一直弹栈直至恢复单调。 | 栈内运算符按 **优先级** 保持“单调递减”（高优先级在下面，低优先级在上面）。当 _新运算符_ 的优先级 **≤** 栈顶时——即“破坏”了单调性——就不断弹栈并立即计算，直到再次满足单调。 |
| **弹栈的副作用** 是我们在求解答案：每被弹出的元素都会更新结果或形成配对。         | **弹栈的副作用** 是把对应操作数也弹出并完成一次计算，将结果重新压入数字栈。                                                          |
| 处理完毕后栈内仍保持单调，最后再统一清算或直接作为答案。                    | 处理完毕后运算符栈也是严格单调（低优先级到高优先级），最后再统一清算得到最终值。                                                          |
```java
public int calculate(String input) {  
    Deque<Integer> numStack = new LinkedList<>();  
    Deque<Character> optStack = new LinkedList<>();  
    for(int i=0;i<input.length();i++){  
        char c = input.charAt(i);  
        if (c == ' '){  
            continue;  
        }  
        if (Character.isDigit(c)){  
            int num = c-'0';  
            while(i+1 < input.length() && Character.isDigit(input.charAt(i+1))){  
                num = num*10 + (input.charAt(i+1) -'0');  
                i++;  
            }  
            numStack.push(num);  
        }else{  
            while(!optStack.isEmpty() && getPrecedence(c) <= getPrecedence(optStack.peek())){  
                int num = evaluate(optStack.pop(),numStack.pop(),numStack.pop());  
                numStack.push(num);  
            }  
            optStack.push(c);  
        }  
    }  
    while(!optStack.isEmpty()){  
        int num = evaluate(optStack.pop(),numStack.pop(),numStack.pop());  
        numStack.push(num);  
    }  
    return numStack.pop();  
}  
  
public int getPrecedence(char c){  
    switch (c){  
        case '+':  
            return 0;  
        case '-':  
            return 0;  
        case '*':  
            return 1;  
        case '/':  
            return 1;  
    }  
    return 0;  
}  
  
public int evaluate(char c, int n2, int n1){  
    switch (c){  
        case '+':  
            return n1+n2;  
        case '-':  
            return n1-n2;  
        case '*':  
            return n1*n2;  
        case '/':  
            return n1/n2;  
    }  
    return 0;  
}
```