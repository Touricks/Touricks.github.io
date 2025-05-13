---
layout: post
title: "算法学习笔记"
date: 2025-05-13
categories: [算法]
tags: [算法, 学习笔记]
---

> 本页自动收录 \_algorithms 目录下所有算法文档，无需手动维护！

## 前言

- 这里是算法部分的总目录，下属一级目录
- 一级目录：算法
- 二级目录：算法使用的数据结构（注意，一些算法只有线性结构，或未收录，则省略该级目录）
- 三级目录：使用对应数据结构和算法的例题

目前收录以下算法：
Binary Search
Two-Pointer
Recursion
DFS
BFS
DP

## 算法目录

<ul>
{% assign algorithms = site.algorithms | where_exp: "algo", "algo.path contains 'binarysearch' or algo.path contains 'twopointer' or algo.path contains 'recursion' or algo.path contains 'dfs' or algo.path contains 'bfs' or algo.path contains 'dp'" %}
{% for algo in algorithms %}
  <li><a href="{{ algo.url }}">{{ algo.title }}</a></li>
{% endfor %}
</ul>

---
