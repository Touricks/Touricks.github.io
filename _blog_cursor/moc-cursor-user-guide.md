---
layout: default
title: MOC-Cursor-User-Guide
narrow: true
---

在 Cursor 里，"它能看到什么、记得什么"，主要取决于**两类东西**：

| 目的                                                                | 放哪儿                                                                           | 典型文件名 / 格式                                                                         | 说明                                                                                                                                                                                                                                                                                                       |
| ------------------------------------------------------------------- | -------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **永久、每次都会喂给 LLM 的规则 / 背景**                            | `.cursor/rules/*.mdc`（项目级）`.cursorrules` (老格式)**User Rules**（全局设置） | `base.mdc` – 项目概要`style-guide.mdc` – 代码规范`done.mdc` – 已完成模块清单              | "Rules" 是官方支持的**系统级指令**渠道，内容会固定插到提示词最前面，对 Cmd-K 和 Agent 都生效([Cursor](https://docs.cursor.com/context/rules "Cursor – Rules"))                                                                                                                                             |
| **可检索、按需拉取的动态上下文**                                    | 任意位置，Cursor 会索引所有文本/源码                                             | `README.md` 、高频：`CHANGELOG.md`、`TODO.md`、`ROADMAP.md`、`SPEC.md`/`PRD.md`、`SOP.md` | 这些 Markdown/文本文件不会**自动**进上下文，但你可以：_ 在对话里 `@README.md`、`@tasks.md` 点名_ 把它们引用进某条 Rule 的 `@file` 列表，让 AI 在相关任务时自动附带                                                                                                                                         |
| **"做什么 / 做到哪儿" 的实时黑板**（社区约定，适合 Agent 循环写入） | 任意目录（常见 `cursorkleosr/`）                                                 | `project_config.md` – 不变的目标、技术栈`workflow_state.md` – 当前阶段、计划、日志        | Agent 每轮读取 → 执行 → 把进度写回 `workflow_state.md`，形成"自驱循环"([Cursor - Community Forum](https://forum.cursor.com/t/guide-a-simpler-more-autonomous-ai-workflow-for-cursor/70688 "[Guide] A Simpler, More Autonomous AI Workflow for Cursor [New Update] - Showcase - Cursor - Community Forum")) |

## 常用文件的作用一览

[常用文件作用一览](/cursordocs/common-file-functions-overview.html)

## 目录/文件放置建议

[目录放置建议](/cursordocs/directory-structure-suggestions.html)

## 每个文件的示范模板

[示范模板](/cursordocs/demo-template.html)

## Rule

[CursorRule](/cursordocs/cursorrule.html)

## 设定 Cursor 对文件的读写权限

[设定 Cursor 对文件的读写权限](/cursordocs/set-cursor-file-permissions.html)

## MCP 相关

[CursorMCP](/cursordocs/cursormcp.html)
