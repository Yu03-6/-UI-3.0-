# 资源导入清单【案例：hdxc】

> 本案例按 `资源导入清单-模版.md` 口径整理自 `/Users/Admin/Desktop/hdxc/资源导入清单.md` 与实际工程资源。设计原稿仅参考；运行时图像只来自 `项目设计图/设计图细节切图`、`现场活动社交资料` 或现有 Assets。

## 命名规则

- 英文小写、数字、下划线；同一全局资源只导入一次。
- 状态资源按 stem 聚类，例如 `tab_notes_off/on`、`like_off/on`、`call_mic_on/off`。
- 运行时图像不得来自 `设计图原稿`，不得自制替代图案。
- 规划阶段已递归扫描 `/项目设计图/设计图细节切图` 和 `/项目设计图/现场活动社交资料`，运行时资源导入/暂存到 `hdxc/Assets.xcassets` 后再进入页面实现。
- 页面代码只能引用本清单中 `已导入=是` 或现有工程资源的条目；禁止外部图片 URL、图标包、图库素材、AI 生成图、下载素材或非 §2 路径文件。

## 阶段门禁记录

| 阶段 | 状态 | 证据 | 阻塞/例外 |
|---|---|---|---|
| 资源扫描 | 完成 | 已覆盖设计细节切图、全局切图、现场活动社交资料 | 无 |
| 运行时命名 | 完成 | 英文小写/下划线；同 stem 状态资源聚类 | 无 |
| 导入/暂存 | 完成 | `hdxc/Assets.xcassets`，另有导入脚本 `tools/import_assets.sh` | 无 |
| 组件/交互蓝图 | 完成 | 下方组件/弹窗蓝图与 §4.2/§4.3 对齐 | 无 |

## 导入清单

