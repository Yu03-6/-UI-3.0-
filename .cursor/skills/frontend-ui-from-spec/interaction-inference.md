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
| Persistence scope | How long does the mutated state live? | view-only (lost on leave), session-scoped (resets on logout/relogin), account-scoped persisted (survives relaunch), public/shared seed, irreversible flag |
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
| Profile/stat drilldown | `posts`, `followers`, `following`, statistic labels, profile counters | statistic tap route, filtered list content, row actions, empty state, cross-screen sync | Medium |
| Say hi/chat gate | `say_hi`, `hi`, `chat`, `follow`, relationship state | follow-first requirement, greeting sent confirmation, chat eligibility, duplicate prevention | Low/Medium |
| Search/history | `search`, `history`, `clear`, `chip`, local search engine | local filtering, history chip persistence, clear/delete history item, no-result empty state, keyboard submit | Low/Medium |
| Article/read | `read`, `article`, `story`, `soul`, `grid`, `detail` | list/detail route, generated/static content boundary, reading state if any, empty state | Low/Medium |
| Live room | `live`, `room`, `viewer`, `people`, `like`, `comment` | entry route, video source, comment stream, like animation, composer keyboard, report/block path | Medium/High |
| Match/resonance | `match`, `echo`, `resonance`, `music`, `pair` | seeded/random pair source, blocked-user exclusion, refresh conditions, music play/pause boundary | Low/Medium |
| Media picker | `photo`, `album`, `avatar`, `cover`, `upload`, `PHPicker` | selection limit, cancel, cache/runtime path, delete selected media, permission/system scope | Medium/High |
| Publish/create | `publish`, `post`, `draft`, `submit`, `success` | required fields, cost/gate if any, success popup, store insert, list/profile refresh | Medium/High |
| Floating create button | `publish`, `post`, `plus`, `add`, draggable button/helper | default position, drag bounds, tap vs drag threshold, lock/paywall route | Medium |
| Paywall/wallet | `coin`, `recharge`, `iap`, `pay`, `product`, StoreKit | product source, selected package, purchase success/failure, transaction de-dup, balance sync | High |
| Chat/AI | `chat`, `message`, `ai`, `send`, `reply` | message append, fee/free quota, insufficient balance path, local/real service boundary | High when billing/service |
| Quota/free-count gate | `quota`, `limit`, `free`, `次数`, `chats left`, unlock prompt | decrement rule, exhausted state, unlock/recharge route, reset scope | High when billing/service |
| Audio/video | `call`, `video`, `mic`, `speaker`, `camera`, `end` | permission request, on/off state, timeout/failure, preview vs RTC boundary, end route | High |
| Wallet package grid | `recharge`, `package`, `pkg`, `product`, `price`, `continue`, selected/normal package assets | package selection, disabled purchase state, price fallback/loading, success/failure/cancel, balance refresh | High |
| Media preview | `preview`, `play`, `pause`, `delete`, `photo_picker`, `video_preview` | picker cancel, preview display, play/pause, delete resets selection, required-field validation | Medium/High |
| Notification/request cleanup | `notification`, `request`, `clear`, `ignore`, `dismiss`, `accept` | remove local row or clear list, refresh badge/empty state, preserve source content unless destructive scope is explicit | Medium |
| Cross-screen store sync | `NotificationCenter`, `EventBus`, `store`, `observable`, `contentChanged`, `socialChanged`, `walletChanged`, `chatChanged` | mutation posts domain event; all reused cards/lists/counts refresh from source store | Medium |
| Data persistence/lifecycle | `store`, `session`, `reset`, `seed`, `login/logout`, `UserDefaults`, account scope, `threadId`/`peerId` keys | scope chosen (view/session/account/public/flag); reset vs seed on login; session content kept in store keyed by thread/peer; logout clears declared stores | Medium |
| Legal/settings/account | `settings`, `privacy`, `agreement`, `contact`, `logout`, `delete_account` | static/WebView URL, error state, confirmation, test-account exception, destructive scope | Medium/High |
| Optional registration profile | `skip`, `optional`, `profile`, `avatar`, `name`, `bio` | optional field defaults, skip/create route, local profile persistence, validation only for required fields | Medium/High if real account |
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
| `posts`, `followers`, `following`, `fans`, `friends_count` | Profile statistic entry | Push filtered list; keep row actions and counts synced with local store | Medium |
| `empty`, `placeholder`, `no_data` | Empty-state component | Show reusable empty view with optional primary action | Low |
| `input`, `field`, `send`, `search` | Form/search composer | Bind text field and local send/search/filter when present | Low/Medium |
| `search`, `history`, `chip`, `clear` | Search surface/history chips | Filter local data; persist or display recent queries when local storage exists; clear item/all; show empty state for no result | Low/Medium |
| `back`, `close`, `cancel`, `arrow_left` | Navigation control | Pop/dismiss/cancel current flow | Low |
| `more`, `ellipsis`, `report`, `block`, `blacklist` | More/actions sheet | Present bottom sheet; local block/report only unless backend is declared | Medium |
| `pay`, `iap`, `coin`, `recharge`, `subscribe`, `vip` | Purchase/paywall surface | UI only unless §6 declares real purchase | High |
| `package`, `pkg`, `product`, `price`, `continue`, `balance`, `wallet` | Wallet/package selection surface | Select one package locally; purchase only when §6 declares StoreKit/payment, with loading/disabled state and balance sync | High |
| `quota`, `limit`, `free`, `次数`, `unlock_chat`, `chats_left` | Usage quota/paywall surface | UI/local counter only unless §6 declares billing or quota reset rules | High |
| `login`, `apple`, `google`, `phone`, `email`, `register`, `logout` | Auth surface | UI/local flow only unless §6 declares real auth | High |
| `ai`, `chat`, `message`, `call`, `video_call`, `voice`, `mic`, `camera` | Chat/AI/media surface | UI/local demo only unless §6 declares real service or permission | High |
| `live`, `room`, `viewer`, `people`, `audience` | Live room/list surface | Use bundled/local media or placeholder only when allowed; comments/likes local unless backend/live service is declared | Medium/High |
| `read`, `article`, `story`, `soul`, `recommend` | Reading/list-detail surface | Generate local list/detail UI from provided/static content; real content API or AI generation requires §6 | Low/Medium |
| `match`, `resonance`, `echo`, `pair`, `music` | Match/resonance card | Seed or rotate local pair/card; exclude blocked users if social store exists; music play/pause only if local media exists | Low/Medium |
| `delete_account`, `deactivate`, `withdraw` | Account destructive action | Require §6 explicit behavior and confirmation; on delete, persist a durable deleted-account marker keyed by account identity and intercept it at every login before authenticating | High |
| `logout`, `log_out`, `sign_out` | Session action | Confirm or direct return to auth root according to spec; clear only declared session state | Medium/High |

