#!/usr/bin/env bash
# 检查套件内容版本与交付文档质量。
# 默认你已把 .cursor 等内容放到项目根，因此不再校验 .cursor 放置位置/是否安装。
# 用法：./verify-kit-install.sh [项目根路径，默认 ..]

set -euo pipefail

TARGET="${1:-..}"
TARGET="$(cd "$TARGET" && pwd)"

PASS=0
FAIL=0
WARN=0

ok()   { echo "  [OK]   $1"; PASS=$((PASS + 1)); }
fail() { echo "  [FAIL] $1"; FAIL=$((FAIL + 1)); }
warn() { echo "  [WARN] $1"; WARN=$((WARN + 1)); }
info() { echo "  [INFO] $1"; }

echo "检查项目: $TARGET"
echo ""

echo "── 套件内容版本检查（默认 .cursor 已放置，不校验放置位置）──"
if [[ -f "$TARGET/.cursor/skills/frontend-ui-from-spec/SKILL.md" ]] \
  && grep -q "First-Run Ledger Gate" "$TARGET/.cursor/skills/frontend-ui-from-spec/SKILL.md"; then
  ok "首轮清单回写门槛已安装"
else
  warn "未检测到首轮清单回写门槛：建议重新安装最新版套件，避免首遍只改代码不写清单"
fi

if [[ -f "$TARGET/.cursor/skills/frontend-ui-from-spec/SKILL.md" ]] \
  && grep -q "Planning Asset Import Gate" "$TARGET/.cursor/skills/frontend-ui-from-spec/SKILL.md"; then
  ok "规划阶段资源导入门槛已安装"
else
  warn "未检测到规划阶段资源导入门槛：建议重新安装最新版套件，避免未整理切图就开始搭页面"
fi

if [[ -f "$TARGET/.cursor/skills/frontend-ui-from-spec/SKILL.md" ]] \
  && grep -q "Stage Gate Order" "$TARGET/.cursor/skills/frontend-ui-from-spec/SKILL.md"; then
  ok "阶段顺序门禁已安装"
else
  warn "未检测到阶段顺序门禁：建议重新安装最新版套件，避免跳阶段执行"
fi

if [[ -f "$TARGET/.cursor/skills/frontend-ui-from-spec/SKILL.md" ]] \
  && grep -q "screenshot matrix\\|全量截图\\|截图矩阵" "$TARGET/.cursor/skills/frontend-ui-from-spec/SKILL.md"; then
  ok "全量截图矩阵门禁已安装"
else
  warn "未检测到全量截图矩阵门禁：建议重新安装最新版套件，避免只随机抽检截图"
fi

if [[ -f "$TARGET/.cursor/rules/frontend-ui-kit-bootstrap.mdc" ]] \
  && grep -q "First-run ledger gate" "$TARGET/.cursor/rules/frontend-ui-kit-bootstrap.mdc"; then
  ok "Bootstrap rule 含首轮清单门槛"
else
  warn "Bootstrap rule 未含首轮清单门槛"
fi

if [[ -f "$TARGET/.cursor/rules/frontend-ui-kit-bootstrap.mdc" ]] \
  && grep -q "Planning asset import gate" "$TARGET/.cursor/rules/frontend-ui-kit-bootstrap.mdc"; then
  ok "Bootstrap rule 含规划资源导入门槛"
else
  warn "Bootstrap rule 未含规划资源导入门槛"
fi

if [[ -f "$TARGET/.cursor/rules/frontend-ui-kit-bootstrap.mdc" ]] \
  && grep -q "screenshot matrix\\|全量截图\\|截图矩阵" "$TARGET/.cursor/rules/frontend-ui-kit-bootstrap.mdc"; then
  ok "Bootstrap rule 含全量截图矩阵门槛"
else
  warn "Bootstrap rule 未含全量截图矩阵门槛"
fi

