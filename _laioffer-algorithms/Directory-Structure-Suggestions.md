---
layout: default
title: Directory Structure
narrow: true
---

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
│       └── base.mdc         ← “总规则”文件，@引用上面那些 md
│
└── src/ …                   ← 代码/资源
```

**理由**

| 文件                     | 为什么放在仓库根                                                                      | Cursor/IDE 行为                                            |
| ------------------------ | ------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| `README.md`              | GitHub、GitLab、VSCode、Cursor 均默认渲染根目录 README；新访客和 LLM 都能第一时间看到 | Cursor 索引全文，可在对话中 `@README.md` 引用              |
| `CHANGELOG.md`           | 跟版本控制相关，放根目录最直观                                                        | Cursor 可检索版本历史，Agent 编写修复/升级时会引用         |
| `ROADMAP.md` / `TODO.md` | 同属“项目文档”，放根目录便于快速查找（或统一进 `docs/` 亦可）                         | 若在 `.cursor/rules/*.mdc` 中 `@ROADMAP.md`，AI 会自动携带 |
| `.cursor/rules/`         | Cursor 约定目录；`*.mdc` 写“Always apply”，就能把上面 md 自动嵌入上下文               | —                                                          |

---
