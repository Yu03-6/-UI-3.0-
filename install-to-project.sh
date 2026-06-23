#!/usr/bin/env bash
# 将 Cursor 规则/Skill 安装到目标项目根目录。
# 模版与指南仅保留在本套件目录内，不会复制 *-模版.md 到项目根。
#
# 用法：
#   cd 前端UI开发套件3.0交互补全版（未实验） && ./install-to-project.sh /path/to/ProjectRoot
#   cd 前端UI开发套件3.0交互补全版（未实验） && ./install-to-project.sh .. --init-project-docs
#   # 若套件目录位于项目根内，直接运行 ./install-to-project.sh 默认安装到上一级项目根
#
# 选项：
#   --init-project-docs   若项目根尚无项目文档，从本套件模版生成（生成的是项目文档，不是模版副本）

set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
CALL_DIR="$(pwd -P)"
TARGET=""
INIT_PROJECT_DOCS=0

for arg in "$@"; do
  case "$arg" in
    --init-project-docs) INIT_PROJECT_DOCS=1 ;;
    -*) echo "未知选项: $arg" >&2; exit 1 ;;
    *)
      if [[ -z "$TARGET" ]]; then
        TARGET="$arg"
      else
        echo "多余参数: $arg" >&2; exit 1
      fi
      ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  if [[ "$CALL_DIR" == "$KIT_DIR" ]]; then
    TARGET=".."
  else
    TARGET="."
  fi
fi

if [[ ! -d "$TARGET" ]]; then
  echo "错误：目标目录不存在: $TARGET" >&2
  exit 1
fi

TARGET="$(cd "$TARGET" && pwd -P)"

if [[ "$TARGET" == "$KIT_DIR" ]]; then
  echo "错误：安装目标不能是套件目录本身，否则 Cursor 仍读不到项目根 Skill。" >&2
  echo "请传入项目根目录，例如：" >&2
  echo "  ./install-to-project.sh .. --init-project-docs" >&2
  echo "  ./install-to-project.sh /path/to/ProjectRoot --init-project-docs" >&2
  exit 1
fi

echo "套件目录: $KIT_DIR"
echo "安装目标: $TARGET"
echo "模版位置: 仅保留在套件目录（不复制到项目根）"
echo ""

merge_copy() {
  local src="$1"
  local dest="$2"
  mkdir -p "$dest"
  cp -R "$src/." "$dest/"
  echo "  已合并: $(basename "$dest")/"
}

copy_project_doc() {
  local src="$1"
  local dest="$2"
  awk 'NR == 1 { sub(/【通用模版】/, "") } { print }' "$src" > "$dest"
}

echo "[1/1] 安装 Cursor 规则、Skill 与交互推断词典 → 项目根 .cursor/"
merge_copy "$KIT_DIR/.cursor" "$TARGET/.cursor"

if [[ "$INIT_PROJECT_DOCS" -eq 1 ]]; then
  echo ""
  echo "[可选] 从套件模版初始化项目文档（非模版副本）"
  if [[ ! -f "$TARGET/架构需求.md" ]]; then
    copy_project_doc "$KIT_DIR/架构需求-模版.md" "$TARGET/架构需求.md"
    echo "  已创建: 架构需求.md（请搜索【补齐占位符）"
  else
    echo "  保留已有: 架构需求.md"
  fi
  if [[ ! -f "$TARGET/AGENTS.md" ]]; then
    copy_project_doc "$KIT_DIR/AGENTS-模版.md" "$TARGET/AGENTS.md"
    echo "  已创建: AGENTS.md"
  else
    echo "  保留已有: AGENTS.md"
  fi
  if [[ ! -f "$TARGET/像素还原清单.md" ]]; then
    copy_project_doc "$KIT_DIR/像素还原清单-模版.md" "$TARGET/像素还原清单.md"
    echo "  已创建: 像素还原清单.md"
  else
    echo "  保留已有: 像素还原清单.md"
  fi
  if [[ ! -f "$TARGET/资源导入清单.md" ]]; then
    copy_project_doc "$KIT_DIR/资源导入清单-模版.md" "$TARGET/资源导入清单.md"
    echo "  已创建: 资源导入清单.md"
  else
    echo "  保留已有: 资源导入清单.md"
  fi
fi

echo ""
echo "安装完成。模版仍在套件目录："
echo "  $KIT_DIR"
echo ""
echo "验证 Skill 路径："
echo "  ./verify-kit-install.sh \"$TARGET\""
echo ""
echo "引用模版时请 @ 套件内路径，例如："
echo "  @$(basename "$KIT_DIR")/架构需求-模版.md"
echo ""
echo "3.0 提示词建议："
echo "  @架构需求.md 请按 frontend-ui-from-spec 执行：先生成屏幕清单和像素清单；规划阶段递归扫描 §2 可用切图/内容素材，导入或暂存运行时资源并完整写入 资源导入清单.md；再生成组件/弹窗/状态按钮/交互蓝图；最后按阶段门禁逐屏实现，页面只能使用资源清单中已导入的切图或现有工程 Assets。"
