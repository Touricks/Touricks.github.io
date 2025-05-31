---
layout: default
title: (TopDown)
narrow: true
---

综述：
大多数树上路径问题都是 Bottom-up 的，在理论上，许多 Top-Down 问题可以被转换成 Bottom-Up 形式，但关键在于转换后的时间复杂度是否会退化。能否在不退化复杂度的前提下转换，取决于 Top-Down 过程中"向下传递的信息"的性质。

如果 Top-Down 方法中向下传递的状态包含了关于**节点祖先路径的复杂信息**，那么强行转换为 Bottom-Up 通常会导致每个节点返回一个巨大的、无法被简单聚合的数据结构，从而使时间复杂度退化。

核心判断法则：问自己一个问题：**"当我在节点 `N` 时，为了做出计算或判断，我需要的信息是来自它的【祖先】还是来自它的【子孙】？"**

1. 如果节点 `N` 的计算**依赖于它的祖先信息**（例如，从根节点到 `N` 的路径、`N` 的深度、从根到 `N` 的路径和），那么就用 **Top-Down (自顶向下)**。
2. 如果节点 `N` 的计算**依赖于它的子树的聚合信息**（例如，`N` 的左右子树的高度、节点数、最大/小值），那么就用 **Bottom-Up (自底向上)**。

按照这个标准判断，Path Sum to Target 类型的题目，就适合 TopDown，因为需要根节点到 N 的路径长度和

- 需要保存的参数：从根节点到当前节点之间的路径上需要的信息 + 转移到当前节点所需的信息
- PathSumI
  - 是否存在等于给定值的直上直下的路径
  - [BinaryTreePathSumtoTargetI](/algorithmnotes/binarytreepathsumtotargeti.html)
- PathSumII
  - 直上直下路径的最大值
  - [BinaryTreePathSumMAX](/algorithmnotes/binarytreepathsummax.html)
