---
layout: default
title: Demo Template
narrow: true
---

下面示例用 **Markdown 代码块** 给出，可直接复制修改。为简洁起见，只保留最关键段落。

### 2.1 `README.md`

````markdown
# My Awesome Project 🚀

A TypeScript + React web app that turns Markdown notes into spaced-repetition flashcards.

## Tech Stack

- Frontend: React 18, Vite, Tailwind CSS
- Backend: FastAPI, PostgreSQL
- Infra: Docker Compose, GitHub Actions CI

## Quick Start

```bash
git clone https://github.com/username/awesome.git
cd awesome
cp .env.example .env            # fill DB creds
docker compose up -d            # runs DB + API
pnpm i && pnpm dev              # starts frontend
```
````

## Directory Layout

```
├─ src/             # React components
├─ server/          # FastAPI routes
├─ docs/            # additional specs
└─ tests/           # Playwright end-to-end
```

## Contributing

1. Create a feature branch
2. Write **unit tests**
3. Run `pnpm test` & `pnpm lint`
4. Submit PR, follow the PR template

**Tips**：

- 把“如何本地跑起来”写清楚，AI 生成脚本/说明时就会沿用正确命令。
- 用目录树说明模块，方便 AI 定位代码文件。

---

### 2.2 `ROADMAP.md`

```markdown
# Roadmap

| Milestone                  | ETA (Q) | Status         | Notes                       |
| -------------------------- | ------- | -------------- | --------------------------- |
| **v0.1** MVP import/export | 2025-Q2 | ✅ Done        | basic CRUD + flashcard algo |
| **v0.2** Cloud Sync        | 2025-Q3 | 🔄 In-Progress | use Supabase storage        |
| **v1.0** Mobile PWA        | 2025-Q4 | ⏳ Planned     | offline mode, push notif    |

### v0.2 Detailed Goals

- [x] OAuth (GitHub + Google)
- [ ] Real-time sync via WebSocket
- [ ] Conflict resolution strategy spec

> Stretch:
>
> - AI-assisted cloze card generation
```

---

### 2.3 `TODO.md`

```markdown
# TODO (next 2 sprints)

- [ ] **Refactor** `/api/cards` to use async/await
- [ ] **Write tests** for `CardScheduler` edge cases
- [ ] Add dark-mode toggle (design in Figma @fig:123)
- [ ] Migrate CI from Travis → GitHub Actions
- [x] Upgrade Tailwind to v4 beta ← done in #42
```

_使用复选框 (`- [ ] / - [x]`) 让 Cursor / GitHub 渲染状态；LLM 也能一眼区分已做与未做。_

---

### 2.4 `CHANGELOG.md`

```markdown
# Changelog

All notable changes follow [Keep a Changelog](https://keepachangelog.com) and SemVer.

## [0.1.1] – 2025-05-12

### Fixed

- 🐛 Hot-reload crash on Windows (#38)
- 🐛 Incorrect timezone on flashcard review (#40)

## [0.1.0] – 2025-04-28

### Added

- 🎉 MVP: create / edit / delete notes
- Spaced-repetition scheduler (SM-2)
- Docker Compose for dev DB
```

> **做法**：每发版本就追加一节。这样 AI 写 Release Notes、生成升级脚本时能准确引用变更记录。
