# Asset Name Component And Interaction Inference

Use this reference before implementing any screen from `架构需求.md`.

The goal is not only to guess button taps. Cursor must use cutout/runtime asset names to scaffold likely components, popups, stateful controls, list rows, and local-demo interactions. `架构需求.md` still defines scope, real capability boundaries, main routes, and explicit overrides, but it does not need to enumerate every button.

## Principle

Asset naming is first-class implementation evidence for UI and local-demo behavior.

Priority order:

1. `架构需求.md` §6 capability boundaries and explicit §4 overrides.
2. Existing code routes, stores, view models, components, and project conventions.
3. Cutout/runtime asset name clusters, visual states, and page folders.
4. Conservative fallback: `待确认` or `不可推断`.

Never use naming alone to enable real login, payment, AI, chat costs, system permissions, backend writes, legal/compliance behavior, or destructive account operations.

## Required Scan

Before coding each screen:

1. List allowed cutout/runtime assets for the page and shared/global folder.
2. Normalize names to lowercase fragments, preserving page prefixes and state suffixes.
3. Group related files by shared stem: `*_normal/selected`, `*_on/off`, `*_sel`, `*_btn`, `accept/reject`, `popup_*`, `card_*`.
4. Classify each group as screen background, repeated component, popup/sheet, stateful control, navigation entry, content media, form field, or decoration.
5. Produce a component/popup/interaction blueprint and write it into `资源导入清单.md`; durable assumptions go into `架构需求.md` §4.2/§10.
6. Implement low-risk and safe local-demo behavior. Mark high-risk or ambiguous behavior as `待确认`.

## Change-Log Reconciliation

Before adding more UI code, read `架构需求.md` §10 and reconcile any recorded changes:

- Asset replacements must be reflected in `资源导入清单.md`, component/popup blueprints, and pixel evidence.
- Bug fixes must update the affected screen evidence, validation notes, and interaction status if behavior changed.
- Real capability changes such as Apple login, IAP, WebView, PHPicker, camera, account deletion, or local persistence must update §6 and `AGENTS.md`.
- If §10 mentions completed interaction or asset work but §4.2/§4.3 still has template rows, backfill those tables from the resource list and code evidence.
- Do not create a new §10 row for every repeated instance of the same pattern; record one pattern and put repeated-instance evidence in the checklists.

## Similar-Case De-Duplication

Do not restate the same interaction for every page or every asset instance.

- Group identical interactions by component/action pattern, such as `content_card.like`, `content_card.more`, `tab_item.select`, `popup.confirm_close`, or `settings_row.open_static_page`.
- Register the shared rule once in `架构需求.md` §4.2/§4.3 and write applicable pages/resources in the page, resource cluster, or notes field.
- Keep per-instance evidence in `资源导入清单.md` and `像素还原清单.md`, especially resource names, triggers, binding status, and exceptions.
- Split a similar-looking case into a separate row only when ownership rules, capability boundary, risk level, state sync, or user-visible result differs.

## Interaction Completeness Matrix

Do not stop at "button has a tap handler." For every inferred interaction pattern, judge whether the operation is complete for the actual project.

| Dimension | Required judgment | Examples from real projects |
|---|---|---|
| Trigger | What user action starts it? | tap, long press, swipe, text submit, keyboard return, system callback |
| Preconditions | What must be true first? | logged in, owns content, follows user, balance enough, selected photos <= limit, valid form |
| Primary result | What should the user see? | push page, present sheet, append message, show success popup, update selected state |
| State mutation | What data changes? | like count, follow graph, blocked list, wallet balance, draft/post store, badge count |
| Cross-screen sync | Which screens refresh? | Home/Edit/Profile cards, request badge, wallet labels, blacklist, empty states |
| Failure/cancel path | What happens on cancel or failure? | validation toast, dismiss picker, StoreKit failure, WebView error, permission denied |
| Capability boundary | Is the result local, system, or backend? | UI-only, local store, Apple auth, StoreKit, PHPicker, camera, WebView, API |
| Evidence | Where is it documented? | §4.2/§4.3 pattern, §6 if real, resource row, pixel evidence, §10 if changed |