## Name Dictionary

| Name fragments | Default inference | Risk |
|---|---|---|
| `back`, `nav_back`, `arrow_left`, `return` | Pop current page or dismiss current modal | Low |
| `close`, `x`, `cancel`, `dismiss` | Close sheet/dialog/current flow | Low |
| `tab`, `segment`, `selected`, `active`, `normal`, `indicator`, `sel` | Switch tab/segment/filter and update selected state | Low |
| `photo`, `video`, `notes`, `posts` with counts on a profile/content page | Segmented content switch; update selected style, list/grid, count labels, and empty state | Low/Medium |
| `expand`, `collapse`, `more_text`, `fold` | Expand/collapse local content | Low |
| `like`, `heart`, `favorite`, `collect`, `star` | Local toggle with selected/normal state; optional bounce/particle animation if project has animation helpers | Low |
| `comment`, `reply`, `send` | Open comments or append/send local text when a composer exists; otherwise `待确认` | Low/Medium |
| `search`, `history`, `chip`, `clear` | Local search/filter; save query chips when local storage exists; clear deletes history only, not content | Low/Medium |
| `notification`, `notice`, `badge`, `clear`, `ignore`, `dismiss` | Notification/request row cleanup; refresh badge and empty state; do not delete business content unless specified | Medium |
| `share` | Open local share sheet only if project/spec allows it; otherwise display disabled/no-op and mark `待确认` | Medium |
| `follow`, `following`, `fans`, `friend` | Local follow/unfollow or social relationship toggle; sync visible counts if local store exists | Medium |
| `say_hi`, `hi`, `wave`, `greet` | Local greeting or chat-intent action; if project requires relationship first, prompt follow/add friend before chat | Low/Medium |
| `add_friend`, `friend_request`, `accept`, `reject` | Local request/accept/reject demo state if social store exists | Medium |
| `report`, `block`, `blacklist`, `more`, `ellipsis` | Open bottom action sheet; report/block use local demo state unless real backend is declared | Medium |
| `delete`, `remove`, `trash` | Show confirmation; delete only current user's local content or local account data when §6 allows | Medium/High |
| `edit`, `profile`, `avatar`, `cover`, `camera`, `upload`, `album`, `photo`, `pick` | Navigate to edit/profile flow; real picker/permission requires §6 | Medium/High |
| `skip`, `optional`, `profile_setup`, `bio`, `nickname` | Optional profile setup; missing optional fields should use defaults/placeholders, not block account creation unless spec says required | Medium/High |
| `settings`, `privacy`, `agreement`, `guideline`, `contact`, `about` | Open declared settings/legal/static screen; external WebView links require declared URL/scope | Medium/High |
| `ok`, `confirm`, `done`, `submit`, `unlock`, `recharge` | Primary dialog/action button; bind to nearest popup or screen route | Low/High depending on target |
| `login`, `apple`, `google`, `phone`, `email`, `register`, `logout` | UI flow only unless real auth is declared | High |
| `pay`, `iap`, `storekit`, `coin`, `recharge`, `subscribe`, `vip`, `product` | UI only unless real payment/IAP is declared | High |
| `package`, `pkg`, `price`, `balance`, `continue`, `wallet` | Wallet package grid and selected state; real purchase, transaction finish, and balance entry only when declared | High |
| `quota`, `limit`, `free`, `次数`, `unlock_chat`, `chats_left` | UI/local quota unless real quota, billing, or reset policy is declared | High |
| `ai`, `chat`, `message`, `call`, `video_call`, `voice`, `mic`, `speaker`, `end_call` | UI/local demo only unless real chat/AI/media permissions are declared | High |
| `preview`, `play`, `pause`, `photo_picker`, `video_picker`, `media_delete` | Media picker preview and delete state; real picker/camera/file persistence only when declared | Medium/High |
| `live`, `room`, `viewer`, `people`, `audience`, `watch` | Live room/card UI; local bundled video/comment demo only unless real live service is declared | Medium/High |
| `read`, `article`, `story`, `soul`, `recommend` | Reading list/detail route; local/static content unless real CMS/API/AI generation is declared | Low/Medium |
| `match`, `resonance`, `echo`, `pair`, `music`, `play`, `pause` | Local match/resonance card and local media play/pause when bundled media exists | Low/Medium |
| `delete_account`, `deactivate`, `withdraw` | Require explicit spec; destructive behavior must be confirmation-gated; persist a durable deleted-account marker and intercept/block re-login of that account | High |

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
- `pkg_normal` + `pkg_selected`, `package_normal` + `package_selected`
- `mic_on` + `mic_off`, `speaker_on` + `speaker_off`, `play` + `pause`

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
- Say Hi/greeting: local greeting confirmation is acceptable; if chat is relationship-gated, require follow/add-friend first and document the gate.
- Report/block: present bottom sheet; block hides local content if a local store already supports filtering.
- Delete content: confirmation dialog, then remove from local demo content store.
- Notification/request cleanup: row-level ignore/dismiss removes only the notification/request row, updates badge and empty state, and must not remove the underlying user/content unless the spec says so.
- Empty new account: empty social/chat/content lists unless the spec declares seeded demo data.
- Test/demo account: richer seeded local data when the spec declares it.
- Search/filter: local filtering if the list data is local; otherwise `待确认`.
- Search history: recent-query chips may be local/session or persisted only when the project already uses local storage; clear buttons should affect search history, not source content.
- Article/read screens: static/generated local reading content is acceptable when the spec says content can be demo/local; real AI generation, CMS, or remote feed must be explicit.
- Live rooms: bundled/local video, fake viewer counts, local comments, and like animations are acceptable demo behavior; real streaming, presence, gifts, or moderation backend must be explicit.
- Match/resonance/echo cards: local random or seeded pairing is acceptable when backed by local demo users; exclude blocked users and document reseed triggers when moderation exists.
- AI/chat/video call: local demo state only; charges, free quota, timeout, permissions, and StoreKit require explicit spec.
- Wallet/package selection: selecting a package is a local UI state; purchase loading must disable duplicate taps; success/failure/cancel must keep balance and labels consistent with the declared payment scope.
- Media preview/delete: after picker success show a local preview and delete control; delete clears the runtime key/preview and restores the picker placeholder; picker cancel leaves state unchanged.
- Video call demo: start timer/loading state, allow mic/speaker UI toggles, stop preview/timers on hangup, and document timeout/failure return path. Real RTC/audio routing/camera permissions require §6.
- Optional profile setup: allow skip/default values only when the filename/spec indicates optional profile fields; do not infer optionality for required account credentials.
- Profile statistic drilldowns: tapping Posts/Followers/Following can push local filtered lists when the project has a local user/content/social store; counts and row actions must sync back to profile cards.
- Cross-screen store sync: when one mutation affects reused content, relationship, wallet, or chat state, update the source store first and refresh every listening screen/card/count from that source instead of patching only the tapped view.

