# Project Button Interaction Patterns

Use this reference after `interaction-inference.md` and before coding screens. It distills reusable button/action behavior from the Sweeli/TpCake, hdxc, qxxq, lygl, clsj, and qsxq projects. Treat these as interaction templates, not product truth: `架构需求.md` §4/§6 and existing project code still override them.

## How To Apply

1. Match by resource name, screen name, nearby code route, and visual context.
2. Choose the closest pattern below and record it in `架构需求.md` §4.2 or the delivery report.
3. Implement low-risk/local behavior directly only when the required store/state exists or is easy to create locally.
4. Mark system, account, payment, media, legal, backend, and destructive behavior as `待确认` unless §6 explicitly authorizes it.
5. Put repeated instances in `资源导入清单.md` and `像素还原清单.md`, not as duplicate §4.2 rows.

## Navigation And Presentation

| Pattern | Signals | Default Operation | Evidence To Record |
|---|---|---|---|
| Back button | `back`, `nav_back`, `arrow_left` | `popViewController`; if modal/sheet, `dismiss` | entry, owning controller, return destination |
| Main tab | `tab_*_on/off`, `selected`, `normal` | switch root tab, update selected image and badge | selected index, hidden/shown tab bar rule |
| Card tap | `card`, `cover`, `thumbnail`, `detail` | push detail/profile/live room | source screen, target route, selected model id |
| More button | `more`, `ellipsis`, `report`, `block` | present bottom report/block sheet | owner rule, blocked-list refresh, report route |
| Static settings row | `settings`, `privacy`, `agreement`, `guideline`, `contact`, `blacklist` | push static page, WebView, contact page, or blacklist | URL/static copy, failure state, back behavior |

## Auth And Account

| Pattern | Signals | Default Operation | Risk |
|---|---|---|---|
| Sign in / Create account | `sign_in`, `create_account`, `login`, `register` | push sign-in or registration step | High if real auth |
| Password eye | `eye_on/off`, `visible`, `password` | toggle `isSecureTextEntry` and image state | Low |
| Email/password submit | `next`, `submit`, `sign_in`, `create` | validate email/password; show dialog on invalid; route on success | High if real account |
| Optional profile step | `skip`, `optional`, `avatar`, `nickname`, `bio`, profile setup screen | allow account creation with defaults only when spec/original says optional; optional media can be placeholder | Medium/High if real account |
| Apple login | `apple`, `sign_with_apple` | only real `ASAuthorizationController` when §6 says real; otherwise UI-only | High |
| Logout | `logout`, `log_out` | confirm dialog, clear session, return to auth root | Medium/High |
| Delete account | `delete_account` | confirm; clear local account only when §6 says so; persist a durable deleted-account marker keyed by account identity and return to auth root | High |
| Deleted-account login intercept | `login`, `apple`, `email` + deleted marker | before authenticating, check the persisted deleted-account marker and block/reject re-login of that account with a clear message; cleared only by a declared reset path (e.g. reinstall) | High |

## Cards, Social, And Moderation

| Pattern | Signals | Default Operation | Completeness Checks |
|---|---|---|---|
| Like/favorite | `like_off/on`, `liked`, `heart`, `favorite` | toggle local liked state, update count, animate if helper exists | count sync, reused card instances |
| Follow/following | `follow`, `following`, `fans` | toggle local relationship, update button asset and counts | profile/card/social list sync |
| Profile stat drilldown | `posts`, `followers`, `following`, stats on profile/me | push filtered list for selected statistic | list source, empty state, row actions, count sync |
| Say Hi/greeting | `say_hi`, `hi`, `wave`, greeting button | send local greeting or prompt follow/add-friend first when relationship-gated | duplicate prevention, chat eligibility |
| Friend request | `friend_request`, `accept`, `reject` | accept/reject local request, remove row, update badge/count | empty state, friends list sync |
| Notification dismiss | `notification`, `notice`, `ignore`, `dismiss`, `clear` | dismiss local notification/request row; update badge and empty state | clear scope, source content preserved |
| Start chat | `chat`, `start_chat`, `message` | push 1:1 chat if local conversation exists or can be seeded | conversation creation, duplicate prevention |
| Report/block sheet | `report`, `block`, `blacklist`, `more` | present bottom sheet; block filters local content; report pushes/opens reason page or success dialog | current screen refresh, blocked target name |
| Remove blacklist | `remove`, `unblock`, `blacklist_remove` | remove user from local blacklist and refresh list | empty state |
| Delete own content | `delete`, `trash`, `remove` on own card | confirm, delete local note/video/chat, update list/profile/empty state | ownership rule, undo/no-undo decision |

## Composer, Chat, Comment