Mark an interaction `已绑定` only when trigger, result, and local/UI state are wired. Use `已绑定但受限` when UI is wired but a real capability is partial or explicitly scoped, such as camera preview without RTC or local AI reply without model API. Use `待确认` when preconditions, real capability, or failure behavior are not specified.

## Project Interaction Patterns

Use this taxonomy before implementation and when auditing an existing project:

| Pattern | Naming/code signals | Completeness checks | Risk |
|---|---|---|---|
| Navigation | `back`, `tab_*`, `arrow`, `more`, route names, `push/present/pop` | entry known, back/dismiss works, tab visibility/root-vs-push behavior documented | Low |
| Form/auth | `login`, `register`, `email`, `password`, `visible`, validation code | validation, disabled/error state, success route, logout/cold-start behavior, account scope | High if real auth |
| Composer/search | `input`, `send`, `search`, text field delegate | keyboard behavior, empty text handling, append/filter result, scroll-to-bottom or no-results empty state | Low/Medium |
| Content card | `card`, `like`, `comment`, `more`, `follow`, `delete` | ownership rules, count/state toggle, detail route, delete confirm, report/block sheet | Low/Medium |
| Social graph | `follow`, `following`, `friend`, `accept`, `reject`, `request`, badge | local store, row removal, badge count, cross-screen card/profile sync | Medium |
| Moderation | `report`, `block`, `blacklist`, `remove`, `unblock` | sheet actions, local filtering/removal, unblock path, backend boundary | Medium/High |
| Media picker | `photo`, `album`, `avatar`, `cover`, `upload`, `PHPicker` | selection limit, cancel, cache/runtime path, delete selected media, permission/system scope | Medium/High |
| Publish/create | `publish`, `post`, `draft`, `submit`, `success` | required fields, cost/gate if any, success popup, store insert, list/profile refresh | Medium/High |
| Paywall/wallet | `coin`, `recharge`, `iap`, `pay`, `product`, StoreKit | product source, selected package, purchase success/failure, transaction de-dup, balance sync | High |
| Chat/AI | `chat`, `message`, `ai`, `send`, `reply` | message append, fee/free quota, insufficient balance path, local/real service boundary | High when billing/service |
| Audio/video | `call`, `video`, `mic`, `speaker`, `camera`, `end` | permission request, on/off state, timeout/failure, preview vs RTC boundary, end route | High |
| Legal/settings/account | `settings`, `privacy`, `agreement`, `contact`, `logout`, `delete_account` | static/WebView URL, error state, confirmation, test-account exception, destructive scope | Medium/High |
| Empty/loading/error | `empty`, `loading`, `error`, `badge`, `99+` | data condition, retry/primary action, badge hide/show, stale state cleanup | Low/Medium |

## Naming Grammar

Prefer these forms when assets are created or renamed:

```text
page_area_control_state
page_component_action
module_resourcepurpose_index
global_control_state
```

Examples:

```text
feed_card_like_selected
feed_card_more_btn
profile_following
popup_recharge_card
video_mic_off
friend_request_accept
tab_home_sel
```

## Component Blueprint Rules

| Naming pattern | Inferred product | Default behavior | Risk |
|---|---|---|---|
| `popup`, `modal`, `dialog`, `alert`, `sheet` | Reusable popup/sheet shell | Self-drawn overlay/sheet; buttons inferred from nearby `ok/confirm/cancel/recharge/unlock/follow` names | Low/Medium |
| `card`, `cell`, `row`, `item` | Repeated card/list-row component | Build reusable component; child assets become slots/actions | Low |
| `tab`, `segment`, `filter`, `selected`, `normal`, `sel` | Tab/segmented control | Switch selected state and content list | Low |
| `on/off`, `open/close`, `active/inactive`, `follow/following`, `like/liked` | Single stateful control | Toggle state; use paired asset or code-drawn selected state | Low/Medium |
| `accept/reject`, `agree/refuse`, `yes/no` | Two-action row or dialog | Run local accept/reject path; remove row or dismiss when local/demo | Medium |
| `empty`, `placeholder`, `no_data` | Empty-state component | Show reusable empty view with optional primary action | Low |
| `input`, `field`, `send`, `search` | Form/search composer | Bind text field and local send/search/filter when present | Low/Medium |
| `back`, `close`, `cancel`, `arrow_left` | Navigation control | Pop/dismiss/cancel current flow | Low |
| `more`, `ellipsis`, `report`, `block`, `blacklist` | More/actions sheet | Present bottom sheet; local block/report only unless backend is declared | Medium |
| `pay`, `iap`, `coin`, `recharge`, `subscribe`, `vip` | Purchase/paywall surface | UI only unless §6 declares real purchase | High |
| `login`, `apple`, `google`, `phone`, `email`, `register`, `logout` | Auth surface | UI/local flow only unless §6 declares real auth | High |
| `ai`, `chat`, `message`, `call`, `video_call`, `voice`, `mic`, `camera` | Chat/AI/media surface | UI/local demo only unless §6 declares real service or permission | High |
| `delete_account`, `deactivate`, `withdraw` | Account destructive action | Require §6 explicit behavior and confirmation | High |

