# CCPM OpenCode Migration Plan

ccpm (Claude Code PM) を OpenCode 対応させるためのマイグレーション計画書。

## 1. プロジェクト概要

### 目的
- ccpm のワークフロー（PRD→Epic→Issue→並列実行）を OpenCode で利用可能にする
- OSS として他ユーザーへ配布可能な状態にする

### 背景
ccpm は元々 Claude Code 向けに設計された PM システム。OpenCode でも同様のワークフローを実現するため、コマンド定義・エージェント・ルールを OpenCode 形式に移植する。

---

## 2. 決定事項

| 項目 | 決定内容 |
|------|----------|
| スコープ | **B案（フル）**: 全38 PMコマンド + 4エージェント + 11ルール |
| コマンド定義 | `.opencode/commands/pm-*.md` |
| エージェント定義 | `.opencode/agents/*.md` |
| PRD/Epic データ | **`.ccpm/prds/`, `.ccpm/epics/`** |
| コンテキスト | `.ccpm/context/` |
| ルールファイル | `.ccpm/rules/` |
| コマンド命名 | ハイフン区切り（例: `/pm-prd-new`） |
| 設定ファイル | `opencode.json` |

---

## 3. ディレクトリ構造（移植後）

```
プロジェクトルート/
├── .opencode/
│   ├── commands/               # コマンド定義（38本）
│   │   ├── pm-init.md
│   │   ├── pm-help.md
│   │   ├── pm-prd-new.md
│   │   ├── pm-prd-parse.md
│   │   ├── pm-prd-list.md
│   │   ├── pm-prd-edit.md
│   │   ├── pm-prd-status.md
│   │   ├── pm-epic-decompose.md
│   │   ├── pm-epic-sync.md
│   │   ├── pm-epic-oneshot.md
│   │   ├── pm-epic-list.md
│   │   ├── pm-epic-show.md
│   │   ├── pm-epic-status.md
│   │   ├── pm-epic-edit.md
│   │   ├── pm-epic-close.md
│   │   ├── pm-epic-refresh.md
│   │   ├── pm-epic-start.md
│   │   ├── pm-epic-start-worktree.md
│   │   ├── pm-epic-merge.md
│   │   ├── pm-issue-start.md
│   │   ├── pm-issue-sync.md
│   │   ├── pm-issue-show.md
│   │   ├── pm-issue-status.md
│   │   ├── pm-issue-edit.md
│   │   ├── pm-issue-close.md
│   │   ├── pm-issue-reopen.md
│   │   ├── pm-issue-analyze.md
│   │   ├── pm-next.md
│   │   ├── pm-status.md
│   │   ├── pm-standup.md
│   │   ├── pm-blocked.md
│   │   ├── pm-in-progress.md
│   │   ├── pm-sync.md
│   │   ├── pm-import.md
│   │   ├── pm-validate.md
│   │   ├── pm-clean.md
│   │   ├── pm-search.md
│   │   └── pm-test-reference-update.md
│   └── agents/                 # エージェント定義（4つ）
│       ├── code-analyzer.md
│       ├── file-analyzer.md
│       ├── test-runner.md
│       └── parallel-worker.md
├── .ccpm/                      # 作業データ
│   ├── prds/                   # PRD ファイル
│   │   └── .gitkeep
│   ├── epics/                  # Epic・タスクファイル
│   │   └── .gitkeep
│   ├── context/                # プロジェクトコンテキスト
│   │   └── README.md
│   └── rules/                  # ルールファイル（11本）
│       ├── datetime.md
│       ├── github-operations.md
│       ├── agent-coordination.md
│       ├── branch-operations.md
│       ├── frontmatter-operations.md
│       ├── path-standards.md
│       ├── standard-patterns.md
│       ├── strip-frontmatter.md
│       ├── test-execution.md
│       ├── use-ast-grep.md
│       └── worktree-operations.md
├── scripts/                    # 補助スクリプト
│   └── pm/
│       └── init.sh
├── opencode.json               # OpenCode 設定
├── AGENTS.md                   # プロジェクトルール
├── README.md                   # インストール・使い方
└── docs/
    ├── opencode-migration-plan.md  # この計画書
    ├── commands.md                  # コマンドリファレンス
    └── migration-from-claude-code.md # Claude Code からの移行ガイド
```