| Pattern | Signals | Default Operation | Completeness Checks |
|---|---|---|---|
| Send text | `send`, `input`, `reply`, `comment` | ignore empty text; append local message/comment; clear field; scroll to latest | keyboard avoidance, list bottom inset |
| Comment sheet | `comment`, `sheet`, `reply` | present bottom sheet with list + input; update count on send | dismiss, count sync |
| Clear all chats | `clear_all`, `delete_all` | confirm dialog; delete local conversations; reset badge and empty state | destructive scope |
| Swipe delete chat | table swipe delete | delete conversation row from local store | badge/list sync |
| AI chat send | `ai`, `send`, `message` | append user message and local/template reply; apply free quota/coin gate only if §6 says so | fee/free quota, insufficient balance path |
| AI local reply engine | `ai`, `reply`, keyword/topic phrase banks | keyword/topic-matched prefab replies with generic fallback; optional multi-bubble reply with short delay; avoid repeating last N replies; conversation session-scoped with seeded welcome | reply source, anti-repeat, pacing, per-message cost/quota gate, session reset boundary |
| AI role card | `ai`, `role`, `portrait`, `hot`, `chat_btn` | push AI chat for selected role; use local/template persona only if no model API is declared | role id, local reply boundary, balance/free quota if present |
| AI quota exhausted | `quota`, `limit`, `free`, `次数`, `chats left`, unlock chat | present quota/usage exhausted popup; unlock/recharge only when §6 declares cost/reset policy | reset scope, billing boundary |

## Publish, Upload, Media

| Pattern | Signals | Default Operation | Risk |
|---|---|---|---|
| Pick avatar/photo/video | `album`, `photo`, `video_picker`, `avatar_edit`, `cover`, `camera` | use PHPicker/system picker only if §6 allows; otherwise UI placeholder and `待确认` | Medium/High |
| Media preview play/pause | `preview`, `play`, `pause`, `video_preview` | show selected media preview; video preview toggles play/pause and stops when leaving screen | Medium/High |
| Remove selected media | `photo_delete`, `remove_photo` | remove selected local media preview | Low/Medium |
| Publish/post submit | `publish`, `post`, `submit` | validate required fields/media; if cost exists check balance; success dialog; insert local content | Medium/High |
| Draggable publish/add | floating `publish`, `plus`, `add`, `post` button | distinguish tap vs drag; constrain to safe bounds; tap follows normal publish/paywall route | Medium |
| Insufficient balance popup | `coin`, `recharge`, `unlock`, `paywall` | self-drawn popup; confirm closes or routes to recharge | High if real billing |
| Unlock gated action | `unlock`, `locked`, `coin`, `paywall` | self-drawn unlock dialog; if balance/local entitlement exists, deduct or mark unlocked locally; otherwise route to recharge/待确认 | High if billing/entitlement |
| Publish success popup | `success`, `done`, `ok` | self-drawn success popup, close to feed/profile and refresh | Low/Medium |

## Wallet, IAP, Gifts

| Pattern | Signals | Default Operation | Risk |
|---|---|---|---|
| Recharge package | `recharge`, `coin`, `product`, `iap` | real StoreKit only when §6 says real; otherwise UI-only package selection | High |
| Recharge package selection | `package`, `pkg`, `selected`, `normal`, `price`, `continue` | select one package, swap selected asset, disable Continue while purchasing, use fallback price while product loads | High |
| Purchase success | StoreKit transaction | finish transaction, de-dupe transaction id, add local coins, refresh Me/recharge labels | High |
| Purchase failure/cancel | StoreKit result/error | keep balance unchanged, show error/cancel state if needed | High |
| Gift quantity | `gift`, `plus`, `minus`, `send` | select gift, step quantity >= 1, check balance, show animation or insufficient popup | Medium/High |

## Audio/Video Call

| Pattern | Signals | Default Operation | Risk |
|---|---|---|---|
| Video call entry | `video_chat`, `call`, `video` | push/present call UI | High if real media |
| Local preview | `camera`, `flip` | use `AVCaptureSession` only if §6 says media real/allowed | High |
| Mic/speaker toggle | `mic_on/off`, `speaker_on/off` | toggle local button state; real audio route/mute requires §6 | High |
| End call | `end_call`, `hangup` | stop timers/session and return to chat | Medium/High |
| Timeout | call not connected | after specified seconds return and show dialog | Medium/High |

## Cross-Screen Sync

