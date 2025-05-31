---
layout: default
title: Common-File-Functions-Overview
narrow: true
---
- **`README.md`** 给 AI（和人）一个总览：项目目的、已完成里程碑、目录结构。
- **`CHANGELOG.md`** 记录历史版本 ➜ 让 AI 知道哪些功能“已经完工且上线”。
- **`TODO.md` / `tasks.md`** 用复选框列 backlog，AI 很容易据此推断“已完成 vs. 未完成”([Reddit](https://www.reddit.com/r/cursor/comments/1isi5br/ive_learnt_how_to_cursor_and_you_can_too_3/?utm_source=chatgpt.com "I've learnt how to Cursor, and you can too! 3 problems solved - Reddit"))。
- **`ROADMAP.md`** 中长期计划，让 AI 在生成方案时别撞车未来迭代([GitHub](https://github.com/digitalchild/cursor-best-practices?utm_source=chatgpt.com "Best practices when using Cursor the AI editor. - GitHub"))。
- **`PRD.md` / `SPEC.md`** 详细需求；官方建议把 PRD 放进代码库供 Cursor 检索([ChatPRD](https://www.chatprd.ai/resources/PRD-for-Cursor?utm_source=chatgpt.com "Resources / Best Practices for Using PRDs with Cursor - ChatPRD"))。
- **`.cursor/rules/*.mdc`** 写成 “Always” 或 “Auto-Attached” 规则，把上面这些文件 `@引用` 进去，就能在相关对话里自动携带而无需手动 `@`