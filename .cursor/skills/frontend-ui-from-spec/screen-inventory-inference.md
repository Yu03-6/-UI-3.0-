# Design Original Screen Inventory Inference

Use this reference before implementation when `架构需求.md` has a design-original folder but §3 screen list is empty, incomplete, or manually stale.

The user should not need to declare every screen. Cursor must scan design original filenames, directory names, nearby cutout folders, existing code routes, and kit cases to generate a first screen inventory with priority, original file, page/state, type, implementation target, entry/trigger, confidence, and notes.

## Required Scan

1. Read `架构需求.md` §2 and locate the design-original folder. Common names: `设计图原稿`, `原稿`, `design`, `figma-export`, `screens`, `mockups`.
2. List image/design files recursively in stable sort order. Include common extensions: `png`, `jpg`, `jpeg`, `webp`, `pdf`, `sketch`, `fig`, `psd`.
3. Preserve the original filename exactly in the `原稿文件` column.
4. Normalize a second copy for inference: lowercase, remove scale suffixes (`@2x`, `@3x`), extension, punctuation, spaces, and duplicate separators.
5. Group variants by shared stem: `登录`, `登录-错误`, `登录-加载`, `视频聊天-2`, `直播大厅-empty`, `settings_popup_delete`.
6. Compare against existing routes/files when present; otherwise infer implementation target from platform conventions.
7. Generate or repair `架构需求.md` §3 and initialize/update `像素还原清单.md` with the same screen rows.
8. In `像素还原清单.md`, every row must include both the exact `原稿文件` and a non-empty `界面名称/状态` that matches the §3 `页面/状态` value. Do not leave only filenames, implementation paths, status labels, or template placeholders.
9. If the filename is ambiguous, use `待确认：<normalized filename stem>` as the `界面名称/状态` and explain the ambiguity in the evidence/notes column.

## Output Table

Use this shape in `架构需求.md` §3:

```markdown
| 优先级 | 原稿文件 | 页面/状态 | 类型 | 对应实现 | 入口/触发 | 备注 |
|---|---|---|---|---|---|---|
```

When confidence matters, include it in `备注`:

```text
命名推断: 高/中/低；需确认: ...
```

Use this aligned shape in `像素还原清单.md`:

```markdown
| 优先级 | 原稿文件 | 界面名称/状态 | 对应实现 | 开发状态 | 交互绑定 | 像素验收 | 工程证据/问题 |
|---|---|---|---|---|---|---|---|
```

Alignment requirements:

- For each §3 row, create or update one matching pixel checklist row keyed by `原稿文件` plus `界面名称/状态`.
- The pixel checklist's `界面名称/状态` must not be blank, `【由命名推断】`, `待创建`, an implementation filename, or just a generic status such as `实现完成`.
- If several originals are merged into one screen, keep the canonical row and list merged originals in `工程证据/问题`.
- If one screen has multiple states, include the state in the name, such as `登录-错误态`, `消息-空态`, or `充值成功弹窗`.

## Priority Rules

| Priority | Filename/context clues | Meaning |
|---|---|---|
| P0 | `launch`, `启动`, `login`, `登录`, `sign in`, `register`, `注册`, `home`, `首页`, `main`, `tab`, core tab roots | Must exist for first runnable path |
| P0 | Main product roots such as `feed`, `community`, `社区`, `chat`, `消息`, `me`, `我的`, `profile` when they are tab roots | Main navigation coverage |
| P1 | Detail pages, publish/create, settings, recharge/paywall, chat room, video call, activity detail, list/detail pages | Important secondary flows |
| P1 | Popups blocking core flows: unlock, insufficient balance, permission rationale, report/block, delete confirm, success/failure | Interaction states that users must reach |
| P2 | Empty/loading/error states, onboarding variants, optional lists, rarely used settings subpages, alternate visual states | Quality and edge coverage |

If a filename contains both a P0 root and a state marker, keep the root page P0 and the state row P1/P2 depending on user impact.

## Type Inference

| Filename clues | Type |
|---|---|
| `启动`, `launch`, `splash` | 状态 / 启动页 |
| `tab`, `首页`, `home`, `feed`, `社区`, `chat`, `消息`, `me`, `我的` | Tab 页面 when part of main navigation |
| `登录`, `注册`, `sign in`, `login`, `register`, `forgot` | FullScreen / Push 页面 depending platform route |
| `详情`, `detail`, `profile`, `setting`, `设置`, `publish`, `发布`, `recharge`, `充值` | Push 页面 |
| `popup`, `modal`, `dialog`, `弹窗`, `提示`, `解锁`, `成功`, `失败`, `confirm` | Overlay / 弹窗 |
| `sheet`, `举报`, `拉黑`, `action` | Bottom Sheet |
| `empty`, `缺省`, `空态`, `暂无` | 状态 / 空态 |
| `loading`, `加载`, `skeleton` | 状态 / 加载 |
| `error`, `失败`, `network`, `错误` | 状态 / 错误 |
| `selected`, `normal`, `展开`, `收起`, `短屏` | 状态 / 变体 |
| filename is a small shared piece or pure icon and lives in cutout folder | 组件/资源, not a screen row unless the original folder marks it as a screen |