## Data Persistence And Lifecycle Scope

Every piece of mutable state has a lifecycle scope. Deciding the scope is part of interaction completeness, not an afterthought. Do not assume "本地持久化/local persistence" means "survives relaunch" — by default infer the **narrowest scope that satisfies the visible behavior**, and only widen it when `架构需求.md` §6 declares real persistence.

| Scope | Where it lives | Lifetime | Default candidates |
|---|---|---|---|
| View-only ephemeral | The view/controller | Lost when leaving the screen | scroll offset, unsent draft text, transient highlight |
| Session-scoped in-memory | A shared store/singleton for the current login | Survives navigation within one login; resets on logout/re-login | chat/AI messages, comments, local likes, follow/friend graph, wallet balance changes, my-posts, request list |
| Account-scoped persisted | Disk keyed by account id | Survives app relaunch, isolated per account | only when §6 explicitly declares real local persistence per account |
| Public/shared seed | A read-only seed source visible to all accounts | Per build; not account-private | platform/public feed posts, default users, seeded AI welcome |
| Irreversible flag | Durable storage (e.g. UserDefaults) | Survives relaunch even when general data is session-scoped | account-deleted marker, IAP transaction-id de-dup, one-time onboarding seen |

Reusable rules:

- **Default "本地数据/local demo data" to session-scoped in-memory**, not relaunch-persistent. Each login resets account state unless §6 declares account-scoped persistence. A 1:1 chat / AI conversation that "saves during this login and resets after re-login" is the canonical session-scoped case.
- **`reset()` is not `seed()`.** Login must choose deliberately: `reset()` (empty), `seedForNewUser()` (default/welcome content such as an AI greeting), or `seedForTestAccount()` (rich demo data). A new account that should show default/welcome content must be *seeded* on login, not merely reset, or the welcome state silently disappears.
- **Content that must survive back-navigation within a login belongs in a shared session store, not a view controller's local array.** If returning to a screen (post detail, place discussion, chat) must restore the user's own messages/comments, key them by a stable `threadId`/`peerId` in the store. A VC-local array is correct only for view-only ephemeral state.
- **Unify same-shaped session conversations under one store.** Chat messages and comment threads are the same lifecycle; route both through one thread/peer-keyed session store so lifetime, reset, and recovery behave identically.
- **Separate public/shared from account-private.** Public/seed content is visible across accounts and filtered at read time (e.g. by blacklist); account-private state (my-posts, social graph, wallet, chats) is reset/seeded per login. Do not mix the two in one mutable list.
- **Irreversible flags may persist even when everything else is session-scoped.** A delete-account marker that blocks re-login, or a transaction-id set for purchase de-dup, may use durable storage; this does not make the rest of the data relaunch-persistent.
- **Account deletion must persist a deleted-account identifier and login must intercept it.** When §6 authorizes account deletion, the delete flow writes a durable marker keyed by the account identity (email / Apple user id / account id) to durable storage, then returns to the auth root. Every login path (email, Apple, etc.) must check this marker *before* authenticating and block/reject re-login of a deleted account with a clear message. This marker is irreversible-flag persistence: it survives relaunch even when general data is session-scoped, and is cleared only by a declared reset path (e.g. reinstall) — never silently on logout/login.
- Logout must clear every session-scoped store it declared; leaving one un-reset leaks the previous account's data into the next login.

When the spec's capability table claims "real persistence" but the code/behavior only keeps state for one login, treat the real model as session-scoped and record the discrepancy in §10 rather than inferring relaunch persistence.

## Local AI / Template Reply Detail

When §6 declares AI is UI-only/local-template (no model API), a believable local reply engine has reusable completeness dimensions. Record the dimensions, never project-specific phrase counts, themes, costs, or delays.

| Dimension | Required judgment |
|---|---|
| Trigger/gate | send on non-empty input; apply per-message cost or free-quota gate only when §6 declares it |
| Reply source | keyword/topic-matched prefab phrases by theme; fallback generic reply when no keyword matches |
| Anti-repeat | avoid repeating the last N replies so the demo does not loop obviously |
| Pacing | optional multi-bubble reply with a short delay to feel conversational |
| Balance/quota path | on insufficient balance/quota, route to recharge/unlock per §6, do not send |
| Persistence | conversation is session-scoped by default (resets on re-login) unless §6 says otherwise; seed a welcome message on login for new accounts |

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
