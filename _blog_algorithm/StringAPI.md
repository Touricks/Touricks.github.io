---
layout: default
title: StringAPI
narrow: true
---
- 包括String, Character 和 StringBuilder 的API

## Java String 常用 API(不可变)
- **获取子串**
    ```java
    s.substring(beginIndex[, endIndex])  // [begin, end)
    ```
- **拆分**
    ```java
    s.split(regex)  
    s.split(regex, limit)  // 最多返回 limit 个子串
    ```
- **修剪 & 大小写**
    ```java
    s.trim()            // 去首尾空格
    s.toLowerCase()     // 全小写  
    s.toUpperCase()     // 全大写
    ```
- **查找**
    ```java
    s.indexOf(ch|str[, fromIndex])      // 首次出现，找不到返 -1
    s.lastIndexOf(ch|str[, fromIndex])  // 最后出现
    s.contains(seq)                     // 包含子串
    ```
    - 例如
```java
	s.indexOf('b')
	s.indexOf("ab")
	s.contains("ab")
```
- **替换**
    ```java
    s.replace(oldChar, newChar)  
    s.replace(targetSeq, replacementSeq) //替换字符串，无视正则字符
    s.replaceFirst(regex, repl) //自动编译regex至正则表达式
    s.replaceAll(regex, repl) //自动编译regex至正则表达式
    ```
	- 注意：`String.replace(...)` 也是全局（多次）替换，不是只替换一次
		- 功能上和replaceAll相同
```java
	s.replace("aa","bb");
	"2024-03-15 2025-05-19".replaceFirst("\\d{4}", "YEAR")
	 // 得到："YEAR-03-15 2025-05-19"
	"name=Tom id=007".replaceFirst("id=(\\d+)", "ID:$1"); 
	 // 得到： "name=Tom ID:007"
```
- **比较**
    ```java
    s.equals(b)  // 逐字符、区分大小写地比较两串内容是否完全相同
    s.equalsIgnoreCase(b) //先把 A–Z 和 a–z 视为同一字符，再比较，只针对英文字母大小写有效
    s.compareTo(b) // 定义在 `Comparable<String>` 接口里，用于字典）顺序比较两个字符串
    s.startsWith(prefix), s.endsWith(suffix)
    //测试当前字符串是否以给定 前缀/后缀 开头。
    ```
    
- 注意：
	- 在 Java 里，`String.split()` 接受的是一个 **正则表达式**。  
	- 而竖线 `|` 在正则里是“或”（alternation）的元字符，单写 `"|"` 会被当作“空串或空串”来解析，结果就乱了。
	- 如果`s="A|B|C|D"，那么str.spilt("\\|")返回的才是[A,B,C,D]`
---
## Java Character 常用API
```java
isDigit(char ch) 
// determine if the specified character is a digit

toUpperCase(char ch) 
// Convert the character argument to uppercase using case mapping information from the unicodeData file

toLowerCase(char ch)
// Convert the character argument to lowercase using case mapping information from the unicodeData file
```
## Java StringBuilder 常用 API(可变)
- **追加**
    ```java
    sb.append(ch|str)      // amortized O(1) 或 O(len)
    sb.insert(idx, ch|str) // O(n)
    ```
- **删除**
    ```java
    sb.delete(start, end)      // O(n)
    sb.deleteCharAt(index)     // O(n) delete at tail -O(1)
    ```
- **访问 & 修改**
    ```java
    sb.charAt(idx)             // O(1)
    sb.setCharAt(idx, ch)      // O(1)
    sb.length()                // 当前字符数    ```
```

- **转换**
```java
    sb.toString()  
    sb.reverse()               // 原地反转
```