echo ""
echo "── 需求与交付文档 ──"
[[ -f "$TARGET/架构需求.md" ]] && ok "架构需求.md" || warn "缺少 架构需求.md（Rule 仅在打开/引用该文件时强触发）"
[[ -f "$TARGET/AGENTS.md" ]] && ok "AGENTS.md" || warn "缺少 AGENTS.md"
if [[ -f "$TARGET/像素还原清单.md" ]]; then
  ok "像素还原清单.md"
  if grep -q "开发状态" "$TARGET/像素还原清单.md" && grep -q "交互绑定" "$TARGET/像素还原清单.md" && grep -q "像素验收" "$TARGET/像素还原清单.md" && grep -q "工程证据/问题" "$TARGET/像素还原清单.md"; then
    ok "像素清单为 3.0 实现/交互/像素验收格式"
  else
    warn "像素清单可能仍是旧版：建议增加「开发状态 / 交互绑定 / 像素验收 / 工程证据/问题」列"
  fi
  if grep -q "截图状态" "$TARGET/像素还原清单.md" \
    && grep -q "目标原稿" "$TARGET/像素还原清单.md" \
    && grep -q "实现截图" "$TARGET/像素还原清单.md" \
    && grep -q "对比证据" "$TARGET/像素还原清单.md" \
    && grep -q "差异等级" "$TARGET/像素还原清单.md" \
    && grep -q "返修状态" "$TARGET/像素还原清单.md"; then
    ok "像素清单包含全量截图矩阵字段"
  else
    warn "像素清单缺少全量截图矩阵字段：建议增加「截图状态 / 目标原稿 / 实现截图 / 对比证据 / 视口/设备 / 差异等级 / 返修状态」"
  fi
  if grep -q "界面名称/状态\\|页面/状态" "$TARGET/像素还原清单.md"; then
    ok "像素清单包含界面名称/状态列"
  else
    warn "像素清单缺少「界面名称/状态」列：还原清单可能只列文件名，建议按 §3 页面/状态补齐"
  fi
  if grep -q "【由命名推断】\\|【原稿文件名】\\|【待创建/待定】" "$TARGET/像素还原清单.md"; then
    warn "像素清单仍有模板占位：请把原稿文件、界面名称/状态、对应实现替换为实际推断结果"
  else
    ok "像素清单无明显屏幕覆盖占位"
  fi
else
  warn "可选：从 像素还原清单-模版.md 复制并维护"
fi
if [[ -f "$TARGET/资源导入清单.md" ]]; then
  ok "资源导入清单.md"
  if grep -q "推断产物" "$TARGET/资源导入清单.md" && grep -q "推断交互" "$TARGET/资源导入清单.md" && grep -q "绑定状态" "$TARGET/资源导入清单.md"; then
    ok "资源清单为 3.0 资源/推断产物/交互绑定格式"
  else
    warn "资源清单可能仍是旧版：建议增加「推断产物 / 推断交互 / 置信度 / 绑定状态」列"
  fi
else
  warn "可选：从 资源导入清单-模版.md 复制并维护"
fi

