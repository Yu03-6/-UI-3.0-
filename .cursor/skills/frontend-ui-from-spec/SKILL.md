---
name: frontend-ui-from-spec
description: >-
  Implements frontend UI from 架构需求.md and design assets. Use for
  design-to-code, UI restoration, cutout/assets import, pixel checklist,
  lightweight engineering evidence, design-original-name screen inventory,
  asset-name driven component/popup/interaction blueprinting, local demo data,
  and AGENTS.md sync.
  Always use when 架构需求.md exists or the user asks to implement screens from
  a UI spec or design originals.
disable-model-invocation: false
---

# Frontend UI From Spec

## Installation Check

Cursor only loads skills from the **workspace root** `.cursor/skills/`, not from nested kit folders.

Required at project root:

```text
.cursor/skills/frontend-ui-from-spec/SKILL.md
.cursor/skills/frontend-ui-from-spec/screen-inventory-inference.md
.cursor/skills/frontend-ui-from-spec/interaction-inference.md
.cursor/skills/frontend-ui-from-spec/project-interaction-patterns.md
.cursor/rules/frontend-ui-kit-bootstrap.mdc
```

If missing, stop and tell the user:

```bash
cd 前端UI开发套件3.0交互补全版（未实验） && ./install-to-project.sh /path/to/project
./verify-kit-install.sh /path/to/project
```

## Scope And Evidence Sources

1. `架构需求.md` — project scope, capability boundaries, main routes, and explicit overrides. It does not need to list every screen or every button when design originals and naming context exist.
2. `资源导入清单.md` — source asset to runtime asset mapping plus naming-derived component, popup, state, and interaction evidence
3. `像素还原清单.md` — screen coverage, implementation status, interaction binding status, pixel QA evidence
4. `AGENTS.md` — project rules generated from the spec

Kit templates stay in the kit folder. Project root should contain filled project docs, not `*-模版.md` copies.

## First-Run Ledger Gate

On the first run in a project, or whenever `资源导入清单.md` / `像素还原清单.md` has not yet been populated for the current screens, documentation write-back is a **blocking prerequisite**, not a final cleanup step.

Before coding or editing UI files, do all of the following and write the result to disk:

1. Ensure `资源导入清单.md` and `像素还原清单.md` exist. If missing, create them from the project templates or the kit templates.
2. Scan `架构需求.md` §2 design-original and runtime asset paths.
3. Generate or repair `架构需求.md` §3 screen rows from design-original filenames.
4. Mirror those rows into `像素还原清单.md` with explicit `界面名称/状态`, `开发状态=未开始`, `交互绑定=待绑定/待确认`, and `像素验收=未验收`.
5. Scan allowed cutout/runtime assets and add rows to `资源导入清单.md` for button, entry, state, card, popup, sheet, tab, empty, background, and content-media resources, including `推断产物`, `推断交互`, `置信度`, and `绑定状态`.
6. Add or repair `架构需求.md` §4.1/§4.2/§4.3 with de-duplicated component, popup, state-button, and interaction patterns when safe.

If any required checklist/spec file cannot be written, stop and report the blocker. Do not continue with code-only implementation.

Completion is invalid unless the final response names the updated ledger files or explicitly explains why they could not be updated.

## Planning Asset Import Gate

Planning is not complete until all project-provided cutout resources have been inventoried, normalized, imported or staged into the runtime asset location, and recorded.

Before page implementation begins:

1. Recursively scan every `架构需求.md` §2 allowed cutout/export/content-media path. Do **not** scan the design-original folder as a runtime source.
2. Group all cutouts by module/page/folder, stem, state pair, density/scale, and role.
3. Import, copy, or otherwise stage the resources into the project's runtime asset system (`Assets.xcassets`, `public/`, `res/`, `assets/`, etc.) using the project’s existing convention. If the current task cannot actually copy/import a resource, mark it `未导入/待导入` and stop before page work unless the user explicitly allows a staged-only pass.
4. Write every discovered runtime-eligible resource into `资源导入清单.md`, including source path, runtime name, role, inferred product, inferred interaction, confidence, binding status, and missing/duplicate notes.
5. Write the component/popup/state-control blueprint produced from those resources into `资源导入清单.md` and `架构需求.md` §4.3.
6. Add a stage checkpoint to `架构需求.md` §7 or §10 stating that the resource planning/import stage is complete, partially complete, or blocked.
7. Page code may reference only resources that are already listed in `资源导入清单.md` as `已导入` or explicitly approved as an existing runtime asset. Unlisted external URLs, stock assets, AI-generated images, placeholder images, icon libraries, and random web/local files are forbidden unless the user first updates §2 and explicitly authorizes them.

