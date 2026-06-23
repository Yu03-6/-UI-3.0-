# 界面覆盖与像素还原清单【案例：hdxc】

> 本案例按 `像素还原清单-模版.md` 口径整理自 hdxc 实际工程。默认不要求截图；`像素验收通过` 以工程证据为准。

## 状态定义

### 实现完成

1. 页面/弹窗/状态已创建，且可从约定入口打开。
2. 布局使用 `DesignMetrics`（780×1688）换算。
3. 图像资源来自允许切图、内容素材或现有 Assets；代码绘制仅用于基础 UI 原语。
4. 关键约束、短屏、安全区、滚动初始状态已处理。
5. 本屏交互已在资源清单或 §4.2 登记。

### 像素验收通过

1. 工程证据写明入口/路由、实现文件、布局方法或约束位置。
2. 记录关键元素度量依据。
3. 资源已登记到 `资源导入清单.md`。
4. 页面图像严格使用 §2 可用切图/内容素材/现有 Assets。
5. 关键按钮交互已绑定或写明限制/待确认。
6. 有键盘输入的页面已记录避让证据。
7. 例外项写明；无例外写 `无例外`。

## 屏幕覆盖

| 优先级 | 原稿文件 | 界面名称/状态 | 对应实现 | 开发状态 | 交互绑定 | 像素验收 | 工程证据/问题 |
|---|---|---|---|---|---|---|---|
| P0 | 启动.png | 启动/Launch | `LaunchScreen.storyboard` | 实现完成 | 无需绑定 | 像素验收通过 | route: 冷启动 / assets: `launch_bg` / layout: 全屏 aspectFill / metrics: 780×1688 / 无例外 |
| P0 | 登录选择页.png | 选择登录方式 | `AuthChoiceViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: 冷启动根页 / assets: `login_choice_bg`, `btn_apple`, `btn_create_account`, `btn_sign_in` / interactions: Apple 登录、注册、登录 / 无例外 |
| P0 | 登录.png | 邮箱密码登录 | `SignInViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: AuthChoice > Sign in / assets: `auth_header`, `icon_mail`, `icon_lock`, `icon_eye_on/off`, `btn_confirm_primary` / interactions: 密码眼切换、校验、登录 / 无例外 |
| P0 | 注册.png | 注册 Step1 | `SignUpCredentialsViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Create account / interactions: 邮箱格式校验、Next、转登录 / 无例外 |
| P0 | 注册(2).png | 注册 Step2 | `SignUpProfileViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: 注册 Step1 > Next / assets: `avatar_picker`, `icon_avatar_edit` / interactions: PHPicker 选头像、Create account / 无例外 |
| P0 | 首页.png | Home | `HomeViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Tab0 / assets: `btn_publish_note`, `tab_*` / components: Trending、Live Pulse、TabBar / interactions: 发布、Join、Check-in、详情 sheet / 无例外 |
| P0 | 探索.png | Explore Feed | `ExploreViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Tab1 / assets: `explore_buddy_banner`, `btn_publish_video`, `video_like_*`, `video_card_more` / interactions: AI、发布视频、For You/Following/Live Now、点赞、更多 / 无例外 |
| P0 | 消息.png | Chat | `ChatListViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Tab2 / assets: `btn_friend_request`, `btn_my_friend`, `icon_clear_all` / interactions: 好友申请、好友列表、清空、滑删、进入聊天 / 无例外 |
| P0 | 个人中心(笔记卡片）.png | Me Notes | `MeViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Tab3 / assets: `btn_settings`, `coin_card_bg`, `me_avatar_edit`, `me_card_delete` / interactions: 设置、充值、编辑、Notes/Videos、删除本人内容 / 无例外 |
| P1 | 发布笔记.png | 发布笔记 | `PublishNoteViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Home > Publish / assets: `photo_picker_box`, `photo_delete`, `mood_1..6`, `btn_confirm_primary` / interactions: PHPicker 多选、删除图片、校验、扣 29 金币 / keyboard: scroll interactive / 无例外 |
| P1 | 发布笔记(1).png | 发布笔记余额不足/成功 | `AppDialog` | 实现完成 | 已绑定 | 像素验收通过 | route: Post 校验结果 / assets: `dialog_bg`, `dialog_confirm/cancel` / interactions: OK/Cancel/跳充值按当前按钮语义 / 无例外 |
| P1 | ai聊天.png / ai聊天(1).png | AI 聊天/余额不足 | `AIChatViewController` | 实现完成 | 已绑定但受限 | 像素验收通过 | route: Explore > Buddy / assets: `ai_header`, `icon_send` / interactions: 5 免费后 8 金币、模板回复、余额不足弹窗 / keyboard: bottom input follows keyboard / 例外: 不接模型 API |
| P1 | 发布视频.png / 发布视频(1).png / 发布视频(2).png | 发布视频/余额不足/成功 | `PublishVideoViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Explore > camera / assets: `video_picker_box`, `icon_play` / interactions: PHPicker 视频、校验、扣 39 金币、成功弹窗 / 无例外 |
| P1 | 用户主页.png | 用户主页 | `UserProfileViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: 卡片头像/用户名 / assets: `fab_chat`, `icon_more`, `icon_back`, content media / interactions: Follow、Chat、More、Notes/Videos、卡片详情 / 无例外 |
| P1 | 动态详情.png | 动态详情 | `PostDetailViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Explore 卡片点按 / assets: `icon_play`, `video_like_off`, `icon_send` / interactions: 播放、评论输入、更多 / keyboard: `KeyboardAvoidance` / 无例外 |
| P1 | 举报拉黑.png | 举报拉黑 Sheet | `ReportBlockViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: More / assets: `icon_block`, `icon_report` / interactions: Block 写入 `SocialStore` 并刷新；Report 进入原因页 / 无例外 |
| P1 | 举报.png | 举报原因页 | `ReportViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: ReportBlock > Report / interactions: 选择原因、Submit、成功弹窗 / 无例外 |
| P1 | 聊天.png | 朋友聊天 | `FriendChatViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: 会话/好友列表 / assets: `chat_header`, `btn_video_chat`, `icon_send`, `icon_input_album` / interactions: 本地发送、视频入口 / keyboard: `KeyboardAvoidance` / 无例外 |
| P1 | 视频.png | 视频聊天 | `VideoCallViewController` | 实现完成 | 已绑定但受限 | 像素验收通过 | route: FriendChat > video / assets: `call_mic_on/off`, `call_speaker_on/off`, `call_flip`, `call_end` / interactions: mic/speaker/flip/end、10s 超时返回 / 例外: 无真实 RTC |
| P1 | 好友申请.png | 好友申请 | `FriendRequestsViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Chat > Friend request / assets: `btn_accept`, `btn_reject` / interactions: 接受/拒绝移除行、刷新空态 / 无例外 |
| P1 | 粉丝关注.png / 我的朋友.png | 社交列表 | `SocialListViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Me counts / Chat my friend / assets: `fab_chat` / interactions: 进入聊天 / empty: 新用户空态 / 无例外 |
| P1 | 设置.png | 设置 | `SettingsViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Me > Settings / assets: `icon_chevron` / interactions: 黑名单、Privacy/User Agreement WebView、Guidelines、Contact、Delete account、Log out / 无例外 |
| P1 | 修改资料.png | 修改资料 | `EditProfileViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Me > edit / assets: `edit_cover_box`, `edit_avatar_box`, `edit_avatar_pencil` / interactions: PHPicker 选封面/头像、Save 同步 Me / 无例外 |
| P1 | 黑名单.png | 黑名单 | `BlacklistViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Settings > Blacklist / assets: `btn_remove` / interactions: remove/unblock、空态 / 无例外 |
| P1 | 充值.png | 充值 | `RechargeViewController` | 实现完成 | 已绑定 | 像素验收通过 | route: Me > coin card / assets: `coin_card_bg`, `icon_coin_star` / interactions: StoreKit 2 商品、购买、finish、交易去重、余额刷新 / 无例外 |
| P2 | 缺省.png | 空态组件 | `EmptyStateView` | 实现完成 | 无需绑定 | 像素验收通过 | assets: `placeholder_empty` / used by Me/Social/Blacklist/FriendRequests / 无例外 |
| P2 | 加好友.png | 加好友确认 | `AppDialog` | 实现完成 | 已绑定 | 像素验收通过 | route: 用户主页 Chat 且未关注 / interactions: Add now? -> follow + chat / 无例外 |

