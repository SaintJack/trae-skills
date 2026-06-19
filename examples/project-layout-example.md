# Example Project Layout

当你将本仓库的工程门禁安装到某个项目后，目标项目通常会出现如下结构：

```text
your-project/
├── .agents/
│   └── skills/
│       └── engineering-gate/
│           └── SKILL.md
└── .trae/
    └── rules/
        └── engineering-gate.md
```

说明：

- `.agents/skills/engineering-gate/SKILL.md`
  - 项目内可被加载的 Skill
- `.trae/rules/engineering-gate.md`
  - 项目内始终生效的工程门禁规则

如果你还需要全局约束，请将：

- `rules/user/engineering-gate-global.md`

中的内容复制到 Trae 的 `User Rules`。
