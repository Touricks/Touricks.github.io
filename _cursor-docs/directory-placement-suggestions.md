---
layout: default
title: 目录放置建议
narrow: true
---

在 Cursor 里，"它能看到什么、记得什么"，主要取决于**两类东西**：

| 目的                                                                | 放哪儿                                                                           | 典型文件名 / 格式                                                                         | 说明                                                                                                                                                                                                                                                                                                       |
| ------------------------------------------------------------------- | -------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **永久、每次都会喂给 LLM 的规则 / 背景**                            | `.cursor/rules/*.mdc`（项目级）`.cursorrules` (老格式)**User Rules**（全局设置） | `base.mdc` – 项目概要`style-guide.mdc` – 代码规范`done.mdc` – 已完成模块清单              | "Rules" 是官方支持的**系统级指令**渠道，内容会固定插到提示词最前面，对 Cmd-K 和 Agent 都生效([Cursor](https://docs.cursor.com/context/rules "Cursor – Rules"))                                                                                                                                             |
| **可检索、按需拉取的动态上下文**                                    | 任意位置，Cursor 会索引所有文本/源码                                             | `README.md` 、高频：`CHANGELOG.md`、`TODO.md`、`ROADMAP.md`、`SPEC.md`/`PRD.md`、`SOP.md` | 这些 Markdown/文本文件不会**自动**进上下文，但你可以：_ 在对话里 `@README.md`、`@tasks.md` 点名_ 把它们引用进某条 Rule 的 `@file` 列表，让 AI 在相关任务时自动附带                                                                                                                                         |
| **"做什么 / 做到哪儿" 的实时黑板**（社区约定，适合 Agent 循环写入） | 任意目录（常见 `cursorkleosr/`）                                                 | `project_config.md` – 不变的目标、技术栈`workflow_state.md` – 当前阶段、计划、日志        | Agent 每轮读取 → 执行 → 把进度写回 `workflow_state.md`，形成"自驱循环"([Cursor - Community Forum](https://forum.cursor.com/t/guide-a-simpler-more-autonomous-ai-workflow-for-cursor/70688 "[Guide] A Simpler, More Autonomous AI Workflow for Cursor [New Update] - Showcase - Cursor - Community Forum")) |

```
my-awesome-project/          ← 仓库根目录
│
├── README.md                ← 入口文档，GitHub / Cursor 默认首选
├── ROADMAP.md               ← 中长期规划（也可放 docs/ROADMAP.md）
├── TODO.md                  ← 近期任务清单
├── CHANGELOG.md             ← 历史版本日志
│
├── .cursor/                 ← Cursor 专属配置
│   └── rules/
│       └── base.mdc         ← "总规则"文件，@引用上面那些 md
│
└── src/ …                   ← 代码/资源
```

**理由**

| 文件                     | 为什么放在仓库根                                                                      | Cursor/IDE 行为                                            |
| ------------------------ | ------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| `README.md`              | GitHub、GitLab、VSCode、Cursor 均默认渲染根目录 README；新访客和 LLM 都能第一时间看到 | Cursor 索引全文，可在对话中 `@README.md` 引用              |
| `CHANGELOG.md`           | 跟版本控制相关，放根目录最直观                                                        | Cursor 可检索版本历史，Agent 编写修复/升级时会引用         |
| `ROADMAP.md` / `TODO.md` | 同属"项目文档"，放根目录便于快速查找（或统一进 `docs/` 亦可）                         | 若在 `.cursor/rules/*.mdc` 中 `@ROADMAP.md`，AI 会自动携带 |
| `.cursor/rules/`         | Cursor 约定目录；`*.mdc` 写"Always apply"，就能把上面 md 自动嵌入上下文               | —                                                          |

---
