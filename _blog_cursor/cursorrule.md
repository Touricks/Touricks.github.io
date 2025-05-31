---
layout: default
title: CursorRule
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

MCP

- **深度学习框架**：PyTorch / JAX 基本操作、Autograd
- **Transformer 理论**：Self-Attention、位置编码、多任务微调
- **评估与标注**：BLEU / ROUGE / QWK / GPT-Judge 等
- **Prompt Engineering Patterns**
  - Chain-of-Thought、ReACT、System + Few-Shot 模板
- **Retrieval-Augmented Generation (RAG)**
  - 向量索引（FAISS / Milvus）、检索重排序、MCP / OpenAI Tools 调用
- **Parameter-Efficient Fine-Tuning**
  - LoRA/QLoRA、Adapter、DPO/SFT、连续提示（Prefix/P-Tuning v2）
- **任务特化评估 & 统计显著性**

  - 置信区间、A/B + online metrics、红队测试

- GoogleCloud 面试

  - 数据库方面面试 vs AI 方面面试

- MCP 搭建学习路线

- Redis -> DB -> Kafka 学习路线
  -
