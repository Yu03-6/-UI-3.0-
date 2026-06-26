# clsj 可复用规则复盘【案例】

> 用途：记录从 `/Users/Admin/Desktop/clsj` 已完成项目中抽取的通用界面判断和交互模式。本文不是 clsj 的完整项目规格，不复制项目专属账号、路径、商品 ID、素材编号、角色名、品牌文案或私有数据；可复用结论已同步到执行字典和参考文档。

## 1. 可复用界面判断

| 原稿命名线索 | 通用判断 | 默认入口/触发 | 优先级 |
|---|---|---|---|
| `动态详情`, `post detail`, `评论区` | 内容详情/评论详情页 | 内容卡片或评论按钮 | P1 |
| `排行`, `rank`, `leaderboard` | 排行榜页，常带 Today/Weekly 等分段 | 首页排行卡或 See full rank | P1 |
| `通知`, `消息清除`, `notification`, `notice`, `clear messages` | 通知列表或列表清理状态 | 首页铃铛、消息通知入口或清理按钮 | P1 |
| `充值`, `套餐`, `package`, `pkg`, `price`, `balance` | 钱包/充值套餐选择页 | 余额入口、付费弹窗或充值入口 | P1 |
| `照片选择`, `视频预览`, `photo picker`, `video preview`, `media preview` | 发布媒体选择与预览状态 | 发布页选择图片/视频后 | P1 |
| `付费弹窗`, `余额不足`, `not enough`, `paywall` | 余额不足或付费提示弹窗 | 受限动作、AI 发送、发布提交 | P1 |
| `发布成功`, `posted`, `success`, `done` | 发布成功反馈弹窗 | 发布提交成功 | P1 |
| `视频聊天`, `mic`, `speaker`, `end call` | 视频通话页/通话控制状态 | 聊天页视频按钮 | P1 |

## 2. 可复用交互模式

| 模式 | 命名/代码信号 | 默认交互 | 能力边界 |
|---|---|---|---|
| wallet.package_grid | `recharge_pkg_normal/selected`, `package`, `pkg`, `price`, `continue` | 点击套餐切换选中态；购买中禁用主按钮；成功/失败/取消后刷新余额或提示 | 真实 StoreKit/IAP、商品来源、交易去重需 §6 |
| publish.media_preview | `photo_picker`, `video_picker`, `preview`, `play`, `pause`, `media_delete` | 选择媒体后显示预览和删除按钮；删除恢复选择占位；视频预览离屏停止 | PHPicker、相册/文件持久化、权限需 §6 |
| call.timeout_controls | `video_call`, `mic_on/off`, `speaker_on/off`, `end_call` | 进入通话 UI 后启动计时/加载；挂断停止计时和预览；超时返回并提示 | 真实 RTC、音频路由、相机/麦克风权限需 §6 |
| notification.row_cleanup | `notification`, `notice`, `ignore`, `dismiss`, `clear` | 行级清理或清空列表；刷新角标和空态；不删除源内容 | 清理范围、聊天删除、后端通知需 §6 |
| store.domain_sync | `contentChanged`, `socialChanged`, `walletChanged`, `chatChanged`, observable/store events | 源 Store 变更后统一刷新复用卡片、计数、红标、列表和空态 | 远程同步、跨账号持久化需 §6 |
| moderation.block_filter | `report`, `block`, `blacklist`, `remove` | 本地拉黑后过滤内容、评论、聊天、通知和推荐候选；解封刷新 | 后端举报/拉黑需 §6 |
| account.data_tiers | 测试/演示账号、新用户、空社交/空聊天 | 演示账号可播种丰富数据；新账号只展示公共内容与空私有列表 | 账号真实程度、重置和持久化策略需 §6 |

## 3. 字典同步落点

| 文件 | 同步内容 |
|---|---|
| `.cursor/skills/frontend-ui-from-spec/screen-inventory-inference.md` | 动态详情、排行、通知/消息清理、充值套餐、媒体预览、付费/发布成功弹窗的页面/状态判断 |
| `.cursor/skills/frontend-ui-from-spec/interaction-inference.md` | 钱包套餐、媒体预览、通知/申请清理、视频通话超时、跨页面 Store 同步的交互判断 |
| `.cursor/skills/frontend-ui-from-spec/project-interaction-patterns.md` | Notification dismiss、Recharge package selection、Media preview play/pause、Cross-screen sync |
| `参考-原稿命名屏幕清单生成.md` | 人类可读的新增原稿命名线索 |
| `参考-切图命名交互补全.md` | clsj 复盘新增模式 |
| `参考-项目按钮交互操作模式.md` | 钱包套餐、媒体预览、通知清理、通话超时和跨页面同步按钮模式 |

## 4. 不沉淀为通用规则的内容

- clsj 项目路径、工程名、Scheme、测试账号、商品 ID、素材编号、角色名、专属昵称和具体 UI 文案。
- 某个项目专属的金币金额、套餐数量、扣费数值、通话超时秒数、默认用户数量或默认消息内容。
- Apple 登录、StoreKit、PHPicker、AVCapture、WebView、AI 扣费、删号等能力的默认开启状态。
- 特定品牌色、背景图、头像、冲浪素材、排行算法权重和内容主题。

## 5. 复盘结论

clsj 主要补强了“完成度判断”而不是新增某个专属业务：钱包套餐必须有选中、加载、失败和余额同步；发布媒体必须有选择、预览、删除和取消路径；视频通话必须有计时、挂断、超时和权限边界；通知/申请清理必须明确删除范围；跨页面状态要从源 Store 刷新所有复用视图。后续项目可自动识别这些界面和交互，但真实支付、媒体权限、音视频、账号和后端能力仍必须由 `架构需求.md` §6 明确授权。