## Page/State Naming

- Prefer concise Chinese page names when originals are Chinese: `登录选择`, `邮箱登录`, `注册资料`, `首页`, `社区`, `消息`, `我的`, `设置`.
- Keep variant suffixes as state names: `AI 余额不足弹窗`, `发布成功`, `视频聊天-失败`, `列表空态`.
- For numbered variants (`视频聊天.png`, `视频聊天-2.png`), group them under one page if they share layout/state; write the variant in notes.
- If two files differ only by device size, mark one row with responsive/short-screen note rather than duplicate screens.

## Entry/Trigger Inference

| Page/state clues | Default entry/trigger |
|---|---|
| launch/splash | Cold start |
| login selection | Cold start / Logout |
| sign in | Login selection > Sign in |
| register/create account | Login selection > Create account |
| main/home tab | MainTab default |
| feed/community tab | MainTab > Feed/Community |
| chat/messages tab | MainTab > Chat/Messages |
| me/profile tab | MainTab > Me/Profile |
| settings | Me/Profile > Settings |
| recharge/paywall | Me balance / paywall popup / insufficient balance |
| publish/create | Feed/Community > Add/Post |
| detail/profile | Card/avatar/list item tap |
| comment | Card comment tap |
| report/block sheet | More/report button |
| unlock/insufficient/success popup | Primary action result |
| empty/loading/error | Corresponding list/network/data state |

If entry is ambiguous, write `待确认：命名可推断为 ...`.

## Implementation Target Inference

Use existing project conventions first. If no code exists yet, infer a target path without creating files until implementation begins:

| Stack | Suggested target |
|---|---|
| UIKit | `Features/<Module>/<Page>ViewController.swift` |
| SwiftUI | `Features/<Module>/<Page>View.swift` |
| React | `src/screens/<Page>Screen.tsx` or existing route folder |
| Vue | `src/views/<Page>.vue` |
| Flutter | `lib/screens/<page>_screen.dart` |
| React Native | `src/screens/<Page>Screen.tsx` |
| Unknown | `待定：按项目路由生成 <Page>` |

When an existing file already implements the screen, use the real path and mark confidence high.

## Similar-Case Mapping

Use kit cases as examples, not as hardcoded product truth:

| Case-like original name | Inferred row pattern |
|---|---|
| `登录选择登录方式.png` | P0 / 选择登录方式 / FullScreen / cold launch root |
| `登录sign in.png` | P0 / 邮箱登录 / Push or auth screen / Sign in |
| `注册1.png`, `注册2.png` | P0 / 注册步骤 / Push / Create account flow |
| `首页.png` | P0 / Home / Tab 页面 / MainTab default |
| `社区.png` | P0 / Feed or Community / Tab 页面 / MainTab tab |
| `消息.png` | P0 / Chat or Messages / Tab 页面 / MainTab tab |
| `我的.png` | P0 / Me / Tab 页面 / MainTab tab |
| `ai聊天 - 充值解锁.png` | P1 / AI 余额不足弹窗 / Overlay / AI send with insufficient balance |
| `社区 - 发帖解锁.png` | P1 / 发布扣费/余额不足 / Overlay / Publish Post |
| `举报拉黑.png` | P1 / 举报拉黑 Sheet / Bottom Sheet / More/report |
| `视频聊天.png`, `视频聊天-2.png` | P1 / 视频聊天 / Push 页面/状态 / chat video button |
| `缺省页.png` | P1/P2 / 通用空态 / 状态 / empty list |
| `设置.png` | P1 / 设置 / Push 页面 / Me settings |
| `充值.png` | P1 / 充值 / Push 页面 / Me balance/paywall |

## Stop Conditions

Mark `待确认` instead of inventing product facts when:

- The original filename is decorative or too generic (`01.png`, `页面.png`) and no folder context resolves it.
- The same filename could be a tab root or a detail page and no navigation context exists.
- The row implies real account/payment/media/legal/backend capability not authorized in §6.
- The design-original folder is missing or empty.
- Multiple original files conflict on the same page/state with different visual intent.