If any page needs a resource that is not listed and imported/staged, return to this gate. Do not silently fetch, generate, draw, or substitute visuals.

## Stage Gate Order

Run the project strictly in this order. Do not skip a stage or begin a later stage while an earlier gate is incomplete.

| Stage | Required output | May proceed when |
|---|---|---|
| 0. Setup/readiness | Skill/rules loaded; `架构需求.md` readable; docs writable | verify/install blockers resolved |
| 1. Spec and screen inventory | §3 screen rows and initial `像素还原清单.md` rows written | every known original is covered or marked non-screen/deferred |
| 2. Asset planning/import | all eligible cutouts inventoried, runtime names assigned, imported/staged, and written to `资源导入清单.md` | no unlisted runtime visual resources are needed for P0 work |
| 3. Interaction/component blueprint | §4.1/§4.2/§4.3 and resource blueprint rows written | component/popup/state/button patterns are classified explicit/inferred/待确认 |
| 4. Page implementation | code uses only listed/imported resources | current screen has ledger rows and asset rows |
| 5. Evidence and verification | pixel evidence, interaction binding, build/lint/test or skip reason | all touched screens have updated ledger rows |

If a user asks to jump directly to implementation, still run stages 0-3 first and report what was written.

## Fast Workflow

1. Read `架构需求.md`; identify platform, stack, design resources, global UI rules, capability boundaries, and acceptance.
2. Apply the **First-Run Ledger Gate** before coding: create/repair and write `资源导入清单.md`, `像素还原清单.md`, and required `架构需求.md` sections first.
3. Apply the **Planning Asset Import Gate** during planning: inventory all allowed cutouts, import/stage runtime assets, and write `资源导入清单.md` before page code.
4. Follow the **Stage Gate Order**. Never skip directly from planning to later page work when prior gate outputs are missing.
5. Always read `screen-inventory-inference.md` before planning screens. Scan the design-original folder and generate/repair §3 screen inventory and `像素还原清单.md` rows from original filenames.
   Every pixel checklist row must include an explicit `界面名称/状态` aligned to §3 `页面/状态`; do not leave rows with only the original filename or status labels.
6. Always read `interaction-inference.md` and `project-interaction-patterns.md` before UI coding. Treat asset naming and similar project button patterns as first-class sources for UI/local-demo component, popup, state, and button behavior.
7. Inventory allowed cutout/runtime asset names, group state pairs and naming clusters, match Sweeli/hdxc-style button operation patterns where applicable, then produce and write a component/popup/interaction blueprint before coding a screen.
8. Reconcile `架构需求.md` §10 change log against §3, §4.2, §4.3, §6, `AGENTS.md`, `资源导入清单.md`, and `像素还原清单.md`. Backfill missing interaction/component patterns from existing code or resource-list evidence when safe.
9. Run readiness check. Report P0/P1/P2 gaps and patch the spec when safe. Missing manual §3 rows or per-button §4 text is not blocking when filenames/context give safe inferences.
10. Sync `AGENTS.md` with project constraints, capability boundaries, screen inventory inference, naming inference rules, and any real capability changes recorded in §10.
11. Implement screens in priority order, one screen/state at a time.
12. Before each screen: verify original/cutout paths, register assets, identify route/entry, build inferred components/popups/stateful controls, and bind safe inferred interactions.
13. After each screen: update `资源导入清单.md`, `像素还原清单.md`, and spec §10 when behavior was inferred.
   - `实现完成`: code, resources, constraints/layout are in place.
   - `交互已绑定`: explicit or low-risk inferred interactions are wired; unresolved actions are marked `待确认`.
   - `像素验收通过`: engineering evidence is complete.
12. Run available build/lint/test. Also run cheap source checks: no runtime original references, assets registered, layout helper used, interaction status recorded.
13. Finish with changed files, verification, pixel evidence summary, inferred screens, inferred interactions, and remaining gaps.

## Readiness Check

Do not begin implementation until these are clear enough:

