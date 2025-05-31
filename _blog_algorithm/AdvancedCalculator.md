---
layout: default
title: AdvancedCalculator
narrow: true
---
https://www.lintcode.com/problem/849/

实现一个基本的计算器来计算一个简单的字符串表达式的值。

**描述：**

- 表达式字符串只包含非负整数、`+`、`-`、`*`、`/` 四种运算符，以及左、右圆括号 `'('` 和 `')  
- 整数除法应当向 零 截断。
- 你可以假设给定的表达式总是有效的。
- 所有中间结果以及最终结果都保证在 `[-2³¹, 2³¹ − 1]` 范围内。
- **注意：** 不要使用任何内置的可以将字符串当作表达式求值的函数（例如 `eval()`）。
---
**示例 1：**
```
输入：s = "1+1"
输出：2
```
**示例 2：**
```
输入：s = "6-4/2"
输出：4
```
**示例 3：**
```
输入：s = "2*(5+5*2)/3+(6/2+8)"
输出：21
```
---
**约束：**
```
1 <= s.length <= 10⁴
s 仅由数字、'+', '-', '*', '/', '(', ')' 以及空格组成
s 是一个有效的表达式
```
***
High Level: 当我们将运算符压入栈的时候，根据栈的优先级执行不同操作
- 设运算符优先级为: `*/ > +- > (`
- 如果当前运算符优先级大于栈顶运算符优先级，则将运算符压入栈
- 否则重复弹出栈顶运算符和两个数进行计算，直到当前运算符优先级大于栈顶运算符优先级
	- 注意这里为了不让左括号被意外弹出，我们必须给左括号设置最低优先级（下面代码中设为-1），使得正常运算符在上一个运算符是左括号时都要进行压栈
- 遇到右括号时，重复弹出栈顶运算符和两个数进行计算，直到遇到左括号，此时将栈顶左括号弹出并直接考虑下一个字符
- 最终栈中一定是一个从栈顶到栈底运算符优先级不断降低的表达式，重复弹出栈顶运算符和两个数进行计算直到栈中只留下一个数

- Details
- **遇到数字（如 "8"）**：
    1. 将数字压入 `numStack`。
- **遇到 `(`**：
    - 直接压入 `opStack`。
- **遇到 `)`**：
    - 循环执行“计算”步骤，直到在 `opStack` 栈顶遇到 `(`。然后将 `(` 弹出。这确保了括号内的表达式被优先计算。
- **遇到运算符（`+`, `-`, `*`, `/`）**：
    1. 当 (1)`opStack` 不为空，(2)栈顶不是 `(`，(3)并且当前运算符的优先级 **小于等于** `opStack` 栈顶运算符的优先级时，循环执行“计算”。
    2. 将当前运算符压入 `opStack`
```java
public int calculate(String s) {  
    Deque<Character> optStack = new LinkedList<>();  
    Deque<Integer> numStack = new LinkedList<>();  
    for(int i=0;i<s.length();i++){  
        char ch = s.charAt(i);  
        if (ch == ' '){  
            continue;  
        }  
        if (Character.isDigit(ch)){  
            int num = ch-'0';  
            while(i+1 < s.length() && Character.isDigit(s.charAt(i+1))){  
                num = num*10 + (s.charAt(i+1)-'0');  
                i++;  
            }  
            numStack.push(num);  
        }else{  
            if (ch == '('){  
                optStack.push(ch);  
            }else if (ch == ')'){  
                while(optStack.peek() != '('){  
                    int num = evaluate(optStack.pop(),numStack.pop(),numStack.pop());  
                    numStack.push(num);  
                }  
                optStack.pop();  
            }else if (!optStack.isEmpty() && getPrecedence(ch) <= getPrecedence(optStack.peek())){  
                int num = evaluate(optStack.pop(),numStack.pop(),numStack.pop());  
                numStack.push(num);  
                optStack.push(ch);  
            }else{  
                optStack.push(ch);  
            }  
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
    return -1;  
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