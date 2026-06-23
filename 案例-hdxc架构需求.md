# hdxc — 前端 UI 快速还原需求【案例】

> 用途：本案例按 `架构需求-模版.md` 口径，由 `/Users/Admin/Desktop/hdxc` 实际工程、设计资源、代码路由、Store、资源清单和变更记录整理而来。它是当前套件唯一项目案例。

## 0. 执行原则

1. 先做缺口审查：hdxc 已有工程、设计原稿、切图目录、资源清单和像素清单；实现时仍需先核对 §2 路径。
2. 屏幕清单来自实际原稿目录与已实现 ViewController；新增/缺失页面必须同步 §3 与像素清单。
3. 规划阶段先完成资源导入整理：递归扫描 §2 可用切图和内容素材，导入/暂存到 `hdxc/Assets.xcassets` 并写入 `资源导入清单.md`。
4. 页面图像严格使用 §2 可用切图、内容素材或现有 Assets；禁止导入设计原稿整图，禁止自制替代图案，禁止外部图片 URL、图标包、图库素材、AI 生成图、下载素材或非 §2 路径文件。
5. 按阶段门禁执行：屏幕清单 -> 资源导入整理 -> 组件/交互蓝图 -> 页面实现 -> 证据验收；不得跳阶段。
6. 切图命名驱动组件/弹窗/状态按钮和交互蓝图；真实能力以 §6 为准。
7. 每屏完成后同步 `资源导入清单.md`、`像素还原清单.md` 与 §10 变更记录。

## 1. 项目基础

| 项 | 填写 |
|---|---|
| 项目名称 | hdxc |
| 平台 | iOS |
| 技术栈 | Swift + UIKit，纯代码布局 |
| 工程路径 | `/Users/Admin/Desktop/hdxc` |
| 启动方式 | `hdxc.xcworkspace`，Scheme `hdxc` |
| 设计稿基准尺寸 | 780×1688 |
| 适配范围 | iPhone，短屏、安全区、内容纵向滚动，顶栏固定 |
| 还原目标 | 像素级还原；默认使用工程证据，截图/diff 仅作可选抽检 |

## 2. 设计资源

| 资源类型 | 路径 | 用途 |
|---|---|---|
| 设计原稿 | `/Users/Admin/Desktop/hdxc/项目设计图/设计图原稿` | 仅参考，不进运行时 |
| 可用切图/导出资源 | `/Users/Admin/Desktop/hdxc/项目设计图/设计图细节切图` | 可导入 `hdxc/Assets.xcassets` |
| 运行时资源目录 | `/Users/Admin/Desktop/hdxc/hdxc/Assets.xcassets` | 规划阶段导入/暂存后的运行时资源位置 |
| 内容填充素材 | `/Users/Admin/Desktop/hdxc/项目设计图/现场活动社交资料` | 头像、照片、视频；非设计原稿，可作演示内容 |
| 字体/色板/标注 | 工程内 `DesignTokens` / `DesignMetrics` | 颜色、尺寸、间距、dp 换算 |
| 资源导入清单 | `资源导入清单.md` | 原文件名到运行时资源名 |
| 像素还原清单 | `像素还原清单.md` | 屏幕覆盖、状态、工程证据 |

## 3. 屏幕清单