| Pattern | Signals | Default Operation | Completeness Checks |
|---|---|---|---|
| Domain store mutation | `contentChanged`, `socialChanged`, `walletChanged`, `chatChanged`, `profileChanged`, observable/store events | mutate the source store, then notify/listen so repeated cards, counters, badges, and empty states refresh from one source | affected screens listed, no one-off label patching |
| Block filters content | `block`, `blacklist`, content/user/chat lists | add target to local blacklist; remove from following/friends if local store models that; hide blocked author from feeds, comments, chats, notifications, and recommendations | unblock path, empty states, current detail dismissal |
| Account data tier | test/demo account vs new account flags | seeded demo data only when declared; new account starts with platform/public content and empty private/social/chat lists | §6 declares persistence and reset rules |
| Session-scoped store lifecycle | in-memory store/singleton, `reset()`, login/logout hooks | account-private state lives only for the current login; survives in-login navigation; resets on logout/re-login; logout clears every declared store | default to session-scoped unless §6 declares relaunch persistence; no leaked state across accounts |
| Reset vs seed on login | `reset()`, `seedForNewUser()`, `seedForTestAccount()` | new account that needs default/welcome content (e.g. AI greeting) must be seeded on login, not merely reset; test account re-seeds rich demo | which method each login path calls; welcome/default content actually appears |
| Thread-keyed session content | `threadId`, `peerId`, conversation/comment store | chat messages and comment threads kept in a store keyed by thread/peer so leaving and returning restores them; VC-local arrays only for view-only ephemeral state | recovery after back-navigation; one store shape for chat + comments |
| Public vs account-private split | public/seed feed vs my-posts/social/wallet/chat | public/shared content visible across accounts and filtered at read time; account-private reset/seeded per login | no mixing; blacklist filtering applied on read |
| Irreversible flag persistence | `UserDefaults`, deleted-account marker, transaction-id de-dup | a single durable flag may survive relaunch even when general data is session-scoped | does not imply general data persistence; scope of the flag is explicit |
| Deleted-account marker + login gate | `delete_account` write + login check, keyed by email/Apple id/account id | persist deleted marker on deletion; every login path checks it before auth and blocks re-login; cleared only by declared reset path | survives relaunch; not cleared on logout/login; clear message on blocked login |

## Search, Reading, Match, Live

| Pattern | Signals | Default Operation | Completeness Checks |
|---|---|---|---|
| Local search | `search`, `find`, text field, search route | filter local users/content/live/AI lists; return opens result target | keyboard avoidance, empty query, no-result empty state |
| Search history chip | `history`, `chip`, `clear`, `delete` | save recent queries locally when storage exists; tap chip reruns query; clear removes history entry/all | persistence scope, clear does not delete source content |
| Article/read list | `read`, `article`, `story`, `soul`, grid/list cards | push reading list; card pushes reading detail | static/local content source, detail route, empty state |
| Generated/static article detail | article detail filename or generated-content note | render local/static body content; do not call AI/CMS unless §6 declares it | content boundary, loading/error if remote |
| Daily match/resonance card | `resonance`, `match`, `echo`, `pair`, `music` | show local/seeded pairing or recommendation card; tap opens match feed/detail; optional local music play/pause | random/seed source, blocked-user exclusion, refresh trigger |
| Live room card | `live`, `room`, `join`, `watch`, `people` | open full-screen/push live room using bundled/local media if available | media source, fake viewer count, back/end route |
| Live room interaction | `live_like`, `comment`, `send`, `more` | local like/heart animation, append local comment, present report/block sheet | keyboard avoidance, comment scroll, moderation refresh |

## Settings, Legal, Static Content

| Pattern | Signals | Default Operation | Risk |
|---|---|---|---|
| Privacy/User Agreement | `privacy`, `agreement`, `terms` | push WebView only with declared URL; otherwise static/待确认 | Medium/High |
| Guidelines | `guideline`, `community` | push static text page | Low |
| Contact us | `contact`, `email` | push contact page or mail link if declared | Medium |
| Blacklist | `blacklist` | push local blacklist list with remove action | Medium |
| Logout/sign out | `logout`, `log_out`, `sign_out` | clear declared session state and return to auth root; confirmation depends on spec | Medium/High |

## Event / Live Local Patterns

| Pattern | Signals | Default Operation | Completeness Checks |
|---|---|---|---|
| Live room/card | `live`, `room`, `play`, `eye`, `people` | push live/detail screen or present event sheet | route, fake viewer count |
| Join/check-in | `join`, `check_in`, `rsvp` | mutate local event state and update home/passport/crew | cross-screen sync |
| Event crew quick reply | `crew`, `quick_reply`, `chip` | append templated local message | keyboard/list behavior |
| Live Now filter | `live_now`, `for_you`, `following` | switch feed mode and reload collection | selected indicator, empty state |

## Must Not Infer As Real

- Real Apple login, email account storage, or logout persistence unless §6 says real.
- StoreKit/IAP, coin purchase, transaction finish, or balance entry unless §6 says real.
- PHPicker/camera/microphone/AVCapture/WebView external links unless §6 declares the system capability and failure/cancel path.
- AI billing/free quota/model API unless §6 declares whether it is UI-only, local template, or real.
- AI/chat quota reset, paid unlock, or usage persistence unless §6 declares the rule.
- Relaunch-surviving or cross-account data persistence (treat local state as session-scoped/reset-on-login) unless §6 declares real account-scoped persistence.
- Account deletion, backend report/block, remote moderation, or API writes unless §6 declares scope.

## Output Shape

```markdown
| 模式 | 适用页面/资源 | 触发 | 前置条件 | 结果 | 状态同步/失败路径 | 风险 | 状态 |
|---|---|---|---|---|---|---|---|
| content_card.like | like_off/like_on | tap | 本地内容可见 | 切换点赞和计数 | 同步复用卡片；无失败路径 | 低 | 已绑定 |
```
