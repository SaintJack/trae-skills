# Trae Engineering Gate

这个私有仓库用于跨电脑同步个人 `Trae` 工程规范，核心目标是让 AI 在开发任务中默认遵循：

- 先做需求对齐
- 再做技术方案对齐
- 得到明确批准后再执行

## 仓库内容

- `skills/engineering-gate/SKILL.md`
  - `engineering-gate` Skill 的标准源文件
- `rules/project/engineering-gate.md`
  - 项目级规则，适合复制到目标项目的 `.trae/rules/`
- `rules/user/engineering-gate-global.md`
  - 全局用户规则模板，适合粘贴到 Trae 的 `User Rules`
- `agents/engineering-gate-agent.template.md`
  - 自定义 Agent 模板，适合在 Trae 中手动创建
- `scripts/install.sh`
  - macOS/Linux 安装脚本
- `scripts/install.ps1`
  - Windows PowerShell 安装脚本
- `scripts/sync-check.sh`
  - 检查目标项目中的 skill/rule 是否与仓库版本一致

## 推荐使用方式

### 1. 全局约束

将 `rules/user/engineering-gate-global.md` 的内容复制到：

- `Trae > Settings > Rules > User Rules`

这一步负责让所有项目默认遵循你的工程门禁。

### 2. 项目增强

在具体项目中安装：

- `.agents/skills/engineering-gate/SKILL.md`
- `.trae/rules/engineering-gate.md`

这一步负责让项目内的 Skill 和 Project Rule 同时生效。

### 3. Agent 模板

如果你希望 `SOLO Agent` 或自定义 Agent 更稳定地执行这套流程，可参考：

- `agents/engineering-gate-agent.template.md`

在 Trae 中手动创建一个自定义 Agent，并把模板里的内容填入对应字段。

## 新电脑恢复

1. 克隆此私有仓库
2. 将 `engineering-gate-global.md` 复制到 `User Rules`
3. 在目标项目中运行安装脚本

macOS/Linux:

```bash
bash scripts/install.sh --project /path/to/your/project
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -ProjectPath C:\path\to\your\project
```

## 更新流程

1. 在本仓库中修改 Skill / Rules / Agent 模板
2. 提交到私有 Git 仓库
3. 在其他电脑拉取最新版本
4. 重新运行安装脚本，或手动同步 `User Rules`

## 注意事项

- 目前没有明确官方文档说明“自定义 Skill 自动跨电脑云同步到 Trae 内置技能”
- 因此，这个仓库是你的单一事实来源
- `User Rules` 仍建议手动粘贴或自行维护到 Trae 设置中