---

## 4. WBS 詳細

### Phase 0: 準備（6-10時間） - COMPLETE
- [x] 移植対象の最終確認
- [x] コマンド変換ルールの確定
- [x] frontmatter マッピング表の作成

### Phase 1: 基盤構築（6-10時間） - COMPLETE
- [x] `.opencode/` ディレクトリ構造作成
- [x] `.ccpm/` ディレクトリ構造作成
- [x] `opencode.json` 作成（instructions, agents 設定）
- [x] `AGENTS.md` の更新

### Phase 2: コマンド移植（30-50時間） - COMPLETE
- [x] PRD コマンド移植（5本）
  - [x] pm-prd-new
  - [x] pm-prd-parse
  - [x] pm-prd-list
  - [x] pm-prd-edit
  - [x] pm-prd-status
- [x] Epic コマンド移植（12本）
  - [x] pm-epic-decompose
  - [x] pm-epic-sync
  - [x] pm-epic-oneshot
  - [x] pm-epic-list
  - [x] pm-epic-show
  - [x] pm-epic-status
  - [x] pm-epic-edit
  - [x] pm-epic-close
  - [x] pm-epic-refresh
  - [x] pm-epic-start
  - [x] pm-epic-start-worktree
  - [x] pm-epic-merge
- [x] Issue コマンド移植（8本）
  - [x] pm-issue-start
  - [x] pm-issue-sync
  - [x] pm-issue-show
  - [x] pm-issue-status
  - [x] pm-issue-edit
  - [x] pm-issue-close
  - [x] pm-issue-reopen
  - [x] pm-issue-analyze
- [x] Workflow コマンド移植（5本）
  - [x] pm-next
  - [x] pm-status
  - [x] pm-standup
  - [x] pm-blocked
  - [x] pm-in-progress
- [x] Sync コマンド移植（2本）
  - [x] pm-sync
  - [x] pm-import
- [x] Maintenance コマンド移植（4本）
  - [x] pm-validate
  - [x] pm-clean
  - [x] pm-search
  - [x] pm-test-reference-update
- [x] Setup コマンド移植（2本）
  - [x] pm-init
  - [x] pm-help

### Phase 3: エージェント移植（4-8時間） - COMPLETE
- [x] code-analyzer.md
- [x] file-analyzer.md
- [x] test-runner.md
- [x] parallel-worker.md

### Phase 4: ルール移植（6-10時間） - COMPLETE
- [x] datetime.md
- [x] github-operations.md
- [x] agent-coordination.md
- [x] branch-operations.md
- [x] frontmatter-operations.md
- [x] path-standards.md
- [x] standard-patterns.md
- [x] strip-frontmatter.md
- [x] test-execution.md
- [x] use-ast-grep.md
- [x] worktree-operations.md
- [x] opencode.json の instructions に追加

### Phase 5: スクリプト対応（6-10時間） - COMPLETE
- [x] init.sh を `.ccpm/` パス対応に更新
- [x] 他の補助スクリプトの移植・更新

### Phase 6: ドキュメント（8-12時間） - COMPLETE
- [x] README.md 更新
- [x] docs/commands.md 作成
- [x] docs/migration-from-claude-code.md 作成
- [x] インストールスクリプト作成

### Phase 7: 配布準備（8-12時間） - COMPLETE
- [x] インストールスクリプト（curl | bash）
  - [x] ccpm.sh（新規プロジェクト用）
  - [x] add-ccpm.sh（既存プロジェクト追加用）
  - [x] ccpm.bat（Windows用）
- [x] install/README.md 更新
- [x] README.md の URL 更新
- [ ] サンプルプロジェクト作成 → スキップ（不要と判断）
- [ ] GitHub リポジトリ設定 → リリース後に実施

### Phase 8: QA（8-14時間）
- [ ] PRD → Epic → Issue の一連フロー検証
- [ ] 並列エージェント動作確認
- [ ] GitHub 同期検証
- [ ] エラーハンドリング確認