- No unresolved `【】`, `TODO`, or critical placeholders for implementation.
- Design originals and runtime assets are separated.
- Screen/state inventory covers pages, variants, popups, loading/empty/error states. It may be generated from design-original filenames using `screen-inventory-inference.md`.
- Route/entry is known for P0 screens.
- Interaction policy is clear enough: §4 explicit overrides, §4.1 naming inference setting, or a safe default of naming-driven low-risk/local-demo inference.
- Global UI rules define layout scale, safe area, scrolling, fonts/colors, and popups.
- Capability table states what is UI-only vs real.
- Asset list has columns for inferred component/popup/state, inferred interaction, confidence, and binding status.
- Pixel checklist has columns for implementation status, interaction binding status, pixel QA status, and engineering evidence.
- Acceptance and change log exist.
- Existing §10 change-log rows are reflected in their declared landing sections and do not leave related §4.2/§4.3/resource/pixel/AGENTS entries as template placeholders.

If something is not applicable, write `无`.

## Implementation Rules

- Follow existing project patterns before adding abstractions.
- Do not import design originals into runtime assets or source paths.
- Runtime visuals must come from allowed cutout/export folders in `架构需求.md` §2 or existing project assets. Do not invent decorative images, icons, illustrations, textures, avatars, stickers, backgrounds, or substitute patterns.
- Code drawing is allowed only for basic UI primitives that the design implies, such as text, solid colors, simple borders, separators, shadows, rounded rectangles, skeleton blocks, and layout containers. It must not replace a missing design cutout with a self-made graphic.
- Register imported assets in `资源导入清单.md`.
- On first implementation pass, write inferred resource and pixel checklist rows before editing UI code. Do not rely on a later final sync.
- During planning, import/stage all eligible project cutouts before page code. Page implementation may only reference resources that are registered as imported or as existing runtime assets in `资源导入清单.md`.
- Do not use external image URLs, icon packs, stock photos, generated images, downloaded assets, or arbitrary local files outside §2 allowed paths. If the project truly needs a new source, stop and require the user to update §2 and approve it first.
- Generate or repair `架构需求.md` §3 from design-original filenames when the user has not manually supplied a complete screen list.
- For every inferred screen row, record priority, original file, page/state, type, implementation target, entry/trigger, and any confidence or confirmation note.
- For button/entry/state assets, record resource role, inferred component/popup/state, inferred interaction, confidence, and binding status.
- For common social/chat/publish/wallet/media/settings buttons, compare against `project-interaction-patterns.md` before marking an action `待确认`.
- Use the project layout scale/token system (`DesignMetrics`, CSS variables, theme tokens, dp/rem helpers, etc.).
- Do not add real API/auth/payment/AI/media capability unless `架构需求.md` explicitly marks it as real.
- Use asset-name inference to actively scaffold UI/local-demo components, popups, stateful controls, and common button behavior. Explicit §4/§6 rules override naming when they conflict.
- Build naming clusters as one control/component instead of isolated images: `*_on/off`, `*_normal/selected`, `*_sel`, `popup/dialog/sheet`, `card/cell/row`, `accept/reject`, and page-prefixed button groups.
- De-duplicate similar inferred interactions by pattern. Register one durable rule for the shared component/action and list its applicable pages or resource clusters; do not repeat identical rows in `架构需求.md` §4/§10 for every instance.
- If §10 says a screen, asset replacement, bug fix, or real capability changed, update the corresponding interaction rules, component blueprints, capability boundary, and delivery evidence in the same pass.
- Low-risk inferred interactions may be implemented directly: back, close, cancel, tab/filter switch, expand/collapse, local like/favorite toggle, local report/block sheet, delete confirmation for own local content, edit/profile/settings static entry.
- Medium-risk inferred interactions may be implemented as local/demo behavior when reversible and documented: follow/friend toggles, local content mutation, local upload placeholder, local sheet/detail routes, and count sync. Mark assumptions.
- High-risk inferred interactions must be recorded as `待确认` unless §6 authorizes them: account deletion, real login, Apple login, IAP/payment, AI/chat costs, audio/video calls, system permissions, backend writes, legal/compliance links.
- New user requests must be written into `架构需求.md` before code when they change scope.

## Interaction Inference Rule

For every implemented screen, scan allowed cutout folders, existing runtime assets, and nearby route/component names before coding. Do this even when §4 has a main flow, because §4 is not expected to enumerate every component or button.

Use this priority:

