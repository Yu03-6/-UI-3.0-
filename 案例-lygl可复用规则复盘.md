# lygl 可复用规则复盘【案例】

> 用途：记录从 `/Users/Admin/Desktop/lygl` 已完成项目中抽取的通用界面判断和交互模式。本文不是 lygl 的完整项目规格，不复制项目专属账号、路径、商品 ID、素材编号、品牌文案或私有数据；可复用结论已同步到执行字典和参考文档。

## 1. 可复用界面判断

| 原稿命名线索 | 通用判断 | 默认入口/触发 | 优先级 |
|---|---|---|---|
| `账号登录`, `邮箱登录`, `account login`, `welcome back` | 邮箱/账号登录表单 | 登录选择 > Sign in | P0 |
| `创建账号可跳过`, `可跳过填写`, `skip profile`, `optional profile` | 注册资料可选步骤 | 注册账号 > Next | P0 |
| `朋友列表`, `好友列表`, `friends`, `my friends` | 朋友/好友列表 | Messages/Friends 入口或关系统计 | P1 |
| `好友申请`, `friend request`, `requests` | 好友申请列表 | Messages/Requests 入口或红标 | P1 |
| `粉丝`, `关注`, `followers`, `following` | 粉丝/关注统计列表 | Me/Profile 统计点击 | P1/P2 |
| `聊天次数`, `次数`, `quota`, `limit`, `free chats` | 用量耗尽/次数解锁弹窗 | AI/聊天发送时用量耗尽 | P1 |
| `logout`, `log out`, `sign out` | 退出登录入口 | Settings account section | P1 |

## 2. 可复用交互模式

| 模式 | 命名/代码信号 | 默认交互 | 能力边界 |
|---|---|---|---|
| auth.optional_profile | `skip`, `optional`, `profile_setup`, `avatar`, `nickname`, `bio` | 可选资料字段允许默认值；必填账号凭证仍需校验 | 真实账号、资料持久化需 §6 |
| social.say_hi_gate | `say_hi`, `hi`, `wave`, `chat`, `follow` | 本地发送问候；若聊天有关系门槛，先提示关注/加好友 | 真实 IM/推送需 §6 |
| profile.stats_drilldown | `posts`, `followers`, `following`, profile stats | 统计点击进入对应过滤列表；行操作回写计数和空态 | 后端关系/内容数据需 §6 |
| publish.floating_drag | floating `publish`, `plus`, `add`, `post` button | 可拖拽发布入口；区分点击和拖动；点击走发布或解锁 | 发布权限、扣费、媒体能力需 §6 |
| quota.usage_gate | `quota`, `limit`, `free`, `次数`, `chats_left` | 用量耗尽弹窗；解锁/充值/重置按规格 | 真实计费、重置周期、服务额度需 §6 |
| settings.logout | `logout`, `log_out`, `sign_out` | 清除声明的会话状态并回登录根页 | 账号持久化和测试账号策略需 §6 |
| local.relationship_lists | `friends`, `requests`, `accept`, `reject`, `followers`, `following` | 本地关系列表、好友申请接受/拒绝、空态刷新 | 后端好友系统需 §6 |

## 3. 字典同步落点

| 文件 | 同步内容 |
|---|---|
| `.cursor/skills/frontend-ui-from-spec/screen-inventory-inference.md` | 账号登录、可跳过资料注册、朋友列表、好友申请、粉丝/关注列表、聊天次数解锁的页面判断 |
| `.cursor/skills/frontend-ui-from-spec/interaction-inference.md` | 可选资料注册、Say Hi 关系门槛、个人统计入口、可拖发布按钮、用量配额弹窗、退出登录的交互判断 |
| `.cursor/skills/frontend-ui-from-spec/project-interaction-patterns.md` | Optional profile step、Profile stat drilldown、Say Hi/greeting、Draggable publish/add、AI quota exhausted、Logout/sign out |
| `参考-原稿命名屏幕清单生成.md` | 人类可读的新增原稿命名线索 |
| `参考-切图命名交互补全.md` | lygl 复盘新增模式 |
| `参考-项目按钮交互操作模式.md` | 可跳过资料、Say Hi、统计列表、可拖发布、次数配额和退出登录按钮模式 |

## 4. 不沉淀为通用规则的内容

- lygl 项目路径、工程名、Scheme、测试账号、商品 ID、素材编号和具体 UI 文案。
- 某个项目专属的金币数量、免费次数、用户数量、直播视频数量或默认数据。
- Apple 登录、StoreKit、PHPicker、AVCapture、WebView、AI 计费、删号等能力的默认开启状态。
- 特定品牌色、品牌名和专属视觉文案。

## 5. 复盘结论

lygl 主要补强了“社交账号型 UI”的通用推断：可跳过资料注册、Say Hi/关系门槛、个人统计列表、好友/申请列表、可拖发布入口、AI 次数配额弹窗和设置退出/删号入口。后续项目可自动识别这些页面和交互，但真实账号、支付、配额、媒体和远程服务仍必须由 `架构需求.md` §6 明确授权。