| 优先级 | 原稿文件 | 页面/状态 | 类型 | 对应实现 | 入口/触发 | 备注 |
|---|---|---|---|---|---|---|
| P0 | 启动.png | 启动/Launch | 状态 | `Base.lproj/LaunchScreen.storyboard` | Cold start | `launch_bg` 全屏 |
| P0 | 登录选择页.png | 选择登录方式 | FullScreen | `Features/Auth/AuthChoiceViewController.swift` | Cold start | Apple / Create account / Sign in |
| P0 | 登录.png | 邮箱密码登录 | Push | `Features/Auth/SignInViewController.swift` | 登录选择 > Sign in | 测试账号 `xchdmm@gmail.com / xchd12345` |
| P0 | 注册.png | 注册 Step1 | Push | `Features/Auth/SignUpCredentialsViewController.swift` | 登录选择 > Create account | 邮箱/密码校验 |
| P0 | 注册(2).png | 注册 Step2 | Push | `Features/Auth/SignUpProfileViewController.swift` | 注册 Step1 > Next | 头像/昵称；PHPicker 选头像 |
| P0 | 首页.png | Home | Tab 页面 | `Features/Home/HomeViewController.swift` | MainTab > Home | Trending Notes + Live Pulse |
| P0 | 探索.png | Explore Feed | Tab 页面 | `Features/Explore/ExploreViewController.swift` | MainTab > Explore | For You / Following / Live Now |
| P0 | 消息.png | Chat | Tab 页面 | `Features/Chat/ChatListViewController.swift` | MainTab > Chat | 好友申请、好友、Recent Chats |
| P0 | 个人中心(笔记卡片）.png | Me Notes | Tab 页面 | `Features/Me/MeViewController.swift` | MainTab > Me | Notes/Videos 页内切换 |
| P1 | 发布笔记.png | 发布笔记 | Push | `Features/Home/PublishNoteViewController.swift` | Home > 发布按钮 | PHPicker 选图；Post 扣 29 金币 |
| P1 | 发布笔记(1).png | 发布笔记余额不足/成功 | Overlay | `Common/AppDialog.swift` | 发布校验结果 | 自绘弹窗 |
| P1 | ai聊天.png / ai聊天(1).png | AI 聊天/余额不足 | Push/Overlay | `Features/Explore/AIChatViewController.swift` | Explore > Buddy | 5 次免费后 8 金币/条；本地模板回复 |
| P1 | 发布视频.png / 发布视频(1).png / 发布视频(2).png | 发布视频/余额不足/成功 | Push/Overlay | `Features/Explore/PublishVideoViewController.swift` | Explore > 发布视频 | PHPicker 视频；Post 扣 39 金币 |
| P1 | 用户主页.png | 用户主页 | Push | `Features/Explore/UserProfileViewController.swift` | 卡片头像/用户名 | Follow、Chat、More、Notes/Videos |
| P1 | 动态详情.png | 动态详情 | Push | `Features/Explore/PostDetailViewController.swift` | Explore 卡片点按 | 评论输入栏避让键盘 |
| P1 | 举报拉黑.png | 举报拉黑 Sheet | Bottom Sheet | `Features/Explore/ReportBlockViewController.swift` | More/report | Block / Report |
| P1 | 举报.png | 举报原因页 | Push | `Features/Explore/ReportViewController.swift` | ReportBlock > Report | 选择原因 + Submit |
| P1 | 聊天.png | 朋友聊天 | Push | `Features/Chat/FriendChatViewController.swift` | 会话/好友列表 | 输入栏、相册按钮、视频按钮 |
| P1 | 视频.png | 视频聊天 | Push | `Features/Chat/VideoCallViewController.swift` | 朋友聊天 > 视频按钮 | 本地摄像头预览；无真实 RTC；10s 超时弹窗 |
| P1 | 好友申请.png | 好友申请 | Push | `Features/Chat/FriendRequestsViewController.swift` | Chat > Friend request | Accept / Reject |
| P1 | 粉丝关注.png / 我的朋友.png | 社交列表 | Push | `Features/Me/SocialListViewController.swift` | Me counts / My friend | Chat 按钮；空态 |
| P1 | 设置.png | 设置 | Push | `Features/Me/SettingsViewController.swift` | Me > Settings | 协议、黑名单、Contact、删号、退出 |
| P1 | 修改资料.png | 修改资料 | Push | `Features/Me/EditProfileViewController.swift` | Me > edit | PHPicker 选头像/封面 |
| P1 | 黑名单.png | 黑名单 | Push | `Features/Me/BlacklistViewController.swift` | Settings > Blacklist | Remove / 空态 |
| P1 | 充值.png | 充值 | Push | `Features/Me/RechargeViewController.swift` | Me > coin card | StoreKit 2 真实消耗型 IAP |
| P2 | 缺省.png | 空态组件 | 状态 | `Common/EmptyStateView.swift` | 列表为空 | Me/Social/Blacklist/FriendRequests |
| P2 | 加好友.png | 加好友确认 | Overlay | `Common/AppDialog.swift` | 用户主页 Chat 且未关注 | Add now? |

### 3.1 原稿命名屏幕清单推断

| 项 | 填写 |
|---|---|
| 是否启用原稿命名推断 | 启用 |
| 推断来源 | 设计原稿文件名 / 切图目录 / 既有代码路由 / hdxc 实际 ViewController |
| 原稿扫描范围 | `/项目设计图/设计图原稿` 下 png 文件 |
| 自动生成字段 | 优先级、原稿文件、页面/状态、类型、对应实现、入口/触发、备注 |
| 优先级规则 | P0=启动/登录/主 Tab；P1=详情/发布/设置/充值/关键弹窗；P2=空态/加载/错误/可选状态 |
| 类型规则 | Tab 页面 / Push 页面 / FullScreen / Overlay / Bottom Sheet / 组件 / 状态 |
| 对应实现规则 | UIKit -> `Features/<模块>/<页面>ViewController.swift`；全局组件 -> `Common/*`；会话/数据 -> `Core/*` |
| 入口推断规则 | 首页=MainTab 默认；设置=Me > Settings；举报拉黑=More/report；弹窗=对应动作结果 |
| 冲突处理 | 已实现代码和 §6 能力边界优先；命名不清写待确认 |

### 3.2 原稿命名词典

| 命名片段 | 默认页面/状态 | 默认类型 | 默认优先级 | 默认入口/触发 |
|---|---|---|---|---|
| `启动` | 启动/Launch | 状态 | P0 | Cold start |
| `登录选择页` | 选择登录方式 | FullScreen | P0 | Cold start |
| `登录` | 邮箱密码登录 | Push | P0 | AuthChoice > Sign in |
| `注册`, `注册(2)` | 注册 Step1/Step2 | Push | P0 | AuthChoice > Create account |
| `首页` | Home | Tab 页面 | P0 | MainTab 默认 |
| `探索` | Explore Feed | Tab 页面 | P0 | MainTab > Explore |
| `消息` | Chat | Tab 页面 | P0 | MainTab > Chat |
| `个人中心` | Me Notes/Videos | Tab 页面 | P0 | MainTab > Me |
| `发布笔记` | 发布笔记/余额不足/成功 | Push/Overlay | P1 | Home > 发布按钮 |
| `ai聊天` | AI 聊天/余额不足 | Push/Overlay | P1 | Explore > Buddy banner |
| `发布视频` | 发布视频/余额不足/成功 | Push/Overlay | P1 | Explore > 发布视频按钮 |
| `用户主页` | 用户主页 | Push | P1 | 卡片头像/用户名 |
| `动态详情` | 动态详情 | Push | P1 | Explore/Home/Me 内容卡 |
| `举报拉黑`, `举报` | 举报拉黑 Sheet / 举报原因页 | Bottom Sheet / Push | P1 | More/report |
| `聊天` | 朋友聊天 | Push | P1 | Chat > 会话/好友 |
| `视频` | 视频聊天 | Push | P1 | FriendChat > 视频按钮 |
| `好友申请` | 好友申请 | Push | P1 | Chat > Friend request |
| `粉丝关注`, `我的朋友` | 社交列表 | Push | P1 | Me counts / My friend |
| `设置` | 设置 | Push | P1 | Me > Settings |
| `修改资料` | 修改资料 | Push | P1 | Me > edit |
| `黑名单` | 黑名单 | Push | P1 | Settings > Blacklist |
| `充值` | 充值 | Push | P1 | Me > coin card |
| `缺省` | 空态组件 | 状态 | P2 | 列表为空 |
| `加好友` | 加好友确认 | Overlay | P2 | 用户主页 Chat 且未关注 |

## 4. 导航与交互

| 入口 | 触发 | 结果 | 返回/关闭 | 备注 |
|---|---|---|---|---|
| 冷启动 | 启动完成 | 登录选择页 | 无 | 冷启动必回登录 |
| AuthChoice | Sign in | 邮箱登录 | Back | 真实本地邮箱登录 |
| AuthChoice | Create account | 注册 Step1/Step2 | Back | 新用户余额 0、空社交 |
| AuthChoice | Apple | `ASAuthorizationController` | 系统取消返回当前页 | 真实 Apple 登录 |
| Home | 发布笔记按钮 | 发布笔记页 | Back | 必填项 + 选图 + 余额校验 |
| Explore | Buddy banner | AI 聊天 | Back | 免费次数/扣费/余额不足弹窗 |
| Explore | 发布视频按钮 | 发布视频页 | Back | 选视频 + 内容 + 余额校验 |
| Explore/Profile/Detail | More | 举报拉黑 sheet | Sheet dismiss | Block 后过滤内容或返回 |
| Chat | Friend request | 好友申请页 | Back | Accept/Reject 移除行 |
| Chat | Recent chat | 朋友聊天页 | Back | 发送本地消息 |
| FriendChat | 视频按钮 | 视频聊天页 | End/timeout 返回 | 本地摄像头预览，无 RTC |
| Me | Settings | 设置页 | Back | 法务 WebView、黑名单、删号、退出 |
| Me | Coin card | 充值页 | Back | StoreKit 2 商品购买 |

### 4.1 切图命名交互推断

| 项 | 填写 |
|---|---|
| 是否启用命名推断 | 启用 |
| 推断来源 | 切图文件名 / Assets 名 / 代码路由 / project-interaction-patterns.md |
| 命名聚类规则 | 同 stem 的 `off/on`、`normal/selected`、`accept/reject`、`dialog_*`、`call_*`、`tab_*` 合并为同一组件或控件 |
| 可自动搭建的组件/弹窗 | Tab、PillButton、内容卡、视频卡、ReportBlock sheet、AppDialog、ChatInputBar、EmptyState |
| 可直接实现的低风险交互 | 返回、关闭、Tab/筛选切换、点赞本地切换、评论本地追加、静态设置入口 |
| 可本地演示但需登记假设 | 关注/好友关系、本地拉黑、删除本地内容、发布本地内容、Event Join/Check-in |
| 必须待确认或按 §6 实现 | Apple 登录、PHPicker、AVCapture、StoreKit、WebView、账号删除、AI 扣费 |
| 命名冲突处理 | 优先 §6 能力边界与已实现代码；其次命名推断；冲突写入 §10 变更记录 |
| 同类去重规则 | 相同控件类型或业务语义只登记一条模式；实例证据写入资源清单和像素清单 |

### 4.2 推断交互登记表

| 模式/页面组件 | 资源名/切图名 | 触发 | 前置条件 | 推断结果 | 状态同步/失败路径 | 风险 | 状态 | 备注 |
|---|---|---|---|---|---|---|---|---|
| auth.apple_login | `btn_apple` | 点击 | Apple capability 可用 | 发起 Apple 登录，成功激活账号 | 取消不跳转；失败弹窗 | 高 | 已绑定 | §6 明确真实 |
| auth.password_visible | `icon_eye_on/off` | 点击 | 密码字段存在 | 切换 secure text 和眼睛图标 | 无失败路径 | 低 | 已绑定 | 登录/注册复用 |
| content_card.like | `like_off/on`, `video_like_off/on` | 点击 | 本地内容可见 | 切换点赞与计数 | 复用卡片同步；登录重置 feed 点赞态 | 低 | 已绑定 | 带动画 |
| content_card.more | `card_more`, `video_card_more`, `icon_more` | 点击 | 非本人内容 | Present 举报拉黑 sheet | Block 过滤内容；Report 进入原因页 | 中 | 已绑定 | 本人内容显示删除 |
| own_content.delete | `me_card_delete` | 点击 | 本人内容 | 确认后删除本地笔记/视频 | 刷新 Me/Home/Explore/空态 | 中 | 已绑定 | 所有权规则 |
| social.follow | `Follow按钮`, `Following按钮` | 点击 | 目标用户可关注 | 本地 follow/unfollow | Profile/Feed/Social 计数同步 | 中 | 已绑定 | 带动画 |
| friend_request.respond | `btn_accept`, `btn_reject` | 点击 | 请求存在 | 接受/拒绝并移除行 | 好友列表/角标/空态刷新 | 中 | 已绑定 | Chat 模块 |
| chat.send | `icon_send` | 点击/键盘提交 | 输入非空 | 追加本地消息并滚到底部 | 空发送忽略；键盘避让 | 中 | 已绑定 | Chat/AI/Detail |
| publish.submit | `btn_confirm_primary` | 点击 Post | 必填项、媒体、余额足够 | 扣费并插入本地内容，成功弹窗 | 余额不足/校验失败弹窗 | 中/高 | 已绑定 | 笔记 29、视频 39 |
| media.pick | `photo_picker_box`, `video_picker_box`, `avatar_picker` | 点击 | §6 允许 PHPicker | 打开系统 picker，选择后更新预览 | 取消不变；缺权限按系统处理 | 高 | 已绑定 | 真实系统能力 |
| ai.send | `icon_send` | 点击/键盘提交 | 输入非空；免费次数或余额 | 追加用户消息和模板回复 | 免费用尽提示 8 金币；余额不足不扣费 | 高 | 已绑定但受限 | 不接模型 API |
| call.controls | `call_mic_on/off`, `call_speaker_on/off`, `call_flip`, `call_end` | 点击 | 进入通话页 | 切换本地状态/翻转摄像头/结束 | 10s 未接通返回并弹窗 | 高 | 已绑定但受限 | 无真实 RTC |
| settings.legal | `icon_chevron` | 点击协议行 | URL 已声明 | Push WebView | 加载失败显示错误状态 | 中/高 | 已绑定 | Google Docs 发布页 |
| wallet.purchase | StoreKit package | 点击套餐/Continue | 商品加载成功 | StoreKit purchase，finish 后入账 | 失败/取消不改余额 | 高 | 已绑定 | 真实 IAP |

### 4.3 组件/弹窗蓝图登记表

| 页面/模块 | 命名资源簇 | 自动生成产物 | 默认状态/动作 | 实现策略 | 状态 |
|---|---|---|---|---|---|
| 全局 | `dialog_bg` + `dialog_confirm/cancel` | `AppDialog` 自绘弹窗 | 确认/取消/关闭 | 复用全局弹窗底图 | 已实现 |
| 全局 | `tab_*_off/on` + `tabbar_bg` | 自定义 TabBar | 切换选中态/角标 | `CustomTabBarView` | 已实现 |
| Auth | `btn_apple/create/sign_in` | 登录选择按钮组 | Apple/注册/登录 | `PillButton.ImageButton` 等比约束 | 已实现 |
| 内容卡 | `like_on/off` + `card_more` + `me_card_delete` | 内容卡组件 | 点赞/更多/删除 | 所有权区分 | 已实现 |
| 视频卡 | `video_like_on/off` + `video_card_more` + `icon_play` | 视频卡组件 | 播放/点赞/更多 | `VideoCardCell` | 已实现 |
| 举报拉黑 | `icon_block` + `icon_report` | Bottom Sheet | Block/Report | `ReportBlockViewController` | 已实现 |
| 聊天 | `icon_send` + `icon_input_album` | 输入栏 | 发送/相册 | `ChatInputBar` + 键盘避让 | 已实现 |
| 视频通话 | `call_*` | 通话控制条 | mic/speaker/flip/end | `VideoCallViewController` | 已实现 |
| 空态 | `placeholder_empty` | 空态组件 | 展示说明 | `EmptyStateView` | 已实现 |

完整性判断口径：

- 每条交互必须写清触发、前置条件、结果、状态变化或失败/取消路径。
- 涉及余额、登录、权限、外链、支付、账号删除、媒体能力时，必须能回指 §6。
- 涉及本地数据变化时，必须写跨页面同步范围，例如 Home/Explore/Profile、Chat 角标、钱包余额、黑名单、空态。
- 同类交互只登记一条模式；所有权规则、风险或能力边界不同才拆行。

风险口径：

- 低：只影响当前 UI 或本地演示状态，可直接实现并登记。
- 中：涉及用户数据变更、跨页面状态同步、外链或权限前置；可做本地演示，但需记录假设。
- 高：涉及真实账号、支付、AI/聊天计费、媒体权限、账号删除、后端写入；必须由 §6 明确后再实现。

## 5. 全局 UI 规则

| 类别 | 规则 |
|---|---|
| 坐标换算 | `DesignMetrics`，780×1688 基准 |
| 安全区/短屏 | TabBar、底部按钮、输入栏尊重 safe area；滚动内容补 bottom inset |
| 滚动区域 | 顶栏固定，内容滚动；Me 卡片可滚至 TabBar 上方完整显示 |
| 键盘/输入栏 | `KeyboardAvoidance` / keyboard notifications；Chat、AI、Detail、发布页避让键盘 |
| 字体 | 系统字体；标题/按钮/正文按 `DesignTokens` 字重和字号 |
| 颜色 | `DesignTokens`；背景优先使用项目切图与 token 色值 |
| 圆角/阴影 | 按设计稿和切图；例外写入像素清单 |
| 弹窗 | 业务弹窗自绘；系统流程仅用于 Apple、PHPicker、StoreKit、权限 |
| 图像资源限制 | 必须使用 `资源导入清单.md` 中已导入的 §2 可用切图、内容素材或现有 Assets；缺图登记待补；禁止外部图片 URL、图标包、图库素材、AI 生成图、下载素材或非 §2 路径文件 |

## 6. 能力边界

| 能力 | 真实程度 | 说明 |
|---|---|---|
| 数据 | 轻量拟真本地 | `AppSession` + `ContentStore` + `SocialStore` + `ChatStore` |
| 登录/账号 | 真实 | Apple Sign In + 邮箱注册/登录；冷启动回登录 |
| 账户初始数据 | 真实(本地) | 每次登录重置；新用户空态/余额 0；测试账号演示数据/余额 100 |
| 支付/订阅 | 真实 | StoreKit 2 consumable；购买成功入账本地余额 |
| 聊天/房间/视频 | 部分真实 | 聊天本地消息；视频聊天真实摄像头预览；无真实 RTC，10 秒未接通返回 |
| AI | 仅 UI | `AIReplyEngine` 本地模板；不接模型 API；5 次免费后每条 8 金币 |
| 媒体/权限 | 真实 | `PHPickerViewController` 选图/选视频；`AVCaptureSession` 摄像头预览 |
| Event Pulse / Crew | 真实(本地) | `EventPulseStore` 聚合现场活动；Home Join/Check-in；Explore Live Now；Chat Event Crew；Me Event Passport |
| 本地持久化 | 真实 | `AccountScopedStorage` 按账号隔离 |
| 后端 API | 无 | 不接远程 API |

### 6.1 账户状态矩阵

| 账户状态 | 进入方式 | 数据来源 | 页面表现 | 可演示交互 |
|---|---|---|---|---|
| 游客/未登录 | 冷启动 / Log out / Delete account 后 | 无账号数据 | 仅登录选择、登录、注册、协议入口 | Apple 登录、邮箱登录、注册 |
| 新用户 | 邮箱注册 / Apple 首次登录 | `AccountBootstrap` 新用户默认值 + account-scoped key | 金币 0；空社交、空聊天、空我的动态；无预点赞 | 编辑资料、关注、发布校验、AI 免费次数、充值 |
| 测试账号 | `xchdmm@gmail.com / xchd12345` | `AccountBootstrap` 测试账号播种数据 | 完整 Home/Explore/Chat/Me；余额 100；好友/关注/粉丝/未读/活动数据齐全 | 全链路演示；测试账号不可删除 |
| Apple 用户 | `ASAuthorizationController` 成功 | Apple user id + 本地资料 | 新用户首次为空态；后续单进程内切换按 account id 隔离 | 与新用户一致；头像可用首字母生成 |

### 6.2 持久化与账户数据隔离

- 持久化载体：UserDefaults + `AccountScopedStorage`。
- 存储 key：按 account id 加前缀保存钱包、关注、点赞、拉黑、发布内容、资料、交易 id 等。
- 账户隔离：`AppSession.activate` 激活账号后，各 Store 按当前账号加载；切账户不得串用上一账户的社交、聊天、余额和发布内容。
- 重置策略：每次重新登录重置账户状态；测试账号重新播种演示数据；AI 聊天对话和免费次数仅进程内保持。
- 账号删除：新用户可删除并回登录选择页；内置测试账号弹窗提示不可删除。

### 6.3 业务规则与演示数据

| 规则 | 说明 |
|---|---|
| 发布笔记 | 必须选择图片，必填 activity name/place/times；余额 >= 29 才可 Post；成功后扣 29 并插入本地内容 |
| 发布视频 | 必须选择视频，必填 Content；余额 >= 39 才可 Post；成功后扣 39 并插入本地内容 |
| AI 聊天 | 每次登录 5 次免费；之后每条 8 金币；余额不足弹自绘弹窗，不接真实模型 |
| 点赞/关注 | 本地状态 + 动画；Home/Explore/Profile/Me 相关计数同步 |
| 举报/拉黑 | 举报为 UI 流程；拉黑写入本地黑名单，过滤 Home/Explore/Profile 中对应内容 |
| 好友申请 | Accept/Reject 后本地移除请求；好友列表、角标、空态刷新 |
| Event Pulse | Join/Check-in 为本地活动状态；测试账号预置 RSVP 与 Crew 数据 |
| 充值 | StoreKit 2 真实消耗型 IAP；购买验单并 finish 后 `AppSession.addCoins` 入账，交易 id 去重 |
| 法务入口 | Privacy/User Agreement 走 WebView；Community Guidelines 为本地静态页；Contact Us 显示邮箱 |

## 7. 实现顺序

| 阶段 | 范围 | 验收 |
|---|---|---|
| 0 | 安装/读取/缺口审查 | Skill/rule 可用；四类文档可写 |
| 1 | 原稿扫描与屏幕清单 | §3 覆盖原稿目录；像素清单初始行已写 |
| 2 | 资源导入整理 | §2 切图和内容素材已导入/暂存至 Assets；资源清单已登记 |
| 3 | 组件/弹窗/交互蓝图 | §4.1/§4.2/§4.3 已写，风险和绑定状态已分类 |
| 4 | 全局基础 | DesignMetrics、Tokens、TPChrome、TabBar、AppDialog |
| 5 | Auth P0 | 冷启动、登录选择、登录、注册、Apple |
| 6 | Home / Explore | Feed、发布、AI、视频、详情、举报拉黑 |
| 7 | Chat | 会话、好友申请、朋友聊天、视频通话 |
| 8 | Me / Settings | 个人中心、社交列表、修改资料、黑名单、充值、删号/退出 |
| 9 | 联调验收 | 清单、证据、Xcode build |

## 8. 像素验收口径

`实现完成` 代表代码、切图、约束和可确认交互已落地。

`像素验收通过` 必须在 `像素还原清单.md` 记录：

- 入口/路由。
- 界面名称/状态，并与 §3 `页面/状态` 保持一致。
- 实现文件。
- 坐标换算/约束位置。
- 已登记资源。
- 3-6 个关键元素度量依据。
- 关键按钮交互：资源名、触发方式、结果、绑定状态。
- 键盘页证据：输入栏高度、bottom/safe-area/keyboard 避让约束、键盘弹出后是否遮挡、空发送/取消路径。
- 例外项或 `无例外`。

截图、diff、并排对比、人工复核仅作为可选抽检。

## 9. 最终验收

- [x] §2 设计原稿目录已扫描，§3 覆盖 P0/P1/P2 页面、弹窗和状态。
- [x] `像素还原清单.md` 已列出界面名称/状态。
- [x] `像素还原清单.md` 没有只列原稿文件或保留 `【由命名推断】` 占位。
- [x] 资源来自 §2 允许目录，`资源导入清单.md` 已更新。
- [x] 规划阶段已完成切图资源导入/整理，运行时资源名、来源、导入状态和绑定状态可在资源清单追溯。
- [x] 页面图像严格使用 §2 可用切图、内容素材或现有 Assets，没有自制替代图案/图标/插画/背景。
- [x] 页面没有使用外部图片 URL、图标包、图库素材、AI 生成图、下载素材或非 §2 路径文件。
- [x] 缺失关键切图已登记为待补或使用现有 Assets/代码基础 UI 原语，不伪造图片。
- [x] 源码和运行时资源不引用设计原稿。
- [x] §4.2/§4.3 中低风险组件和交互已绑定，高风险按 §6 落地或限制。
- [x] 交互证据覆盖触发、前置条件、结果、状态同步/失败路径。
- [x] 同类交互已按模式去重登记，重复实例只在资源清单/像素清单写证据。
- [x] §10 中每条变更均已反查并同步到对应章节、`AGENTS.md` 和两份清单。
- [x] `像素还原清单.md` 区分实现状态与像素验收状态，工程证据完整。
- [x] 导航、弹窗、滚动、安全区符合 §4/§5。
- [x] 输入栏和键盘避让有工程实现。
- [x] 能力真实程度符合 §6。
- [x] 可用 Xcode build 已执行或在项目交付记录中说明结果。

## 10. 变更记录

| 日期 | 来源 | 变更 | 落点 |
|---|---|---|---|
| 2026-06-11 | 启动指南提示词 | 由 `架构需求-模版.md` 落地为唯一事实源；同步 AGENTS、资源清单、像素清单 | 本文件 / AGENTS / 两份清单 |
| 2026-06-11 | P0 实现 | 全局基础 + Auth 流程 + 纯代码入口 | Core/Common/App/Auth |
| 2026-06-11 | 用户反馈 | 按切图实测校正按钮尺寸、边距和弹窗比例 | DesignMetrics / Auth / Common |
| 2026-06-11 | 用户环境 | 检测到 Podfile/Workspace，构建改用 `hdxc.xcworkspace` | 构建流程 |
| 2026-06-11 | P1/P2 实现 | 完成 Home/发布笔记、Explore/AI/发布视频/详情/举报拉黑/用户主页、Chat/朋友聊天/视频通话/好友申请、Me/社交/设置/改资料/黑名单/充值 | Features/* + Core Store |
| 2026-06-11 | 设计/规格冲突 | AI 原稿为每天 5 次免费、之后 8 金币/条；按原稿实现 | AppConstants / AIChatViewController / §6 |
| 2026-06-11 | 切图实测 | Buddy/好友申请等横幅按钮使用等比 `ImageButton`，避免拉伸变形 | PillButton / Explore / Chat |
| 2026-06-11 | 用户请求 | 更换系统启动页切图 `启动页背景图.png` -> `launch_bg` | LaunchScreen / Assets |
| 2026-06-11 | 用户请求 | 真实 Apple 登录；内置测试账号改为 `xchdmm@gmail.com / xchd12345` | hdxc.entitlements / AuthChoice / AppConstants / AppSession |
| 2026-06-11 | 用户请求 | 账户分级：新用户空社交/聊天/我的动态；测试账号丰富演示数据；Apple 昵称和首字母头像 | AccountBootstrap / SocialStore / ChatStore / ContentStore / Me |
| 2026-06-11 | 用户请求 | Me Notes/Videos 改为页内切换，不 push 二级界面 | MeViewController / §3 |
| 2026-06-11 | 用户请求 | 视频聊天页灰色头像 + 加载动画；10 秒未接通返回并弹窗 | VideoCallViewController / §4.2 |
| 2026-06-11 | 用户反馈 | 笔记卡举报拉黑改为与视频卡一致的底部 Sheet | Home / Me / UserProfile / ReportBlock |
| 2026-06-11 | 用户请求 | 本用户笔记/视频卡显示删除按钮，可删除；首页/探索本人卡片与 Me 一致 | NoteCardView / VideoCardCell / ContentStore |
| 2026-06-11 | 用户请求 | Explore For You/Following 可切换：For You 排除拉黑用户；Following 仅已关注用户视频 | ExploreViewController / ContentStore / SocialStore |
| 2026-06-11 | 用户请求 | 10 个社区用户与测试账户使用现场活动社交资料/头像中不同素材 | DemoMediaCatalog / ContentStore / Assets |
| 2026-06-11 | 用户请求 | 新用户 Me 顶部默认 `edit_cover_box`；修改资料上传封面后同步刷新 | Me / EditProfile / AppSession |
| 2026-06-11 | 用户请求 | 每次重新登录重置账户状态；AI 聊天仅本次登录内保持 | AccountBootstrap / AIChatStore / AppSession / §6 |
| 2026-06-11 | 用户请求 | 明确账户初始数据：新用户余额 0；测试账号余额 100 | AccountBootstrap / AppConstants / §6 |
| 2026-06-11 | 用户反馈 | Me 卡片可上滑至 TabBar 上方完整显示 | MeViewController / §5 |
| 2026-06-11 | 用户反馈 | Me Settings 按钮位于蓝色封面下方 20dp、trailing 32dp，尺寸 176×72dp | MeViewController / 像素清单 |
| 2026-06-11 | 用户请求 | Privacy Agreement 以 WebView 呈现；入口在设置页和登录页 | DocumentWebViewController / AppConstants.Legal / Settings / AuthChoice |
| 2026-06-11 | 用户请求 | User Agreement 以 WebView 呈现；入口在设置页和登录页 | AppConstants.Legal / Settings / AuthChoice |
| 2026-06-11 | 用户请求 | 设置页补齐 Community Guidelines、Contact Us、Delete account、品牌名 Himi | LegalText / ContactUs / Settings / AppSession |
| 2026-06-11 | 用户请求 | Delete account：新用户可删并回登录；测试账号不可删 | AppSession.deleteAccount / Settings |
| 2026-06-11 | 用户请求 | Follow/Following 与点赞增加动画 | InteractionAnimations / UserProfile / Explore / NoteCard / VideoCard |
| 2026-06-11 | 用户请求 | 新用户从未对任何笔记/视频预点赞；每次登录重置 feed 点赞态 | ContentStore / AccountBootstrap / §6 |
| 2026-06-11 | 用户请求 | Me 视频卡可进动态详情；本人视频详情不显示举报拉黑 | Me / PostDetail |
| 2026-06-11 | 用户请求 | 充值页接入 StoreKit 2 IAP；Debug/Release 均走真实 App Store | IAPProductCatalog / IAPStore / Recharge / §6 |
| 2026-06-11 | 用户请求 | IAP 购买成功后本地入账，交易 id 去重 | IAPStore / AppSession.addCoins / AccountScopedStorage |
| 2026-06-15 | App Store 4.3 拒审 | 四主 Tab 增加 Event Pulse / Crew / Passport 差异化能力 | EventPulseStore / Home / Explore / Chat / Me / §6 |
| 2026-06-15 | 用户反馈 Pulse UI | 放大 Pulse 卡片，新增活动详情 Sheet、Live Tonight 条、Crew 快捷回复 | LivePulseCarousel / EventPulseDetail / LiveTonight / EventCrewChat |
| 2026-06-15 | 用户请求 | 演示活动日期统一为 2026-08-01 及之后 | DemoEventDates / ContentStore / AccountBootstrap / EventPulseStore |
| 2026-06-15 | 用户请求 | 演示活动改为真实已公布场次，移除虚构条目 | DemoEventDates / DemoRealEvents / ContentStore / AccountBootstrap |

### 10.1 变更同步审计

| 变更类型 | 必须同步位置 | hdxc 案例状态 |
|---|---|---|
| 屏幕、入口、跳转、弹窗或状态 | §3、§4、§4.2、§4.3、像素清单 | 已同步：P0/P1/P2 页面、弹窗、Tab、Push、Overlay 均有登记 |
| 资源、切图替换或命名推断 | §2、§4.1、§4.3、资源清单、像素证据 | 已同步：资源来自设计细节切图、现场活动素材或现有 Assets |
| 真实能力、权限、支付、登录、外链、账号删除 | §6、AGENTS、风险状态、变更记录 | 已同步：Apple、PHPicker、AVCapture、StoreKit、WebView、账号删除均在 §6 |
| 本地数据和跨页状态 | §4.2、§6.1、§6.2、§6.3、像素清单 | 已同步：账户隔离、余额、点赞、关注、黑名单、未读、Event 状态均有说明 |
| 缺陷修复和像素校正 | §5、§8、像素清单、资源清单 | 已同步：按钮比例、Me 滚动、Settings 按钮位置、键盘避让等已登记 |
| 同类变更去重 | §4.2/§4.3 写模式，两份清单写实例证据 | 已同步：内容卡、视频卡、弹窗、输入栏、Tab、通话控制条按模式登记 |