echo ""
echo "── 3.0 同步质量检查 ──"
if [[ -f "$TARGET/架构需求.md" ]]; then
  if grep -q "| 【】 | 【】 | 【" "$TARGET/架构需求.md"; then
    warn "架构需求.md 仍有模板占位表行：建议按 §10 变更记录反查并补齐 §4.2/§4.3 等章节"
  else
    ok "架构需求.md 无明显模板占位表行"
  fi

  PROJECT_NAME="$(basename "$TARGET")"
  if [[ "$PROJECT_NAME" != "hdxc" ]] && grep -q "hdxc\\.xcworkspace\\|Scheme \`hdxc\`\\|Scheme hdxc" "$TARGET/架构需求.md"; then
    warn "架构需求.md 启动方式疑似保留案例项目 hdxc 名称，请核对 workspace/scheme 是否应为 $PROJECT_NAME"
  fi

  if grep -q "^## 10\\. 变更记录" "$TARGET/架构需求.md"; then
    ok "架构需求.md 含 §10 变更记录"
  else
    warn "架构需求.md 未找到 §10 变更记录"
  fi

  if grep -q "前置条件" "$TARGET/架构需求.md" && grep -q "状态同步\\|失败路径\\|失败/取消" "$TARGET/架构需求.md"; then
    ok "交互登记包含完整性字段（前置条件/状态同步/失败路径）"
  else
    warn "交互登记可能仍是旧口径：建议 §4.2 增加前置条件、状态同步/失败路径等完整性字段"
  fi

  if grep -q "键盘\\|keyboard\\|输入栏\\|发送栏\\|composer" "$TARGET/架构需求.md" \
    && { [[ ! -f "$TARGET/像素还原清单.md" ]] || grep -q "键盘\\|keyboard\\|输入栏\\|发送栏\\|composer" "$TARGET/像素还原清单.md"; }; then
    ok "键盘/输入栏避让已有文档证据"
  else
    warn "未发现键盘/输入栏避让证据：消息发送栏、评论栏、搜索/表单页需记录不被系统键盘遮挡"
  fi

  if grep -q "全量截图\\|截图矩阵\\|目标原稿.*实现截图\\|实现截图.*对比证据" "$TARGET/架构需求.md" \
    && { [[ ! -f "$TARGET/像素还原清单.md" ]] || grep -q "截图状态\\|对比证据\\|差异等级" "$TARGET/像素还原清单.md"; }; then
    ok "全量截图矩阵已有文档证据"
  else
    warn "未发现全量截图矩阵证据：每个页面/弹窗/状态需记录目标原稿、实现截图、对比证据、差异等级和返修状态"
  fi

  if grep -q "默认不要求截图\\|可选抽检\\|截图/diff.*可选\\|spot-check" "$TARGET/架构需求.md" \
    || { [[ -f "$TARGET/像素还原清单.md" ]] && grep -q "默认不要求截图\\|可选抽检\\|截图/diff.*可选\\|spot-check" "$TARGET/像素还原清单.md"; }; then
    warn "检测到旧截图抽检口径：请改为全量截图矩阵验收"
  else
    ok "未发现旧截图抽检口径"
  fi

  if [[ -f "$TARGET/像素还原清单.md" ]] && grep -q "^|.*原稿文件.*页面/状态" "$TARGET/架构需求.md"; then
    ARCH_ORIGINALS=$(awk '
      BEGIN { in_section=0 }
      /^## 3[. ]/ { in_section=1; next }
      /^## [4-9][. ]/ { in_section=0 }
      in_section && /^\|/ && $0 !~ /---/ && $0 !~ /原稿文件/ && $0 !~ /自动/ && $0 !~ /【/ {
        n=split($0, cols, "|")
        gsub(/^[ \t]+|[ \t]+$/, "", cols[3])
        if (cols[3] != "") print cols[3]
      }
    ' "$TARGET/架构需求.md" | sort -u)
    if [[ -n "$ARCH_ORIGINALS" ]]; then
      MISSING_ORIGINALS=""
      while IFS= read -r original; do
        if [[ -n "$original" ]] && ! grep -Fq "$original" "$TARGET/像素还原清单.md"; then
          MISSING_ORIGINALS="${MISSING_ORIGINALS}${original}, "
        fi
      done <<< "$ARCH_ORIGINALS"
      if [[ -n "$MISSING_ORIGINALS" ]]; then
        warn "像素清单未覆盖部分 §3 原稿文件: ${MISSING_ORIGINALS%, }"
      else
        ok "像素清单覆盖 §3 原稿文件"
      fi
    fi
  fi
fi

if [[ -f "$TARGET/AGENTS.md" ]]; then
  if grep -q "【通用模版】" "$TARGET/AGENTS.md"; then
    warn "AGENTS.md 仍像通用模板：建议按项目 §6 能力边界和 §10 变更记录同步"
  else
    ok "AGENTS.md 不含通用模板标题"
  fi
  if grep -q "自制.*替代\\|替代图案\\|替代图片\\|缺失切图" "$TARGET/AGENTS.md"; then
    ok "AGENTS.md 含严格切图资源约束"
  else
    warn "AGENTS.md 未明确禁止自制替代图：建议同步最新资源约束"
  fi
fi

if [[ -f "$TARGET/架构需求.md" && -f "$TARGET/AGENTS.md" ]]; then
  if grep -q "StoreKit\\|IAP\\|Apple 登录\\|Apple Sign\\|PHPicker\\|摄像头\\|WebView\\|账号删除" "$TARGET/架构需求.md" \
    && ! grep -q "StoreKit\\|IAP\\|Apple 登录\\|Apple Sign\\|PHPicker\\|摄像头\\|WebView\\|账号删除" "$TARGET/AGENTS.md"; then
    warn "架构需求.md 记录了真实/高风险能力，但 AGENTS.md 未同步相关关键词"
  else
    ok "AGENTS.md 与能力边界关键词无明显脱节"
  fi
fi

echo ""
echo "── 套件目录（模版与指南）──"
KIT_DIR=$(find "$TARGET" -maxdepth 2 -type d -name '前端UI开发套件*' 2>/dev/null | head -1 || true)
if [[ -n "$KIT_DIR" && -f "$KIT_DIR/架构需求-模版.md" ]]; then
  ok "套件模版目录: $KIT_DIR"
else
  info "未在项目内找到套件目录；如果你从项目外安装，这是正常的"
fi

if [[ -f "$TARGET/架构需求-模版.md" || -f "$TARGET/AGENTS-模版.md" ]]; then
  warn "项目根存在 *-模版.md — 应删除，模版只保留在套件目录内"
fi

if [[ -f "$TARGET/架构需求-模版.md" && -f "$TARGET/README.md" ]]; then
  shopt -s nullglob
  CASE_FILES=("$TARGET"/案例-*.md)
  shopt -u nullglob
  if [[ ${#CASE_FILES[@]} -eq 7 \
    && -f "$TARGET/案例-hdxc架构需求.md" \
    && -f "$TARGET/案例-hdxc资源导入清单.md" \
    && -f "$TARGET/案例-hdxc像素还原清单.md" \
    && -f "$TARGET/案例-hdxcAGENTS.md" \
    && -f "$TARGET/案例-qxxq可复用规则复盘.md" \
    && -f "$TARGET/案例-lygl可复用规则复盘.md" \
    && -f "$TARGET/案例-clsj可复用规则复盘.md" ]]; then
    ok "套件案例包含 hdxc 四件套与 qxxq/lygl/clsj 规则复盘"
  else
    warn "套件案例应包含 hdxc 四件套与 qxxq/lygl/clsj 规则复盘：案例-hdxc架构需求/资源导入清单/像素还原清单/AGENTS + 案例-qxxq可复用规则复盘 + 案例-lygl可复用规则复盘 + 案例-clsj可复用规则复盘"
  fi
  OLD_CASE_A="案例-lg""dz"
  OLD_CASE_B="案例-ds""sj"
  if grep -R -q -e "$OLD_CASE_A" -e "$OLD_CASE_B" "$TARGET" 2>/dev/null; then
    warn "套件文档仍包含旧案例引用：$OLD_CASE_A 或 $OLD_CASE_B"
  else
    ok "套件文档无旧案例引用"
  fi
fi

echo ""
echo "── Skill 触发说明 ──"
echo "  1. 强触发：对话中 @架构需求.md，或打开 架构需求.md 后继续聊天"
echo "  2. 弱触发：frontend-ui-kit-bootstrap 规则在检测到 架构需求.md 时常驻引导"
echo "  3. 手动触发：输入「按 frontend-ui-from-spec skill 执行」并 @架构需求.md"
echo "  4. 屏幕清单：设计原稿命名可生成 §3 和像素清单初始行"
echo "  5. 蓝图生成：切图命名可生成组件/弹窗/状态按钮/交互蓝图；真实登录/支付/AI/媒体/后端能力仍以 §6 为准"
echo "  6. 首轮门槛：第一遍运行必须先回写资源清单和像素清单，不能只改代码"
echo "  7. 资源门槛：规划阶段必须先导入/整理全部可用切图并写入资源清单"
echo "  8. 阶段门槛：按安装/读取 → 屏幕清单 → 资源整理 → 交互蓝图 → P0 实现 → P0 全量截图对比 → P1 实现 → P1 全量截图对比 → P2 实现 → P2 全量截图对比 → 最终验收顺序执行"
echo "  9. 资源约束：页面图像只能使用 §2 可用切图或现有 Assets；缺图登记待补，不自制替代图"
echo "  10. 截图矩阵：每个页面/弹窗/状态必须记录目标原稿、实现截图、对比证据、差异等级和返修状态"
echo "  11. 按钮模式：Sweeli/hdxc/qxxq/lygl/clsj 项目按钮操作模式可辅助补齐常见交互"
echo ""

if [[ $FAIL -eq 0 ]]; then
  echo "结果: 通过 ($PASS OK, $WARN WARN)"
  exit 0
else
  echo "结果: 未通过 ($FAIL FAIL, $PASS OK, $WARN WARN)"
  exit 1
fi
