---
layout: default
title: ReverseWordsInASentenceII
narrow: true
---
https://app.laicode.io/app/problem/383?plan=3
Reverse the words in a sentence and truncate all heading/trailing/duplicate space characters.

**Examples**
- “ I  love  Google  ” → “Google love I”

**Corner Cases**
- If the given string is null, we do not need to do anything.
***
- 清空StringBuilder内容：`sb.setLength(0)`
- 这个方法会直接将 `StringBuilder` 内部的字符数组长度设置为 0，但不会丢弃原来的数组。这意味着它能快速重置 `StringBuilder`，以便重新使用，同时避免了重新分配内存的开销。
```java
public String reverseWords(String input) {  
    // Use a new StringBuilder to construct new string  
    // Scan the original string, skip the space, record the word (content in a new StringBuilder) it meet    
    // Reverse the word, then append the word from a temporary stringBuilder to a global stringBuilder    
    // Finally, Reverse the global StringBuilder    if (input == null || input.length() == 0){  
        return input;  
    }  
    StringBuilder res = new StringBuilder();  
    StringBuilder word = new StringBuilder();  
    for(int i=0;i<input.length();i++){  
        if (input.charAt(i) == ' '){  
            continue;  
        }  
        word.setLength(0);  
        while(i<input.length() && input.charAt(i) != ' '){  
            word.append(input.charAt(i));  
            i++;  
        }  
        word.reverse();  
        word.append(' ');  
        res.append(word);  
    }  
    res.deleteCharAt(res.length()-1);  
    res.reverse();  
    return res.toString();  
}
```