# Frontend UI Delivery Reference

## Kickoff Prompt

```markdown
@架构需求.md

请按 frontend-ui-from-spec 先做缺口审查。确认不阻塞后，按 P0→P1→P2 逐屏还原 UI。
第一遍运行时，先把推断结果写入 `资源导入清单.md`、`像素还原清单.md`、`架构需求.md` §3/§4.1/§4.2/§4.3；这些清单写入是编码前置条件，不是收尾步骤。
请先扫描设计原稿文件夹，按原稿命名自动生成/修正 §3 屏幕清单和像素清单；再扫描切图/资源命名，生成组件/弹窗/状态按钮/交互蓝图后开始编码。
规划阶段必须先递归扫描 §2 可用切图/内容素材路径，将所有运行时可用资源导入或暂存到工程资源目录，并完整写入 `资源导入清单.md`；未完成不得开始页面搭建。
页面图像只能使用 `资源导入清单.md` 中已导入的 §2 可用切图或现有工程 Assets；不要使用外部图片 URL、图标包、图库素材、AI 生成图、下载素材或非 §2 路径文件，也不要自行绘制或生成替代图案、图标、插画、头像、贴纸、背景。缺图先登记待补，除非用户明确同意占位。
必须按阶段门禁执行：安装/读取 -> 屏幕清单 -> 资源导入整理 -> 组件/交互蓝图 -> P0 实现 -> P0 全量截图对比 -> P1 实现 -> P1 全量截图对比 -> P2 实现 -> P2 全量截图对比 -> 最终验收，不可跳过某阶段直接进入下一步。
P0 截图矩阵未闭环不得进入 P1；P1 截图矩阵未闭环不得进入 P2。每个页面、弹窗、空态、加载态、错误态和关键变体都必须截图并与目标原稿对比。
请对照 project-interaction-patterns.md 补齐常见按钮操作：导航、登录、社交、举报拉黑、聊天评论、发布、充值、音视频、设置和黑名单。
低风险和安全本地演示交互可直接实现，中/高风险写为待确认，不要擅自接真实能力。
每屏完成后再次更新 `资源导入清单.md`、`像素还原清单.md` 和 `架构需求.md` §10。如果无法写入任一清单，请停止并说明原因，不要只改代码。
```

## Install Verification

```bash
cd 前端UI开发套件3.0交互补全版（未实验）
./install-to-project.sh /path/to/ProjectRoot --init-project-docs
./verify-kit-install.sh /path/to/ProjectRoot
```

Expected project root files:

| Check | Expected |
|---|---|
| Skill | `.cursor/skills/frontend-ui-from-spec/SKILL.md` |
| Rules | `.cursor/rules/*.mdc` |
| Spec | `架构需求.md` |
| Pixel checklist | `像素还原清单.md` |
| Asset list | `资源导入清单.md` |
| Screen inventory inference | `.cursor/skills/frontend-ui-from-spec/screen-inventory-inference.md` |
| Interaction inference | `.cursor/skills/frontend-ui-from-spec/interaction-inference.md` |
| Project button patterns | `.cursor/skills/frontend-ui-from-spec/project-interaction-patterns.md` |

## Gap Report

```markdown
## 需求缺口
- P0: 阻塞实现的问题。
- P1: 可带假设继续的问题。
- P2: 建议补充的问题。

## 可继续范围
- ...
```

## Required Spec Fields

- Project basics: platform, stack, project path, launch command, base design size.
- Design resources: originals, runtime cutouts/assets, fonts/colors.
- Runtime visuals: use only §2 allowed cutouts or existing project assets. Basic code-drawn UI primitives are allowed, but substitute graphics are not.
- Screen inventory: can be generated from design-original filenames; must include originals, pages, states, popups, priorities, implementation target, route/entry, confidence/notes.
- Interaction inference: §4.1 enabled/disabled, naming-derived component/popup/state blueprint scope, low-risk/local-demo auto-bind scope, must-confirm behaviors.
- Global UI: layout scale, safe area, scrolling, typography, color, popup style.
- Capability boundaries: UI-only vs real.
- Acceptance: pixel checklist, asset list, build/lint/test.
- Change-log reconciliation: §10 rows must land in the referenced sections, `AGENTS.md`, resource list, and pixel checklist with no stale template placeholder rows.

## Interaction Gap Report

```markdown
## 屏幕清单推断
| 优先级 | 原稿文件 | 页面/状态 | 类型 | 对应实现 | 入口/触发 | 备注 |
|---|---|---|---|---|---|---|

## 交互推断
| 模式/页面组件 | 资源名/切图名 | 触发 | 前置条件 | 推断结果 | 状态同步/失败路径 | 风险 | 状态 |
|---|---|---|---|---|---|---|---|

## 待确认
- ...
```

## Change-Log Audit

