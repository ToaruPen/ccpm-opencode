# CCPM - Claude Code プロジェクト管理

**OpenCode エディション**

[![MIT License](https://img.shields.io/badge/License-MIT-28a745)](LICENSE)

### PRD、GitHub Issues、Git Worktree、並列AIエージェントを使用した仕様駆動開発ワークフロー

コンテキストを失わない。タスクでブロックされない。バグを出荷しない。この実戦テスト済みシステムは、PRDをエピックに、エピックをGitHub Issuesに、IssuesをProductionコードに変換します - 各ステップで完全なトレーサビリティを維持。

## 目次

- [背景](#背景)
- [ワークフロー](#ワークフロー)
- [他との違い](#他との違い)
- [システムアーキテクチャ](#システムアーキテクチャ)
- [クイックスタート](#クイックスタート)
- [コマンドリファレンス](#コマンドリファレンス)
- [ワークフローフェーズ](#ワークフローフェーズ)
- [並列実行システム](#並列実行システム)
- [主要機能](#主要機能)
- [Claude Codeからの移行](#claude-codeからの移行)

## 背景

すべてのチームが同じ問題に直面しています：
- **セッション間でコンテキストが消失**し、常に再発見を強いられる
- **複数の開発者が同じコードに触れると並列作業が競合**を起こす
- **要件がドリフト**し、口頭の決定が書面の仕様を上書きする
- **進捗が最後まで見えない**

このシステムはそのすべてを解決します。

## ワークフロー

```mermaid
graph LR
    A[PRD作成] --> B[エピック計画]
    B --> C[タスク分解]
    C --> D[GitHub同期]
    D --> E[並列実行]
```

### 実際の動作（60秒）

```bash
# ガイド付きブレインストーミングで包括的なPRDを作成
/pm-prd-new memory-system

# PRDを技術エピックとタスク分解に変換
/pm-prd-parse memory-system

# GitHubにプッシュして並列実行を開始
/pm-epic-oneshot memory-system
/pm-issue-start 1235
```

## 他との違い

| 従来の開発 | CCPMシステム |
|-----------|-------------|
| セッション間でコンテキスト消失 | **すべての作業で永続的なコンテキスト** |
| 直列タスク実行 | **独立タスクで並列エージェント** |
| 記憶から"雰囲気コーディング" | **完全トレーサビリティの仕様駆動** |
| 進捗がブランチに隠れる | **GitHubで透明な監査証跡** |
| 手動タスク調整 | **`/pm-next`で知的優先順位付け** |

## システムアーキテクチャ

```
project-root/
├── .opencode/
│   ├── commands/           # コマンド定義（38個のPMコマンド）
│   │   ├── pm-init.md
│   │   ├── pm-prd-new.md
│   │   ├── pm-epic-*.md
│   │   └── ...
│   └── agents/             # 専門エージェント（4つ）
│       ├── code-analyzer.md
│       ├── file-analyzer.md
│       ├── test-runner.md
│       └── parallel-worker.md
├── .ccpm/
│   ├── prds/               # プロダクト要件ドキュメント
│   ├── epics/              # エピックとタスクファイル
│   │   └── [epic-name]/
│   │       ├── epic.md     # 実装計画
│   │       ├── [#].md      # 個別タスクファイル
│   │       └── updates/    # 進行中の更新
│   ├── context/            # プロジェクト全体のコンテキスト
│   └── rules/              # 運用ルール（11個）
├── scripts/
│   └── pm/                 # 自動化用シェルスクリプト
├── opencode.json           # OpenCode設定
└── AGENTS.md               # プロジェクト指示
```

## クイックスタート

### インストール（2分）

1. **CCPMをプロジェクトにインストール**:
   ```bash
   # オプション1: 既存プロジェクトに追加（推奨）
   cd your-project
   curl -fsSL https://raw.githubusercontent.com/ToaruPen/CCPM-OpenCode/main/install/add-ccpm.sh | bash
   
   # オプション2: 新規プロジェクト（フルインストール）
   mkdir my-project && cd my-project
   curl -fsSL https://raw.githubusercontent.com/ToaruPen/CCPM-OpenCode/main/install/ccpm.sh | bash
   
   # オプション3: 手動クローン＆コピー
   git clone https://github.com/ToaruPen/CCPM-OpenCode.git /tmp/ccpm
   cp -r /tmp/ccpm/.opencode /tmp/ccpm/.ccpm /tmp/ccpm/scripts .
   cp /tmp/ccpm/opencode.json /tmp/ccpm/AGENTS.md .
   rm -rf /tmp/ccpm
   ```

2. **PMシステムを初期化**:
   ```bash
   /pm-init
   ```
   これにより：
   - GitHub CLI をインストール（必要な場合）
   - GitHubで認証
   - gh-sub-issue拡張をインストール
   - 必要なディレクトリを作成
   - GitHubラベルを設定

3. **最初のPRDを作成**:
   ```bash
   /pm-prd-new your-feature-name
   ```

## コマンドリファレンス

`/pm-help` と入力すると簡潔なコマンド概要が表示されます。

### セットアップコマンド
| コマンド | 説明 |
|---------|------|
| `/pm-init` | 依存関係のインストールとGitHub設定 |
| `/pm-help` | コマンドヘルプを表示 |

### PRDコマンド
| コマンド | 説明 |
|---------|------|
| `/pm-prd-new <name>` | 新しいPRDのブレインストーミングを開始 |
| `/pm-prd-parse <name>` | PRDを実装エピックに変換 |
| `/pm-prd-list` | すべてのPRDを一覧表示 |
| `/pm-prd-edit <name>` | 既存のPRDを編集 |
| `/pm-prd-status` | PRD実装状況を表示 |

### エピックコマンド
| コマンド | 説明 |
|---------|------|
| `/pm-epic-decompose <name>` | エピックをタスクファイルに分解 |
| `/pm-epic-sync <name>` | エピックとタスクをGitHubにプッシュ |
| `/pm-epic-oneshot <name>` | 分解と同期を1コマンドで実行 |
| `/pm-epic-list` | すべてのエピックを一覧表示 |
| `/pm-epic-show <name>` | エピックとそのタスクを表示 |
| `/pm-epic-status [name]` | エピックの進捗を表示 |
| `/pm-epic-close <name>` | エピックを完了としてマーク |
| `/pm-epic-start <name>` | 並列エージェント実行を開始 |
| `/pm-epic-merge <name>` | 完了したエピックをマージ |

### Issueコマンド
| コマンド | 説明 |
|---------|------|
| `/pm-issue-start <num>` | 専門エージェントで作業を開始 |
| `/pm-issue-show <num>` | Issueとサブissueを表示 |
| `/pm-issue-status <num>` | Issueステータスを確認 |
| `/pm-issue-sync <num>` | 更新をGitHubにプッシュ |
| `/pm-issue-close <num>` | Issueを完了としてマーク |
| `/pm-issue-analyze <num>` | 並列作業ストリームを分析 |

### ワークフローコマンド
| コマンド | 説明 |
|---------|------|
| `/pm-next` | 次の優先タスクを表示 |
| `/pm-status` | プロジェクト全体のダッシュボード |
| `/pm-standup` | デイリースタンドアップレポート |
| `/pm-blocked` | ブロックされたタスクを表示 |
| `/pm-in-progress` | 進行中の作業を一覧表示 |

### 同期コマンド
| コマンド | 説明 |
|---------|------|
| `/pm-sync` | GitHubとの完全な双方向同期 |
| `/pm-import <issue>` | 既存のGitHub Issuesをインポート |

### メンテナンスコマンド
| コマンド | 説明 |
|---------|------|
| `/pm-validate` | システム整合性をチェック |
| `/pm-clean` | 完了した作業をアーカイブ |
| `/pm-search <query>` | すべてのコンテンツを検索 |

## ワークフローフェーズ

### 1. プロダクト計画フェーズ

```bash
/pm-prd-new feature-name
```
プロダクト要件ドキュメントを作成するための包括的なブレインストーミングを開始。

**出力:** `.ccpm/prds/feature-name.md`

### 2. 実装計画フェーズ

```bash
/pm-prd-parse feature-name
```
PRDを技術実装計画に変換。

**出力:** `.ccpm/epics/feature-name/epic.md`

### 3. タスク分解フェーズ

```bash
/pm-epic-decompose feature-name
```
エピックを具体的で実行可能なタスクに分解。

**出力:** `.ccpm/epics/feature-name/[task].md`

### 4. GitHub同期

```bash
/pm-epic-sync feature-name
# または自信のあるワークフロー用：
/pm-epic-oneshot feature-name
```
エピックとタスクをGitHub Issuesとしてプッシュ。

### 5. 実行フェーズ

```bash
/pm-issue-start 1234  # 専門エージェントを起動
/pm-issue-sync 1234   # 進捗更新をプッシュ
/pm-next              # 次の優先タスクを取得
```

## 並列実行システム

### Issueはアトミックではない

単一の「ユーザー認証を実装」Issueは、複数のエージェントで作業できます：

- **エージェント1**: データベーステーブルとマイグレーション
- **エージェント2**: サービスレイヤーとビジネスロジック
- **エージェント3**: APIエンドポイントとミドルウェア
- **エージェント4**: UIコンポーネントとフォーム
- **エージェント5**: テストスイートとドキュメント

すべてが同じWorktreeで**同時に**実行。

### コマンドフロー

```bash
# 並列化できるものを分析
/pm-issue-analyze 1234

# スウォームを起動
/pm-epic-start memory-system

# 魔法を観察
# 3つのIssueで12のエージェントが作業

# 完了時に1回のクリーンマージ
/pm-epic-merge memory-system
```

## 主要機能

### コンテキスト保存
プロジェクト状態を二度と失わない。各エピックは独自のコンテキストを維持し、エージェントは `.ccpm/context/` から読み取り、同期前にローカルで更新。

### 並列実行
複数のエージェントが同時に作業することで高速化。`parallel: true` とマークされたタスクで競合のない並行開発が可能。

### GitHubネイティブ
チームがすでに使用しているツールと連携。Issuesが真実の源、コメントが履歴を提供。

### エージェント専門化
あらゆる作業に適切なツール。分析、テスト、並列調整用の異なるエージェント。

### 完全なトレーサビリティ
すべての決定が文書化される。PRD -> エピック -> タスク -> Issue -> コード -> コミット。

## Claude Codeからの移行

オリジナルのClaude Codeバージョンから移行する場合：

| オリジナル | OpenCode |
|-----------|----------|
| `.claude/prds/` | `.ccpm/prds/` |
| `.claude/epics/` | `.ccpm/epics/` |
| `.claude/commands/pm/` | `.opencode/commands/` |
| `.claude/agents/` | `.opencode/agents/` |
| `/pm:command` | `/pm-command` |

詳細は [移行ガイド](../docs/migration-from-claude-code.md) を参照してください。

## シェルスクリプト

ターミナル自動化用のシェルスクリプトは `scripts/pm/` にあります：

```bash
# ステータスチェック
./scripts/pm/status.sh

# システム検証
./scripts/pm/validate.sh

# ヘルプ表示
./scripts/pm/help.sh
```

## ライセンス

MIT License - 詳細は [LICENSE](../LICENSE) を参照。

## クレジット

[CCPM](https://github.com/automazeio/ccpm) by Automaze をベースに、OpenCode用に適応。