## Name Dictionary

| Name fragments | Default inference | Risk |
|---|---|---|
| `back`, `nav_back`, `arrow_left`, `return` | Pop current page or dismiss current modal | Low |
| `close`, `x`, `cancel`, `dismiss` | Close sheet/dialog/current flow | Low |
| `tab`, `segment`, `selected`, `active`, `normal`, `indicator`, `sel` | Switch tab/segment/filter and update selected state | Low |
| `expand`, `collapse`, `more_text`, `fold` | Expand/collapse local content | Low |
| `like`, `heart`, `favorite`, `collect`, `star` | Local toggle with selected/normal state; optional bounce/particle animation if project has animation helpers | Low |
| `comment`, `reply`, `send` | Open comments or append/send local text when a composer exists; otherwise `待确认` | Low/Medium |
| `share` | Open local share sheet only if project/spec allows it; otherwise display disabled/no-op and mark `待确认` | Medium |
| `follow`, `following`, `fans`, `friend` | Local follow/unfollow or social relationship toggle; sync visible counts if local store exists | Medium |
| `add_friend`, `friend_request`, `accept`, `reject` | Local request/accept/reject demo state if social store exists | Medium |
| `report`, `block`, `blacklist`, `more`, `ellipsis` | Open bottom action sheet; report/block use local demo state unless real backend is declared | Medium |
| `delete`, `remove`, `trash` | Show confirmation; delete only current user's local content or local account data when §6 allows | Medium/High |
| `edit`, `profile`, `avatar`, `cover`, `camera`, `upload`, `album`, `photo`, `pick` | Navigate to edit/profile flow; real picker/permission requires §6 | Medium/High |
| `settings`, `privacy`, `agreement`, `guideline`, `contact`, `about` | Open declared settings/legal/static screen; external WebView links require declared URL/scope | Medium/High |
| `ok`, `confirm`, `done`, `submit`, `unlock`, `recharge` | Primary dialog/action button; bind to nearest popup or screen route | Low/High depending on target |
| `login`, `apple`, `google`, `phone`, `email`, `register`, `logout` | UI flow only unless real auth is declared | High |
| `pay`, `iap`, `storekit`, `coin`, `recharge`, `subscribe`, `vip`, `product` | UI only unless real payment/IAP is declared | High |
| `ai`, `chat`, `message`, `call`, `video_call`, `voice`, `mic`, `speaker`, `end_call` | UI/local demo only unless real chat/AI/media permissions are declared | High |
| `delete_account`, `deactivate`, `withdraw` | Require explicit spec; destructive behavior must be confirmation-gated | High |

## State Pairing

When names imply states, bind them as a single control instead of separate unrelated images:

- `*_normal` + `*_selected`
- `*_off` + `*_on`
- `*_default` + `*_active`
- `*_sel` + unsuffixed or `*_normal`
- `follow` + `following`
- `like` + `liked`
- `accept` + `reject` in the same row
- `tab_x_normal` + `tab_x_selected`

If only one state exists, implement the missing state only with non-graphic UI primitives that fit the project style, such as tint, alpha, text, border, shadow, or background color changes. Do not create substitute icons, illustrations, textures, stickers, avatars, backgrounds, or decorative patterns. Otherwise record `缺 selected/normal 切图`.

## Popup And Sheet Defaults

