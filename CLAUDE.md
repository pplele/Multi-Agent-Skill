# CLAUDE.md — Multi-Agent Dev Skill

## 这是什么

一个纯 Claude Code Skill。零依赖 — Claude Code 读取 `.claude/skills/dev-team.md` 中的 Skill 定义，在 5 个角色（项目负责人 → PM（产品经理） → TechLead（技术负责人） → QA（测试工程师） → 修复工程师）之间轮换，驱动结构化的软件开发生命周期。不需要 LangGraph、不需要 Python 运行时、不需要外部工具。

## 如何触发

```
/dev-team 帮我做一个带用户认证的任务管理应用
```

或者当用户说"帮我做一个..."、"创建一个项目..."、"开发一个系统..."、"帮我加/改..."时自动触发。

## 工作原理

`.claude/skills/dev-team.md` 定义了：
1. **5 个角色** — 项目负责人（调度）、PM、TechLead（含 Frontend/Backend/DeliveryManager 子身份）、QA、修复工程师
2. **7 阶段工作流** — 入口分叉 → 需求澄清 → 技术评估 → 方案终审 → 编码 → 测试 → 交付
3. **人工确认检查点** — 每个阶段转换需要用户输入明确的确认命令
4. **前端设计系统** — 内嵌 Design Token（颜色、字体、间距、动画），确保 UI 不千篇一律
5. **接口契约模式** — 编码前，后端先定义 API 契约，前端确认，双方按契约并行开发
6. **安全规则** — OWASP Top 10 融入所有角色的行为
7. **状态持久化** — `.claude/dev-team-state.json` 记录进度，上下文压缩/中断后可断点续接
8. **输出精炼** — 内化 Token-Saver-Optimizer 压缩策略，角色从源头精简输出，不堆废话

## 关键设计决策

- **不需要 LangGraph。** Claude Code 本身就是状态机。角色切换代替 Agent 编排。
- **所有用户输入先过项目负责人。** 8 级优先级表判断意图，功能增删改在编码/测试阶段会被拦截回 PM。
- **前后端分离通过子身份实现，不是独立 Agent。** 同一个 TechLead，不同帽子。通过 API 契约来"对话"。
- **前端美感强制要求。** 每个前端输出必须对照内嵌设计系统说明设计决策。
- **Bug 修复上限 3 轮。** 3 轮 QA↔修复循环后，第 4 轮转为报错驱动的环境排查。
- **状态文件防丢进度。** 上下文压缩或中断后，重调 /dev-team 自动检测状态文件，选继续或重来。
- **输出精炼内化。** Token-Saver-Optimizer 的 6 条压缩规则融入所有角色行为，从源头控 Token，不做后处理。

## Skill 文件

所有内容在 `.claude/skills/dev-team.md` 中，包含：
- 12 条核心规则（含状态持久化、输出精炼）
- 5 个角色定义（项目负责人、PM、TechLead、QA、修复工程师）
- 7 阶段工作流（Phase 0-4c）
- Design Token 和组件样式规范
- 默认技术栈与决策矩阵
- 安全规则 + 运行时验证规则
- 确认命令速查表（含断点续接和环境覆写）
- 交付物模板（PRD、技术方案、测试报告、交付包）
- 模块交付清单模板（含测试文件列）
- 可运行性验证流程（冒烟测试）
- 目标环境确认机制（IDE/OS/部署平台）
- 状态持久化格式与保存时机

## 安装

```bash
# 全局安装（推荐，所有项目可用）
bash install.sh      # Mac/Linux
install.bat           # Windows

# 或手动复制
cp .claude/skills/dev-team.md ~/.claude/skills/dev-team.md
```