### 合計工数
**82-136時間（約10-17人日）**

---

## 5. コマンド変換ルール

### Frontmatter マッピング

| ccpm（現在） | OpenCode（変換後） |
|-------------|-------------------|
| `allowed-tools: Bash, Read, Write, LS` | 削除（OpenCode では tools はエージェント側で制御） |
| なし | `description: コマンドの説明` |
| なし | `agent: build` または `plan`（必要に応じて） |
| なし | `model: anthropic/claude-sonnet-4-5`（必要に応じて） |

### 変換例

**ccpm（変換前）**:
```markdown
---
allowed-tools: Bash, Read, Write, LS
---

# PRD New

Launch brainstorming for new product requirement document.

## Usage
/pm:prd-new <feature_name>

## Required Rules
...
```

**OpenCode（変換後）**:
```markdown
---
description: Create a new PRD through guided brainstorming
agent: plan
---

You are a product manager creating a comprehensive PRD for: $ARGUMENTS

Before starting, read the datetime rule: @.ccpm/rules/datetime.md

## Preflight Checks
1. Validate feature name format (kebab-case)
2. Check if `.ccpm/prds/$ARGUMENTS.md` already exists
3. Create `.ccpm/prds/` directory if needed

## Instructions
[... 詳細な手順 ...]

## Output
Save to: `.ccpm/prds/$ARGUMENTS.md`

After creation:
- Confirm: "PRD created: .ccpm/prds/$ARGUMENTS.md"
- Suggest: "Run: /pm-prd-parse $ARGUMENTS"
```

### パス置換ルール

| 変換前 | 変換後 |
|--------|--------|
| `.claude/prds/` | `.ccpm/prds/` |
| `.claude/epics/` | `.ccpm/epics/` |
| `.claude/context/` | `.ccpm/context/` |
| `.claude/rules/` | `.ccpm/rules/` |
| `/pm:*` | `/pm-*` |

### 特殊記法の活用

| 機能 | OpenCode 記法 | 用途 |
|------|--------------|------|
| 引数 | `$ARGUMENTS`, `$1`, `$2` | コマンド引数の取得 |
| ファイル参照 | `@path/to/file` | ファイル内容を自動読み込み |
| シェル出力 | `` !`command` `` | コマンド実行結果をテンプレートに注入 |

---

## 6. リスクと対策

| リスク | 影響度 | 対策 |
|--------|--------|------|
| パス参照の置換漏れ | 高 | 移植時にチェックリスト、grep で `.claude/` 残存確認 |
| `$ARGUMENTS` の挙動差異 | 中 | Phase 1 で早期検証 |
| シェル出力（`!`）の副作用 | 中 | 副作用のあるコマンドは明示的手順に変更 |
| gh-sub-issue 依存 | 中 | フォールバック手順をドキュメント化 |
| 並列エージェントの互換性 | 高 | OpenCode の subagent 仕様に合わせて調整 |

---

## 7. 次のアクション

### 推奨進行順序

1. **Phase 1: MVP 検証（1-2日）**
   - 基盤構築（.opencode/, .ccpm/, opencode.json）
   - コア4コマンドを先行移植
     - pm-prd-new
     - pm-prd-parse
     - pm-epic-oneshot
     - pm-issue-start
   - 実際に動くか検証

2. **Phase 2: フル移植（3-5日）**
   - 残り34コマンドを移植
   - エージェント・ルール移植
   - スクリプト更新

3. **Phase 3: 配布準備（1-2日）**
   - ドキュメント整備
   - インストールスクリプト
   - 最終QA

---

## 8. 参考リンク

- [OpenCode ドキュメント](https://opencode.ai/docs)
- [OpenCode Commands](https://opencode.ai/docs/commands)
- [OpenCode Agents](https://opencode.ai/docs/agents)
- [OpenCode Rules](https://opencode.ai/docs/rules)
- [OpenCode Config](https://opencode.ai/docs/config)
- [ccpm オリジナル README](../README.md)

---

## 更新履歴

| 日付 | 内容 |
|------|------|
| 2026-01-20 | 初版作成 |
