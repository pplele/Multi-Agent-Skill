@echo off
REM install.bat — 全局安装 dev-team skill（Windows）
REM 把 dev-team.md 复制到 ~/.claude/skills/，使所有项目的 Claude Code 都能发现它

set "SKILL_DIR=%USERPROFILE%\.claude\skills"
set "SKILL_SRC=%~dp0.claude\skills\dev-team.md"

if not exist "%SKILL_DIR%" mkdir "%SKILL_DIR%"

if not exist "%SKILL_SRC%" (
  echo 错误: 找不到 %SKILL_SRC%
  echo 请在 Multi-Agent-Skill 仓库根目录下运行此脚本。
  pause
  exit /b 1
)

copy /Y "%SKILL_SRC%" "%SKILL_DIR%\dev-team.md"

echo dev-team skill v4.4 已安装到 %SKILL_DIR%\dev-team.md
echo 现在在所有项目中输入 /dev-team 即可使用。
pause
