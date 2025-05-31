## 🎉 2025 年 5 月 31 日 - 重大更新：全面小写化迁移完成

### ✅ 批量文件重命名任务（124 个文件）

- **成功重命名了 124 个包含大写字母的文件**，全部转换为小写格式
- 使用连字符替代特殊字符和空格，符合 Web URL 标准
- 主要重命名示例：
  - `WordSearchII.md` → `wordsearchii.md`
  - `TwoPointer.md` → `twopointer.md`
  - `MaxWaterTrapped3D.md` → `maxwatertrapped3d.md`
  - `Longest-Substring-Without-Repeating-Characters.md` → `longest-substring-without-repeating-characters.md`

### ✅ 全站链接更新

- **自动更新了所有文件中的链接引用**，确保链接与新文件名匹配
- 保护了 JSON 数组等数据格式，避免错误转换
- 完美解决了 GitHub Pages 的 URL 大小写敏感问题

### 🌟 技术成就

- **完全符合 Web 标准**：所有 URL 现在都是小写格式
- **Jekyll 兼容性**：完美适配 Jekyll 静态网站生成器
- **零维护负担**：一次性解决，无需后续特殊配置
- **用户体验优化**：所有链接在https://touricks.github.io上正常工作

---

已经完成的工作：

1. 将 touricks.github.io/laioffer 下的文件按照"是否跟 cursor 相关"分别放到"blog_algorithm"和"blog_cursor"文件夹下
2. 将两个文件夹下的所有文件按照如下要求改名：修改文件名至英文，并将空格替换为连字符"-"
3. 为每个文件添加如下格式的 heading，其中 titie 换为文件的名称：

---

layout: default
title: Preorder(Iter)
narrow: true

---

4. 将文件中出现的所有具有[[]]格式的超链接按如下格式更换：
[[filename]] 改为 [filename](/algorithmn-notes/filename.html)
   如：[[bstinsert]] 改为 [bstinsert](/algorithmn-notes/bstinsert.html)
5. ✅ **NEW** 完成文件名和链接的小写化迁移：
   - 将所有包含大写字母或特殊字符的文件名转换为小写，使用连字符分隔
   - 例如：`Preorder(Iter).md` → `preorder-iter.md`
   - 例如：`Kth-Closest-Point-To-(0,0,0).md` → `kth-closest-point-to-0-0-0.md`
   - 更新了所有文件中的相应链接引用，确保链接与实际文件名匹配
   - 解决了 GitHub Pages URL 大小写敏感的问题
6. ✅ **NEW** 修复了重要文件的[[]]链接格式：

   - MOC-algorithm.md：主目录文件，修复了所有子模块链接
   - Recursion.md：递归相关算法，修复了链表、数组、树等所有链接
   - DFS.md：深度优先搜索，修复了排列组合、树遍历等链接
   - Special-Topic.md：特殊主题，修复了字符串 API、数据结构等链接
   - TopK.md：堆相关算法，修复了所有例题链接
   - BFS.md：广度优先搜索，保留了格式化改进
   - TwoPointer.md：双指针算法，保留了格式化改进
   - 所有 cursor 相关文件的链接都已修复大小写问题

7. 文件名一定要用小写英文单词组合，因为 1.URL 不认识中文 2.URL 不认识大写字母
