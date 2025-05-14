---
layout: default
title: 设定Cursor对文件的读写权限
narrow: true
---

要给 Cursor 清晰地"划红线"，常用的**两条"系统通道"**就是

1. **Ignore 文件**：完全或部分禁止 LLM 看到 / 改动某些文件
2. **Rules（.mdc）**：用持久的系统提示告诉 LLM "只能改这里""绝对别碰那里"

## 1 彻底不让 Cursor 动的文件／目录

### 1.1 `.cursorignore` ── 读也不给读

- 放在仓库根目录
- 语法 **100 % 照搬 `.gitignore`**
- Cursor 会尽力在 **索引、Chat、Cmd-K、Tab** 等所有环节把它们屏蔽掉([Cursor](https://docs.cursor.com/context/ignore-files "Cursor – Ignore Files"))

```gitignore
# .cursorignore
# 敏感配置
.env
config/secret.yml

# 生成目录
dist/
coverage/

# 整个第三方子模块
vendor/**
```

> ⚠️ 添加后最好重启 Cursor 或等待下一次自动 re-index（默认 ~10 分钟）才能完全生效([Cursor - Community Forum](https://forum.cursor.com/t/cursorignore-not-being-used/7494?utm_source=chatgpt.com ".cursorignore not being used - Discussion - Cursor - Community Forum"))

### 1.2 `.cursorindexingignore` ── 只是不入索引

如果你**仍想让 AI 临时读取**（例如回答某些查询），但不想让它常驻向量索引，可把路径列进 `.cursorindexingignore`。文件格式同上；这些文件可以被 Chat 临时加载，却不会常驻搜索库([Cursor](https://docs.cursor.com/context/ignore-files "Cursor – Ignore Files"))。

### 1.3 `.gitignore` 的继承

Cursor 索引默认也会尊重 `.gitignore` 中列出的文件，但**Chat 依然能强行 @ 引用**。要"滴水不漏"，请同时把路径写进 `.cursorignore` 或 `.cursorindexingignore`([Cursor](https://docs.cursor.com/context/ignore-files "Cursor – Ignore Files"))。

---

## 2 指定**只能在哪些文件 / 目录修改**

Ignore 文件只能"全盘封锁"。如果你想让 Cursor **只改特定目录、禁止动其他代码**，就用 **Rules**。

### 2.1 规则文件放哪

```
my-project/
├─ .cursor/
│  └─ rules/
│     ├─ freeze-vendor.mdc
│     └─ allow-ui-changes.mdc
```

### 2.2 最小模板

```mdc
# .cursor/rules/freeze-vendor.mdc
---
description: 禁止修改第三方依赖
alwaysApply: true
---

- **绝不可**修改 `vendor/**` 或 `external/**` 下的文件。
```

```mdc
# .cursor/rules/allow-ui-changes.mdc
---
description: 仅允许在 src/ui/** 做 UI 相关改动
globs:
  - src/ui/**/*.tsx
alwaysApply: false          # 只有当涉及这些文件时才自动附带
---

- 任何 UI 需求请 **只** 修改 `src/ui/` 下文件
- 统一使用 Tailwind + shadcn/ui 组件
```

- **`alwaysApply: true`** → 每次调用模型都带上
- **`globs:`** → 只有当命中这些路径时才注入([Cursor](https://docs.cursor.com/context/rules "Cursor – Rules"))

> 规则文件里的指令会作为 **system prompt** 注入模型，比聊天内容优先级更高。

---

## 3 精准定位"改这里"

- **Inline Edit（选中代码 → ⌘K）**  选中块即是"准心"，Cursor 只会对选区出补丁
- **Chat @文件:行号-行号**  在对话里写 `@src/app.ts:12-30`，AI 会把这 19 行原文带入上下文，只对该片段出 diff
- **在代码里留 `// TODO:` / `# FIXME:` 注释** LLM 很容易识别并按注释位置给出修改建议（适合小范围手动 Apply）

---

## 4 常见组合策略

| 目标                        | Ignore 配置                                | Rule 配置                            |
| --------------------------- | ------------------------------------------ | ------------------------------------ |
| 敏感凭据永不外泄            | `.cursorignore` 把 `.env`, `secrets/` 封死 | —                                    |
| 第三方库只读                | `.cursorignore` vendor/\*\*                | `freeze-vendor.mdc` 再强调"绝不修改" |
| 限定改动到 `src/ui/**`      | —                                          | `allow-ui-changes.mdc` + globs       |
| 大型 monorepo，只给后端索引 | `.cursorignore` 前端目录                   | 在后端 `.cursor/rules/` 放专属规则   |

这样一来，Cursor 既拿不到你不想暴露的文件，又能在你指定的"安全区"里自动 patch，协作起来就更可控、更安心了。
