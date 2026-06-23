# Project Button Interaction Patterns

Use this reference after `interaction-inference.md` and before coding screens. It distills reusable button/action behavior from the Sweeli/TpCake and hdxc projects. Treat these as interaction templates, not product truth: `架构需求.md` §4/§6 and existing project code still override them.

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
| Apple login | `apple`, `sign_with_apple` | only real `ASAuthorizationController` when §6 says real; otherwise UI-only | High |
| Logout | `logout`, `log_out` | confirm dialog, clear session, return to auth root | Medium/High |
| Delete account | `delete_account` | confirm; block demo/test account if required; clear local account only when §6 says so | High |

## Cards, Social, And Moderation

| Pattern | Signals | Default Operation | Completeness Checks |
|---|---|---|---|
| Like/favorite | `like_off/on`, `liked`, `heart`, `favorite` | toggle local liked state, update count, animate if helper exists | count sync, reused card instances |
| Follow/following | `follow`, `following`, `fans` | toggle local relationship, update button asset and counts | profile/card/social list sync |
| Friend request | `friend_request`, `accept`, `reject` | accept/reject local request, remove row, update badge/count | empty state, friends list sync |
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

## Publish, Upload, Media

| Pattern | Signals | Default Operation | Risk |
|---|---|---|---|
| Pick avatar/photo/video | `album`, `photo`, `video_picker`, `avatar_edit`, `cover`, `camera` | use PHPicker/system picker only if §6 allows; otherwise UI placeholder and `待确认` | Medium/High |
| Remove selected media | `photo_delete`, `remove_photo` | remove selected local media preview | Low/Medium |
| Publish/post submit | `publish`, `post`, `submit` | validate required fields/media; if cost exists check balance; success dialog; insert local content | Medium/High |
| Insufficient balance popup | `coin`, `recharge`, `unlock`, `paywall` | self-drawn popup; confirm closes or routes to recharge | High if real billing |
| Publish success popup | `success`, `done`, `ok` | self-drawn success popup, close to feed/profile and refresh | Low/Medium |

## Wallet, IAP, Gifts

| Pattern | Signals | Default Operation | Risk |
|---|---|---|---|
| Recharge package | `recharge`, `coin`, `product`, `iap` | real StoreKit only when §6 says real; otherwise UI-only package selection | High |
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

## Settings, Legal, Static Content

| Pattern | Signals | Default Operation | Risk |
|---|---|---|---|
| Privacy/User Agreement | `privacy`, `agreement`, `terms` | push WebView only with declared URL; otherwise static/待确认 | Medium/High |
| Guidelines | `guideline`, `community` | push static text page | Low |
| Contact us | `contact`, `email` | push contact page or mail link if declared | Medium |
| Blacklist | `blacklist` | push local blacklist list with remove action | Medium |

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
- Account deletion, backend report/block, remote moderation, or API writes unless §6 declares scope.

## Output Shape

```markdown
| 模式 | 适用页面/资源 | 触发 | 前置条件 | 结果 | 状态同步/失败路径 | 风险 | 状态 |
|---|---|---|---|---|---|---|---|
| content_card.like | like_off/like_on | tap | 本地内容可见 | 切换点赞和计数 | 同步复用卡片；无失败路径 | 低 | 已绑定 |
```