1. Explicit `架构需求.md` §4/§6 behavior and capability boundaries.
2. Existing app route, store, view model, or component pattern.
3. Resource name clusters and visual states (`popup`, `sheet`, `card`, `selected`, `normal`, `on`, `off`, `delete`, `report`, `follow`, etc.).
4. Conservative fallback: mark `待确认` or `不可推断`.

Write the result before or during implementation:

```markdown
| 页面/组件 | 资源名/切图名 | 推断产物 | 推断触发 | 推断结果 | 风险 | 状态 |
|---|---|---|---|---|---|---|
```

Do not silently add behavior. Every inferred action must be visible in `资源导入清单.md` and, when it changes scope, `架构需求.md` §10.

When the same interaction appears repeatedly, record it once as a pattern and put per-instance proof in `资源导入清单.md` / `像素还原清单.md`. Split into separate rows only when trigger result, ownership rule, risk level, or capability boundary differs.

If `资源导入清单.md` already contains component/popup blueprints or bound interactions while `架构需求.md` §4.2/§4.3 still contains only placeholder rows, backfill §4.2/§4.3 with de-duplicated patterns before coding further.

## Screen Inventory Inference Rule

When §3 is empty, incomplete, or conflicts with the design-original folder, scan the original filenames and generate/repair the screen list before implementation.

Use this priority:

1. Existing code routes and implemented screens.
2. Explicit screen rows already in `架构需求.md` §3.
3. Design-original filename, folder, and variant naming.
4. Similar patterns in kit cases.
5. Conservative fallback: `待确认`.

Write the result into §3:

```markdown
| 优先级 | 原稿文件 | 页面/状态 | 类型 | 对应实现 | 入口/触发 | 备注 |
|---|---|---|---|---|---|---|
```

`对应实现` may be an inferred target such as `待创建: Features/Home/HomeViewController.swift` before code exists. After implementation, update it to the real file path.

Mirror the same rows into `像素还原清单.md` before implementation:

```markdown
| 优先级 | 原稿文件 | 界面名称/状态 | 对应实现 | 开发状态 | 交互绑定 | 像素验收 | 工程证据/问题 |
|---|---|---|---|---|---|---|---|
```

The pixel checklist must name the user-facing screen/state. If the name is ambiguous, write `待确认：<filename stem>` and note why, instead of leaving `【由命名推断】` or an empty cell.

## Pixel QA Rule

Never equate code completion with pixel acceptance.

`像素验收通过` requires auditable engineering evidence in `像素还原清单.md`:

- route/entry
- implementation file
- layout/constraint/token location
- registered assets
- 3-6 key element measurements
- key interactions: asset/control, trigger, result, binding status
- exceptions or `无例外`

Screenshots, diffs, side-by-side comparison, and manual review are optional spot checks, not the default gate.

## Plan Format

```markdown
## Plan
- Stage gate: ...
- Resource import status: ...
- Screen/state: ...
  Original/cutouts: ...
  Screen inference: ...
  Route/entry: ...
  Implementation file: ...
  Assets: ...
  Inferred components/popups: ...
  Inferred interactions: ...
  Pixel evidence: ...
  Verification: ...
```

## Missing Assets

1. Report the missing path and affected screen.
2. Continue only if the UI can be implemented from allowed cutouts/existing assets plus basic UI primitives without changing the visual intent.
3. If a needed cutout/icon/illustration/background is missing, do not draw or source a replacement. Ask for the asset or explicit placeholder approval, then record the limitation in `资源导入清单.md` and `像素还原清单.md`.

## Skill Is Working When

- It starts with readiness check.
- It reads and applies `screen-inventory-inference.md` before planning screens.
- It can generate §3 screen inventory from design-original filenames instead of waiting for the user to list every screen.
- It reads and applies `interaction-inference.md` before screen implementation.
- It reads and applies `project-interaction-patterns.md` before binding buttons.
- It inventories cutout names and produces component/popup/interaction blueprinting instead of waiting for §4 to name every button.
- It imports/stages and records all eligible cutout resources during planning before page implementation.
- It refuses to skip stage gates; a later phase begins only after earlier phase outputs are written.
- It refuses runtime use of design originals.
- It refuses arbitrary self-made graphics and uses only project-provided cutouts/existing assets plus basic UI primitives.
- It updates `资源导入清单.md` and `像素还原清单.md` as screens ship, including interaction binding status.
- It separates `实现完成` from `像素验收通过`.
- It separates explicit behavior, low-risk inferred behavior, and `待确认` behavior.
- It does not claim pixel pass without engineering evidence.
