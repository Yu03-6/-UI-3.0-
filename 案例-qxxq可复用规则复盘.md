# qxxq 可复用规则复盘【案例】

> 用途：记录从 `/Users/Admin/Desktop/qxxq` 已完成项目中抽取的通用界面判断和交互模式。本文不是 qxxq 的完整项目规格，不复制项目专属账号、路径、商品 ID、素材编号或私有文案；可复用结论已同步到执行字典和参考文档。

## 1. 可复用界面判断

| 原稿命名线索 | 通用判断 | 默认入口/触发 | 优先级 |
|---|---|---|---|
| `搜索`, `search` | 搜索页 / 搜索状态 | Explore/Search 入口或搜索框点击 | P1 |
| `直播`, `直播间`, `live`, `room` | 直播间 / Live room | 直播卡 Join/Watch | P1 |
| `阅读`, `文章`, `read`, `article`, `story` | 阅读列表或阅读详情 | 阅读入口卡；文章卡点击 | P1 |
| `ai`, `ai聊天`, `角色` | AI 角色列表、AI 聊天或 AI 余额不足弹窗 | AI 入口卡；角色卡；发送余额不足 | P1 |
| `共鸣`, `匹配`, `echo`, `resonance`, `pair` | 匹配/共鸣推荐卡或详情流 | 首页推荐卡或消息匹配卡 | P1 |
| `解锁`, `unlock`, `locked`, `paywall` | 解锁/余额不足弹窗 | 受限动作点击结果 | P1 |

## 2. 可复用交互模式

| 模式 | 命名/代码信号 | 默认交互 | 能力边界 |
|---|---|---|---|
| local_search.history | `search`, `history`, `chip`, `clear` | 本地过滤；最近搜索 chips；清除历史项/全部；无结果空态 | 真实搜索 API 需 §6 |
| article.list_detail | `read`, `article`, `story`, `grid`, `detail` | 列表/网格进入详情；静态或本地内容渲染 | CMS/API/AI 生成需 §6 |
| live_room.local_demo | `live`, `room`, `viewer`, `people`, `live_like`, `comment` | 本地视频或占位直播间；假在线数；本地评论；点赞动画 | 真实直播、在线人数、礼物、后端评论需 §6 |
| resonance.match_card | `match`, `resonance`, `echo`, `pair`, `music` | 本地推荐/配对卡；可播放本地音乐；点击进入详情或推荐流 | 真实推荐算法或跨账号持久化需 §6 |
| gated_action.unlock | `unlock`, `locked`, `coin`, `paywall` | 弹出解锁/余额弹窗；余额足够时本地解锁或扣减；不足时跳充值 | 真实扣费/IAP 需 §6 |
| ai.role_chat | `ai_portrait`, `ai_role`, `ai_chat_btn`, `ai_hot` | AI 角色列表进入本地模板聊天；余额规则按 §6 | 模型 API、计费、额度需 §6 |
| moderation.cross_screen | `report`, `block`, `blacklist`, `remove` | 本地拉黑过滤内容、聊天、推荐候选；移出黑名单刷新空态 | 后端举报/拉黑需 §6 |

## 3. 字典同步落点

| 文件 | 同步内容 |
|---|---|
| `.cursor/skills/frontend-ui-from-spec/screen-inventory-inference.md` | 搜索、直播间、阅读文章、AI、共鸣/匹配、解锁弹窗的页面/状态判断 |
| `.cursor/skills/frontend-ui-from-spec/interaction-inference.md` | 搜索历史、阅读列表/详情、直播间、本地匹配/共鸣、AI 角色聊天、解锁动作的交互推断 |
| `.cursor/skills/frontend-ui-from-spec/project-interaction-patterns.md` | 可复用按钮操作模板：Search/Reading/Match/Live、AI role card、Unlock gated action |
| `参考-原稿命名屏幕清单生成.md` | 人类可读的新增原稿命名线索 |
| `参考-切图命名交互补全.md` | qxxq 复盘新增模式 |
| `参考-项目按钮交互操作模式.md` | 搜索、阅读、直播、匹配推荐的按钮模式 |

## 4. 不沉淀为通用规则的内容

- qxxq 项目路径、工程名、Scheme、账号、商品 ID、素材编号和具体 UI 文案。
- 某个项目专属的用户关系数据、余额数值、视频/文章数量。
- 真实 Apple 登录、StoreKit、WebView、PHPicker、AVCapture、AI 计费等能力的默认开启状态。
- 将设计原稿整图作为运行时资源的任何做法。

## 5. 复盘结论

qxxq 的价值不在某个具体业务，而在一组高复用 UI 类型：搜索页、阅读列表/详情、直播间、本地推荐/匹配、AI 角色聊天和受限动作解锁。它们已经被抽象为命名线索、组件/交互模式和能力边界规则，后续项目可自动识别，但真实能力仍必须由 `架构需求.md` §6 明确授权。
