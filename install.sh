#!/usr/bin/env bash
# install.sh — 全局安装 dev-team skill
# 把 dev-team.md 复制到 ~/.claude/skills/，使所有项目的 Claude Code 都能发现它
set -euo pipefail

SKILL_DIR="${HOME}/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_SRC="${SCRIPT_DIR}/.claude/skills/dev-team.md"

mkdir -p "$SKILL_DIR"

if [ ! -f "$SKILL_SRC" ]; then
  echo "错误: 找不到 ${SKILL_SRC}"
  echo "请在 Multi-Agent-Skill 仓库根目录下运行此脚本。"
  exit 1
fi

cp "$SKILL_SRC" "$SKILL_DIR/dev-team.md"

echo "dev-team skill v4.4 已安装到 ${SKILL_DIR}/dev-team.md"
echo "现在在所有项目中输入 /dev-team 即可使用。"
