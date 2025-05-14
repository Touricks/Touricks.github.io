---
layout: default
title: Cursor 文件注入
narrow: true
---

Cursor 获知这些文件存在的两种方法

1. **手动 @ 引用**：在聊天时键入 `@README.md`、`@TODO.md`，即插即用。
2. **自动注入**：在 `.cursor/rules/base.mdc` 里写：

```mdc
---
alwaysApply: true
description: Core project context
---
@README.md
@ROADMAP.md
@TODO.md
@CHANGELOG.md
```

每次让 AI 写代码或解释时，上面四个文件就会自动附带到系统提示，不怕"健忘"。