| 模块/页面 | 原文件名 | 运行时资源名 | 资源角色 | 推断产物 | 来源目录 | 已导入 | 推断交互 | 置信度 | 绑定状态 | 备注 |
|---|---|---|---|---|---|---|---|---|---|---|
| 全局 | 全局背景图.png | `global_bg` | 背景 | 页面背景 | 全局切图 | 是 | 无 | 高 | 无需绑定 | `TPChrome` 全 app 背景 |
| 全局 | 全局后退按钮.png | `icon_back` | 按钮 | 返回按钮 | 全局切图 | 是 | 点击返回 | 高 | 已绑定 | 自定义 nav |
| 全局 | 弹窗UI.png | `dialog_bg` | 背景 | 弹窗壳 | 全局弹窗UI | 是 | 展示弹窗 | 高 | 已绑定 | `AppDialog` |
| 全局 | 弹窗确认/取消按钮.png | `dialog_confirm` / `dialog_cancel` | 按钮 | 弹窗按钮 | 全局弹窗UI | 是 | 确认/取消/关闭 | 高 | 已绑定 | 自绘业务弹窗 |
| 全局导航 | 导航栏背景框.png | `tabbar_bg` | 背景 | TabBar 壳 | 全局导航栏 | 是 | Tab 切换容器 | 高 | 已绑定 | `CustomTabBarView` |
| 全局导航 | Notes1/Notes2 等 | `tab_notes_off/on`, `tab_explore_off/on`, `tab_chat_off/on`, `tab_me_off/on` | 状态图 | Tab 状态按钮 | 全局导航栏 | 是 | 切换主 Tab | 高 | 已绑定 | on/off 聚类 |
| 启动 | 启动页背景图.png | `launch_bg` | 背景 | 启动页背景 | 切图根 | 是 | 无 | 高 | 无需绑定 | LaunchScreen |
| 登录选择页 | Sign with Apple按钮.png | `btn_apple` | 按钮 | Apple 登录按钮 | 登录选择页 | 是 | 发起 Apple 登录 | 高 | 已绑定 | §6 真实 |
| 登录选择页 | Create acount按钮.png | `btn_create_account` | 按钮 | 注册入口 | 登录选择页 | 是 | Push 注册 | 高 | 已绑定 | 图片按钮按比例 |
| 登录选择页 | Sign in按钮.png | `btn_sign_in` | 按钮 | 登录入口 | 登录选择页 | 是 | Push 登录 | 高 | 已绑定 | 图片按钮按比例 |
| 登录/注册 | 邮箱/密码/眼睛图标 | `icon_mail`, `icon_lock`, `icon_eye_on/off` | 图标/按钮 | 输入字段/密码状态 | 登录、注册 | 是 | 切换密码可见 | 高 | 已绑定 | AuthField |
| 注册资料 | 头像选择框/相册选择按钮 | `avatar_picker`, `icon_avatar_edit` | 占位/按钮 | 头像选择组件 | 登录、注册 | 是 | PHPicker 选头像 | 高 | 已绑定 | §6 真实 PHPicker |
| 首页 | 首页顶部右侧笔记发布按钮.png | `btn_publish_note` | 按钮 | 发布入口 | 首页 | 是 | Push 发布笔记 | 高 | 已绑定 | Home |
| 笔记卡片 | 卡片内右上角拉黑举报按钮.png | `card_more` | 按钮 | 更多/举报拉黑 | 笔记卡片样式 | 是 | Present ReportBlock | 高 | 已绑定 | 非本人 |
| 笔记卡片 | 已点赞/未点赞状态.png | `like_on` / `like_off` | 状态图 | 点赞按钮 | 笔记卡片样式 | 是 | 本地点赞切换 | 高 | 已绑定 | 动画+计数 |
| 发布笔记 | 发布页相册选择框.png | `photo_picker_box` | 占位/按钮 | 图片选择组件 | 发布笔记 | 是 | PHPicker 多选 | 高 | 已绑定 | 必选图片 |
| 发布笔记 | 照片右上角删除按钮.png | `photo_delete` | 按钮 | 删除已选图 | 发布笔记 | 是 | 移除预览 | 高 | 已绑定 | 本地 |
| 发布笔记 | emo1..6.png | `mood_1..6` | 状态图 | Mood 选择 | 发布笔记 | 是 | 选择 mood | 中 | 已绑定 | 本地状态 |
| 探索 | AI聊天按钮.png | `explore_buddy_banner` | 按钮/横幅 | AI 入口 | 探索 | 是 | Push AI 聊天 | 高 | 已绑定 | 5 免费/8 金币 |
| 探索 | 视频发布按钮.png | `btn_publish_video` | 按钮 | 发布视频入口 | 探索 | 是 | Push 发布视频 | 高 | 已绑定 | |
| 视频卡片 | 播放/点赞/举报 | `icon_play`, `video_like_on/off`, `video_card_more` | 图标/按钮 | 视频卡组件 | 发布视频卡片样式 | 是 | 播放/点赞/更多 | 高 | 已绑定 | 本人显示 delete |
| 举报拉黑 | 举报按钮.png / 拉黑按钮.png | `icon_report` / `icon_block` | 按钮 | ReportBlock sheet 项 | 举报拉黑 | 是 | Report / Block | 高 | 已绑定 | Bottom sheet |
| AI | Ai聊天顶部图片.png | `ai_header` | 图片 | AI header | Ai聊天 | 是 | 顶部信息 | 高 | 无需绑定 | |
| 发布视频 | 发布视频页的视频选择框.png | `video_picker_box` | 占位/按钮 | 视频选择组件 | 切图根 | 是 | PHPicker 视频 | 高 | 已绑定 | |
| 消息 | 好友申请按钮/我的好友按钮 | `btn_friend_request` / `btn_my_friend` | 按钮 | Chat 入口 | 消息 | 是 | Push 申请/好友列表 | 高 | 已绑定 | |
| 消息 | 删除全部/删除/在线状态 | `icon_clear_all`, `icon_delete`, `icon_online` | 按钮/状态 | 会话管理 | 消息 | 是 | 清空/滑删/在线点 | 高 | 已绑定 | |
| 聊天 | 视频聊天按钮 | `btn_video_chat` | 按钮 | 视频聊天入口 | 聊天 | 是 | Push 视频通话 | 高 | 已绑定 | |
| 聊天 | 发送/相册按钮 | `icon_send`, `icon_input_album` | 按钮 | 输入栏 | 全局切图 | 是 | 发送/相册 | 高 | 已绑定/待确认 | 相册按 §6 |
| 视频通话 | 麦克风/扬声器/翻转/结束 | `call_mic_on/off`, `call_speaker_on/off`, `call_flip`, `call_end` | 状态/按钮 | 通话控制条 | 视频 | 是 | 切换/翻转/结束 | 高 | 已绑定但受限 | 无 RTC |
| 好友申请 | 同意/拒绝按钮 | `btn_accept`, `btn_reject` | 按钮 | 好友申请行 | 好友申请 | 是 | 接受/拒绝 | 高 | 已绑定 | |
| 个人中心 | 设置/余额/头像编辑/卡片删除 | `btn_settings`, `coin_card_bg`, `me_avatar_edit`, `me_card_delete` | 按钮/背景 | Me header/卡片操作 | 个人中心 | 是 | 设置/充值/编辑/删除 | 高 | 已绑定 | |
| 修改资料 | 背景图默认框/头像框/编辑 | `edit_cover_box`, `edit_avatar_box`, `edit_avatar_pencil` | 占位/按钮 | 资料编辑组件 | 修改资料 | 是 | PHPicker 选封面/头像 | 高 | 已绑定 | |
| 黑名单 | 黑名单移除按钮.png | `btn_remove` | 按钮 | 黑名单行操作 | 切图根 | 是 | Unblock | 高 | 已绑定 | |
| 充值 | 充值页余额图标.png | `icon_coin_star` | 图标 | 余额图标 | 切图根 | 是 | 无 | 高 | 无需绑定 | StoreKit 列表代码绘制 |
| 演示内容 | 头像/照片/视频 | `demo_avatar_*`, `event_photo_*`, `demo_video_*` | 内容媒体 | 演示内容 | 现场活动社交资料 | 是 | 内容展示/播放 | 高 | 已绑定 | 非设计原稿 |

