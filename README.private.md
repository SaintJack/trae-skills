# Trae Engineering Gate

一套面向 `Trae` 的个人工程规范仓库，用于在不同电脑、不同项目之间同步统一的 AI 开发约束。

它的目标不是让 AI 更快开始写代码，而是让 AI 在复杂开发任务中默认遵循这条工程路径：

1. 先对齐需求
2. 再对齐技术方案
3. 获得明确批准后再执行

## 适用场景

- 你希望 `Trae SOLO` 在复杂任务中先问清楚再开工
- 你希望技术方案必须经过你批准后才能进入实现
- 你希望把个人工程纪律沉淀成可复用、可同步、可版本化的规范资产
- 你需要在多台电脑上快速恢复一致的 `Trae` 使用方式

## 核心能力

- `Skill`：为 AI 提供结构化工程门禁流程
- `Project Rule`：在具体项目内默认施加工程约束
- `User Rule`：在所有项目中默认保持一致的行为偏好
- `Agent Template`：为自定义 Agent 提供稳定的工作流模板
- `Install Scripts`：帮助新电脑和新项目快速落地这套规范

## 仓库结构

```text
trae-engineering-gate/
├── skills/
│   └── engineering-gate/
│       └── SKILL.md
├── rules/
│   ├── project/
│   │   └── engineering-gate.md
│   └── user/
│       └── engineering-gate-global.md
├── agents/
│   └── engineering-gate-agent.template.md
├── scripts/
│   ├── install.sh
│   ├── install.ps1
│   └── sync-check.sh
└── examples/
    ├── project-layout-example.md
    └── user-rule-usage-example.md
```

## 快速开始

### 1. 配置全局行为

将 `rules/user/engineering-gate-global.md` 的内容复制到：

- `Trae > Settings > Rules > User Rules`

这一步负责让所有项目默认遵循你的工程门禁。

### 2. 安装到目标项目

macOS / Linux:

```bash
bash scripts/install.sh --project /path/to/your/project
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -ProjectPath C:\path\to\your\project
```

安装完成后，目标项目中通常会生成：

- `.agents/skills/engineering-gate/SKILL.md`
- `.trae/rules/engineering-gate.md`

### 3. 按需创建自定义 Agent

如果你希望 `SOLO Agent` 或其他自定义 Agent 更稳定地使用这套流程，可参考：

- `agents/engineering-gate-agent.template.md`

在 Trae 中手动创建一个自定义 Agent，并将模板中的字段填入对应配置项。

## 工作方式

这套规范采用三层协同：

- `User Rules`：负责全局行为约束，确保所有项目都先对齐再执行
- `Project Rules`：负责当前项目的默认规则，提升仓库内一致性
- `Skill / Agent`：负责把工程流程结构化，便于 AI 稳定执行

推荐组合是：

1. 全局启用 `User Rule`
2. 目标项目安装 `Project Rule + Skill`
3. 对复杂任务使用 `Engineering Gate Agent` 或 `SOLO Agent + engineering-gate`

## 跨电脑同步

在新电脑上恢复这套规范的推荐步骤：

1. 克隆此私有仓库
2. 将 `rules/user/engineering-gate-global.md` 复制到 `User Rules`
3. 在需要的项目里执行安装脚本
4. 如果有自定义 Agent 需求，按模板重新创建

## 更新流程

当你需要迭代规范时：

1. 在本仓库中修改 `Skill / Rules / Agent Template / Scripts`
2. 提交并推送到私有 Git 仓库
3. 在其他电脑拉取最新版本
4. 重新执行安装脚本，或手动同步 `User Rules`

## 校验同步状态

你可以使用以下脚本检查目标项目中的文件是否与仓库源文件一致：

```bash
bash scripts/sync-check.sh /path/to/your/project
```

## 设计原则

- 不追求“尽快写代码”，优先“先把事情定义清楚”
- 不接受需求未清时直接抢跑执行
- 不接受技术方案未经批准就进入实现
- 不把个人习惯写成一次性 Prompt，而是沉淀成长期可维护的规范资产

## 已知限制

- 目前没有明确官方文档说明“自定义 Skill 会自动跨电脑云同步到 Trae 内置技能”
- 因此，这个仓库应视为你的单一事实来源
- `User Rules` 仍建议通过 Trae 设置手动粘贴或手动维护