```markdown
## 变更同步审计
| 变更记录 | 应同步位置 | 当前状态 | 处理 |
|---|---|---|---|
| 2026-.. ... | §4.2 / §4.3 / §6 / AGENTS / 清单 | 已同步/缺失/占位残留 | 已补齐/待确认 |

## 占位残留
- ...
```

## Per-Screen Checklist

- [ ] Original/cutout path checked.
- [ ] First-run ledger gate satisfied: `资源导入清单.md` and `像素还原清单.md` already contain rows for current inferred screens/assets before UI code changes.
- [ ] Planning asset import gate satisfied: all §2 allowed cutouts/content assets have been scanned, imported/staged, named, and written to `资源导入清单.md` before page implementation.
- [ ] Stage gate order followed; no later stage or next priority started before earlier outputs and screenshot matrix rows were written.
- [ ] If §3 was empty/incomplete, design-original filenames were scanned and screen rows were generated.
- [ ] Existing §10 change records were checked against §3/§4.2/§4.3/§6/AGENTS/resource/pixel docs.
- [ ] Screen row has priority, original file, page/state, type, implementation target, route/entry, and confidence/notes.
- [ ] Runtime assets imported and listed in `资源导入清单.md`.
- [ ] Runtime visuals use only §2 allowed cutouts/existing assets; missing cutouts are recorded instead of replaced by self-made graphics.
- [ ] No external image URLs, icon packs, stock assets, AI-generated images, downloads, or arbitrary files outside §2 are used.
- [ ] Button/entry assets have inferred interaction, confidence, and binding status.
- [ ] Component/popup/state groups inferred from naming clusters are built or marked `待确认`.
- [ ] Common button behavior was checked against `project-interaction-patterns.md`.
- [ ] Each interaction pattern has trigger, precondition, result, state sync or failure/cancel path, risk, and binding status.
- [ ] Bottom composers, message/comment bars, search fields, and form input areas avoid the system keyboard and have stable height/bottom constraints.
- [ ] Similar inferred interactions are recorded once by pattern; repeated instances keep evidence in the asset and pixel checklists.
- [ ] Route/entry works or is documented.
- [ ] Low-risk and safe local-demo inferred interactions are wired; high-risk ones are recorded as assumptions or `待确认`.
- [ ] Layout uses project scale/token system.
- [ ] Short screen, safe area, scroll start, loading/empty/error states handled where relevant.
- [ ] Source/runtime paths do not reference design originals.
- [ ] `像素还原清单.md` row updated:
  - implementation status
  - interaction binding status
  - screenshot status
  - target original
  - implementation screenshot
  - comparison evidence
  - viewport/device
  - difference level
  - repair status
  - pixel QA status
  - engineering evidence
  - exceptions/repair notes
- [ ] Screenshot comparison recorded for every distinct page/state/dialog; spot checks are used only for repeated component instances after a representative pass.
- [ ] Build/lint/test run or skip reason recorded.

## Pixel Evidence

Minimum evidence for `像素验收通过`:

```text
route: ...
original: ...
file: ...
layout: ...
assets: ...
asset-source: ...
metrics: ...
interactions: ...
preconditions: ...
state-sync: ...
failure-path: ...
keyboard: ...
components: ...
screenshot: ...
compare: ...
viewport: ...
difference: ...
repair: ...
exceptions: 无例外
```

Screenshots are mandatory for every distinct screen, popup, state, and critical variant. Diffs, side-by-side comparison, or manual review notes are mandatory comparison evidence. Random spot checks cannot replace per-screen/state coverage.

## Final Acceptance

- [ ] All P0 screens implemented or deferred with reason, and P0 screenshot matrix is closed before P1 work.
- [ ] All P1 screens implemented or deferred with reason, and P1 screenshot matrix is closed before P2 work.
- [ ] Screen/state coverage matches design-original folder and `架构需求.md` §3.
- [ ] Asset list is complete.
- [ ] No arbitrary substitute images, icons, illustrations, textures, avatars, stickers, backgrounds, or decorative patterns were created.
- [ ] Naming-derived component/popup/interaction table is complete for button/entry/state assets.
- [ ] Interaction completeness matrix covers navigation, forms/auth, cards, social/moderation, media, publish, wallet/paywall, chat/AI, settings/account, and empty/error states when present.
- [ ] Keyboard avoidance is verified for every message/comment/search/form input screen; no composer is hidden behind the system keyboard.
- [ ] Similar interactions are de-duplicated by pattern, with applicable pages/resources recorded.
- [ ] No template placeholder rows remain in active project sections such as §4.2, §4.3, resource list, or global resources.
- [ ] No runtime design-original references.
- [ ] Pixel checklist has engineering evidence and screenshot comparison evidence for passed rows.
- [ ] Scope did not exceed declared capability boundaries.
- [ ] Remaining assumptions and repair items are listed.