## 组件/弹窗蓝图

| 模块/页面 | 命名资源簇 | 推断产物 | 默认动作/状态 | 风险 | 实现状态 | 备注 |
|---|---|---|---|---|---|---|
| 全局 | `dialog_bg + dialog_confirm/cancel` | 自绘弹窗 | 确认/取消/关闭 | 中 | 已实现 | `AppDialog` |
| 全局 | `tab_*_off/on + tabbar_bg` | 自绘 TabBar | 切换选中态 | 低 | 已实现 | `CustomTabBarView` |
| Auth | `btn_apple/create/sign_in` | 登录选择按钮组 | Apple/注册/登录 | 高 | 已实现 | Apple 真实 |
| 内容 | `like_on/off + card_more + me_card_delete` | 内容卡操作区 | 点赞/举报拉黑/删除 | 中 | 已实现 | 所有权拆分 |
| 聊天 | `icon_send + icon_input_album` | 输入栏 | 发送/选相册 | 中/高 | 已实现 | 键盘避让 |
| 通话 | `call_*` | 通话控制条 | mic/speaker/flip/end | 高 | 已实现 | 无 RTC |

## 检查项

- [x] 未导入设计原稿整图。
- [x] 未自行绘制或生成替代图案、替代图标、替代插画、替代背景。
- [x] 所有运行时图像均来自 §2 可用切图、内容素材或现有 Assets。
- [x] 规划阶段已完成全部 §2 可用切图/内容素材扫描、命名、导入/暂存和登记。
- [x] 页面代码只引用本清单中 `已导入=是` 或现有工程资源的资源。
- [x] 未使用外部图片 URL、图标包、图库素材、AI 生成图、下载素材或非 §2 路径文件。
- [x] 按钮/入口/状态/弹窗/卡片类资源已填写推断产物、推断交互和绑定状态。
- [x] 同 stem 状态资源已聚类。
- [x] 高风险能力没有仅凭资源名接入，均在 §6 登记。
