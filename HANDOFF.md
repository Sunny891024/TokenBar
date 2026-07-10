# TokenBar Handoff

## 目标与验收标准

当前项目位于 `/Users/sunny/本地文件/TokenBar`，GitHub 仓库为
`https://github.com/Sunny891024/TokenBar`。

本轮目标：

- 将本地 TokenBar 项目创建为 GitHub 仓库并推送。
- 清理应用和仓库当前文件中的 CodexBar、旧官网、旧作者展示及 fork/upstream 文档。
- README 增加中文说明。
- 菜单弹窗直接显示版本号，方便截图和调试。
- 删除菜单弹窗中的“额度”错误区块及“关于 TokenBar”入口。
- 保持本地最新应用可运行，并让 `main` 与 `origin/main` 同步。

验收标准：

- 菜单底部显示 `TokenBar 0.30.1 (72)`。
- 菜单不显示“额度”区块、购买额度入口或“关于 TokenBar”。
- “费用”“订阅使用率”“刷新”“设置”“退出”等其他菜单内容继续存在。
- SwiftFormat/SwiftLint 和菜单相关测试通过。
- 本地 `TokenBar.app` 运行，Git 工作区干净。

## 当前状态

- 分支：`main`
- 远程：`origin` -> `git@github.com:Sunny891024/TokenBar.git`
- 当前版本：`0.30.1 (72)`
- 最新提交：`16033e4 Remove credits and about menu entries`
- `main` 已推送并与 `origin/main` 同步。
- 本地运行路径：`/Users/sunny/本地文件/TokenBar/TokenBar.app`
- 交接文档创建前，工作区无未提交改动。

## 已完成改动

### GitHub 与仓库

- 创建并推送 `Sunny891024/TokenBar`。
- 初始代码、CI 格式修复和后续 UI 改动均已推送。
- 删除 `.github/workflows/upstream-monitor.yml`。
- 删除 fork/upstream 说明文档及 `docs/CNAME`。
- README release 链接改为当前 GitHub 仓库，并增加中文项目说明。

### 品牌与关于页清理

- About 页面移除旧作者、旧官网、Twitter、邮箱和旧 slogan。
- GitHub 链接改为 `Sunny891024/TokenBar`。
- 当前文件中已清理 `CodexBar`、`tokenbar.app`、旧 slogan 和旧仓库链接。
- 保留 MIT `LICENSE` 中的原版权信息及 SwiftPM 真实依赖 URL；这些属于法律和依赖来源信息。

### 菜单 UI

- 菜单 meta section 增加版本文本：`TokenBar <version> (<build>)`。
- 删除菜单的“关于 TokenBar”操作项。
- 删除菜单卡片的 credits/额度渲染分支，包括错误文本、额度历史入口和购买额度入口。
- 保留费用、订阅使用率、状态页、设置、刷新和退出等其他功能。

### 本地构建

- 已多次使用 ad-hoc 签名重新打包 `TokenBar.app` 并启动。
- 当前运行版本为 `0.30.1 (72)`。
- 正式发布签名不再硬编码旧作者证书；`Scripts/sign-and-notarize.sh` 需要通过
  `APP_IDENTITY` 环境变量提供 Developer ID。

## 关键提交

- `35deb21` Initial TokenBar - forked and renamed from CodexBar
- `7975d18` Keep merged status item visible
- `2262814` Format sources for CI
- `9d3e95d` Add Chinese README summary
- `9e87dce` Clean project attribution
- `230182c` Show app version in menu
- `16033e4` Remove credits and about menu entries

## 关键文件

- `Sources/TokenBar/MenuDescriptor.swift`
  - 版本号文本及底部菜单操作。
- `Sources/TokenBar/StatusItemController+Menu.swift`
  - 菜单卡片分区；credits/额度区块已从菜单构建中删除。
- `Sources/TokenBar/PreferencesAboutPane.swift`
  - 设置窗口的 About 页面。
- `Sources/TokenBar/About.swift`
  - 标准 macOS About panel。
- `Tests/TokenBarTests/StatusMenuTests.swift`
  - 菜单内容和 credits 隐藏测试。
- `Tests/TokenBarTests/StatusMenuPersistentRefreshTests.swift`
  - 底部稳定操作行测试。
- `README.md`
  - 英文项目介绍和中文说明。

## 已验证

最近一次验证：

```bash
./Scripts/lint.sh lint
swift test --filter StatusMenuTests --filter StatusMenuPersistentRefreshTests
```

结果：

- SwiftFormat/SwiftLint：通过，0 violations。
- 菜单测试：44 个测试通过。
- 本地 `TokenBar.app` 已重新打包并启动。

常用本地重启：

```bash
pkill -x TokenBar || pkill -f TokenBar.app || true
cd /Users/sunny/本地文件/TokenBar
open -n /Users/sunny/本地文件/TokenBar/TokenBar.app
```

## 已知问题与风险

- `dist/TokenBar-macos-arm64-0.30.1.zip` 和 `.dmg` 是较早生成的 ad-hoc 包，早于最近的版本号菜单和红框删除改动；分发前必须重新生成。
- 这些本地包没有 Developer ID 正式签名和 Apple notarization，不适合作为正式公开发行包。
- Git 历史中的初始提交 `35deb21` 仍含 `forked and renamed from CodexBar`。当前文件清理不会删除 Git 历史；若要从 GitHub 历史中移除，需要明确授权后重写历史并 force push。
- `LICENSE` 仍保留原 MIT 版权。这是有意保留的法律归属信息，不建议删除。
- GitHub Actions 的最终最新状态本轮没有重新核验；此前一次 CI 曾因格式问题失败，后续格式修复已推送。

## 下一步建议

新窗口可先执行：

```bash
cd /Users/sunny/本地文件/TokenBar
git status --short --branch
git log -3 --oneline
```

如准备对外发布：

1. 决定是否提升 `MARKETING_VERSION` 和 `BUILD_NUMBER`。
2. 重新生成包含最新 UI 改动的 zip/dmg。
3. 配置自己的 Developer ID、App Store Connect 和 Sparkle 密钥。
4. 运行正式签名、notarization、appcast 和 GitHub Release 流程。
5. 核验 GitHub Actions 和 release assets。

建议新窗口开场语：

> 请先阅读 `/Users/sunny/本地文件/TokenBar/HANDOFF.md`，继续处理 TokenBar。先核对 Git 状态和当前运行版本，再按文档的下一步执行。