- If a `popup_card`, `modal_bg`, or `sheet_*` asset exists, build a reusable self-drawn popup/sheet shell.
- Primary actions use nearby names such as `ok`, `confirm`, `unlock`, `recharge`, `follow`, `submit`.
- Secondary actions use `cancel`, `close`, `later`, `reject`.
- Business popups should use project-drawn UI. System dialogs are allowed only for platform flows such as Apple auth, StoreKit, permission prompts, picker controllers, or when §5 explicitly allows them.
- A popup with no inferable action should still render as a component, with buttons marked `待确认`.

## Ownership Rules

For content cards:

- Current user's note/video/content may show `delete/remove/trash` controls.
- Other users' content should show `more/report/block` controls, not delete, unless the spec says otherwise.
- Home/explore/profile cards should keep ownership-specific controls consistent when they reuse the same content model.

## Common Local Behaviors

Prefer these local behaviors when real services are not declared:

- Like/favorite: toggle local state and count for the current session.
- Follow/following: toggle local relationship and visible button/counts when a local social store exists.
- Report/block: present bottom sheet; block hides local content if a local store already supports filtering.
- Delete content: confirmation dialog, then remove from local demo content store.
- Empty new account: empty social/chat/content lists unless the spec declares seeded demo data.
- Test/demo account: richer seeded local data when the spec declares it.
- Search/filter: local filtering if the list data is local; otherwise `待确认`.
- AI/chat/video call: local demo state only; charges, free quota, timeout, permissions, and StoreKit require explicit spec.

## Completeness Output

For every durable interaction pattern, record this compact shape in §4.2 or the delivery report:

```markdown
| 模式 | 适用页面/资源 | 触发 | 前置条件 | 结果 | 状态同步/失败路径 | 风险 | 状态 |
|---|---|---|---|---|---|---|---|
```

If a project already has code, derive missing rows from route handlers, stores, notifications, delegates, and system framework usage, not only from asset names.

## Keyboard And Bottom Composer Requirements

Any screen with a bottom input bar, message composer, comment composer, search field, form field, or send button must explicitly handle system keyboard behavior.

- Bottom composers must move above the keyboard or use the platform keyboard layout guide; they must not be covered by the keyboard.
- The composer must have a stable height and bottom constraint. Do not let it stretch with the scroll view or become height-ambiguous.
- The message/comment list must end above the composer, not behind it, and should scroll to the latest local message/comment after send when that is the expected behavior.
- Keyboard show/hide animation should follow the system keyboard frame/duration/curve when custom avoidance is used.
- Empty send should be ignored or show a validation state; this must be documented.
- Interactive keyboard dismiss, safe-area bottom behavior, and short-screen behavior must be recorded in pixel evidence when the screen has an input bar.
- If the project has a helper such as `KeyboardAvoidance`, `KeyboardBottomBarAvoidance`, `pinBottomComposer`, `keyboardLayoutGuide`, or equivalent, reuse it for all composer screens.

## Required Output

For each implemented screen, update:

1. `资源导入清单.md`
   - Resource role
   - Inferred product/component/popup/state
   - Inferred interaction
   - Confidence
   - Binding status

2. `像素还原清单.md`
   - Interaction binding column
   - Engineering evidence `components: ...` and `interactions: ...`
   - Completeness evidence for preconditions, state sync, failure/cancel path when relevant

3. `架构需求.md`
   - §4.2 inferred interaction table for durable assumptions
   - §4.3 component/popup blueprint when the template includes it
   - Interaction completeness rows when a pattern has preconditions, cross-screen sync, failure paths, or real capability boundaries
   - §10 change log when behavior changes or fills a previous gap

Use this table shape when reporting:

```markdown
| 页面/组件 | 资源簇/切图名 | 推断产物 | 推断触发 | 推断结果 | 风险 | 实现策略 | 状态 |
|---|---|---|---|---|---|---|---|
```

## Stop Conditions

Ask or mark `待确认` when:

- The same asset name could mean multiple routes and no nearby context resolves it.
- A resource implies real capability not authorized in §6.
- A destructive action affects anything beyond local demo state.
- The UI requires legal, payment, permission, or account behavior not specified.
- Naming suggests a popup/action but no title, content, or nearby screen context identifies the user-facing result.