开发状态：`未开始` · `进行中` · `实现完成` · `延期`

交互绑定：`无需绑定` · `未绑定` · `部分绑定` · `已绑定` · `已绑定但受限` · `待确认`

像素验收：`未验收` · `待工程验收` · `像素验收通过` · `需返修` · `不可验收`

## 统计

- 原稿/状态总数：**28 组案例行**（覆盖 hdxc 主要 P0/P1/P2 页面、弹窗、状态）
- 实现完成：**28**
- 交互已绑定/受限绑定：**27**
- 像素验收通过：**28**
- 主要限制：AI 不接模型 API；视频通话无真实 RTC；真实能力仅限 §6 声明范围。

## 工程证据示例

```text
original: 登录选择页.png
route: Cold start -> AuthChoice
file: hdxc/Features/Auth/AuthChoiceViewController.swift
layout: login_choice_bg full screen; ImageButton stack; 780x1688 DesignMetrics
assets: login_choice_bg, btn_apple, btn_create_account, btn_sign_in
asset-source: 项目设计图/设计图细节切图/登录选择页
metrics: button source 720x124, horizontal margin 32dp, gap 36dp
interactions: btn_apple -> ASAuthorizationController; btn_create_account -> SignUpCredentials; btn_sign_in -> SignIn
components: auth_choice_buttons -> image buttons with aspect ratio
exceptions: 无例外
```
