# CCPM コマンドリファレンス

すべてのPMコマンドの包括的なリファレンス。

## 概要

CCPMは38個のコマンドを提供し、以下のカテゴリに分類されます：

| カテゴリ | コマンド数 | 説明 |
|---------|-----------|------|
| セットアップ | 2 | 初期化とヘルプ |
| PRD | 5 | プロダクト要件ドキュメント管理 |
| エピック | 12 | エピックのライフサイクル管理 |
| Issue | 8 | GitHub Issue操作 |
| ワークフロー | 5 | 日常のワークフローコマンド |
| 同期 | 2 | GitHub同期 |
| メンテナンス | 4 | システム保守 |

## セットアップコマンド

### `/pm-init`
PMシステムを初期化し、依存関係をインストール。

**実行内容:**
- GitHub CLI（gh）のインストール確認
- GitHub認証
- gh-sub-issue拡張のインストール
- 必要なディレクトリの作成
- GitHubラベルの設定

```bash
/pm-init
```

### `/pm-help`
利用可能なすべてのコマンドの概要を表示。

```bash
/pm-help
```

## PRDコマンド

### `/pm-prd-new <name>`
ガイド付きブレインストーミングで新しいPRDを作成。

```bash
/pm-prd-new user-authentication
```

**出力:** `.ccpm/prds/user-authentication.md`

### `/pm-prd-parse <name>`
PRDを技術実装エピックに変換。

```bash
/pm-prd-parse user-authentication
```

**出力:** `.ccpm/epics/user-authentication/epic.md`

### `/pm-prd-list`
すべてのPRDを一覧表示。

```bash
/pm-prd-list
```

### `/pm-prd-edit <name>`
既存のPRDを編集。

```bash
/pm-prd-edit user-authentication
```

### `/pm-prd-status`
すべてのPRDの実装状況を表示。

```bash
/pm-prd-status
```

## エピックコマンド

### `/pm-epic-decompose <name>`
エピックを個別のタスクファイルに分解。

```bash
/pm-epic-decompose user-authentication
```

**出力:** `.ccpm/epics/user-authentication/001.md`, `002.md`, ...

### `/pm-epic-sync <name>`
エピックとタスクをGitHub Issuesとしてプッシュ。

```bash
/pm-epic-sync user-authentication
```

### `/pm-epic-oneshot <name>`
分解と同期を1コマンドで実行。

```bash
/pm-epic-oneshot user-authentication
```

### `/pm-epic-list`
すべてのエピックを一覧表示。

```bash
/pm-epic-list
```

### `/pm-epic-show <name>`
エピックの詳細とすべてのタスクを表示。

```bash
/pm-epic-show user-authentication
```

### `/pm-epic-status [name]`
エピックの進捗状況を表示。名前を省略するとすべてのエピックを表示。

```bash
/pm-epic-status user-authentication
/pm-epic-status  # すべて表示
```

### `/pm-epic-edit <name>`
エピックの詳細を編集。

```bash
/pm-epic-edit user-authentication
```

### `/pm-epic-close <name>`
エピックを完了としてマーク。

```bash
/pm-epic-close user-authentication
```

### `/pm-epic-refresh <name>`
タスクの状態からエピックの進捗を更新。

```bash
/pm-epic-refresh user-authentication
```

### `/pm-epic-start <name>`
並列エージェント実行を開始。

```bash
/pm-epic-start user-authentication
```

### `/pm-epic-start-worktree <name>`
Git Worktreeでエピックを開始。

```bash
/pm-epic-start-worktree user-authentication
```

### `/pm-epic-merge <name>`
完了したエピックブランチをマージ。

```bash
/pm-epic-merge user-authentication
```

## Issueコマンド

### `/pm-issue-start <num>`
専門エージェントで作業を開始。

```bash
/pm-issue-start 1234
```

### `/pm-issue-show <num>`
Issueとそのサブissueを表示。

```bash
/pm-issue-show 1234
```

### `/pm-issue-status <num>`
Issueのステータスを確認。

```bash
/pm-issue-status 1234
```

### `/pm-issue-sync <num>`
進捗更新をGitHubにプッシュ。

```bash
/pm-issue-sync 1234
```

### `/pm-issue-close <num>`
Issueを完了としてマーク。

```bash
/pm-issue-close 1234
```

### `/pm-issue-reopen <num>`
クローズされたIssueを再オープン。

```bash
/pm-issue-reopen 1234
```

### `/pm-issue-edit <num>`
Issueの詳細を編集。

```bash
/pm-issue-edit 1234
```

### `/pm-issue-analyze <num>`
並列作業ストリームを分析。

```bash
/pm-issue-analyze 1234
```

## ワークフローコマンド

### `/pm-next`
次の優先タスクをエピックコンテキストと共に表示。

```bash
/pm-next
```

### `/pm-status`
プロジェクト全体のダッシュボードを表示。

```bash
/pm-status
```

### `/pm-standup`
デイリースタンドアップレポートを生成。

```bash
/pm-standup
```

### `/pm-blocked`
ブロックされているタスクを表示。

```bash
/pm-blocked
```

### `/pm-in-progress`
現在進行中の作業を一覧表示。

```bash
/pm-in-progress
```

## 同期コマンド

### `/pm-sync`
GitHubとの完全な双方向同期を実行。

```bash
/pm-sync
```

### `/pm-import <issue>`
既存のGitHub Issueをインポート。

```bash
/pm-import 1234
/pm-import https://github.com/owner/repo/issues/1234
```

## メンテナンスコマンド

### `/pm-validate`
システムの整合性をチェック。

```bash
/pm-validate
```

**チェック内容:**
- ファイル参照の整合性
- frontmatterの妥当性
- GitHub同期状態

### `/pm-clean`
完了した作業をアーカイブ。

```bash
/pm-clean
```

### `/pm-search <query>`
すべてのPRD、エピック、タスクを検索。

```bash
/pm-search "authentication"
```

### `/pm-test-reference-update`
テスト参照を更新（内部用）。

```bash
/pm-test-reference-update
```

## 典型的なワークフロー

### 新機能の開発

```bash
# 1. PRDを作成
/pm-prd-new new-feature

# 2. PRDをレビュー・編集
/pm-prd-edit new-feature

# 3. エピックに変換してGitHubに同期
/pm-epic-oneshot new-feature

# 4. タスクを開始
/pm-issue-start 1234

# 5. 進捗を同期
/pm-issue-sync 1234

# 6. 完了時にクローズ
/pm-issue-close 1234
```

### 日常のワークフロー

```bash
# 朝のスタンドアップ
/pm-standup

# 次のタスクを取得
/pm-next

# ステータス確認
/pm-status

# ブロックされたものを確認
/pm-blocked
```

## コマンドのパス規則

すべてのコマンドは以下のパスを使用します：

| 種類 | パス |
|------|------|
| PRD | `.ccpm/prds/<name>.md` |
| エピック | `.ccpm/epics/<name>/epic.md` |
| タスク | `.ccpm/epics/<name>/<num>.md` |
| コンテキスト | `.ccpm/context/` |
| ルール | `.ccpm/rules/` |

## エラー処理

各コマンドには組み込みのエラー処理があります：

- **存在しないファイル**: 適切な作成コマンドを提案
- **無効なフォーマット**: 具体的な修正方法を表示
- **GitHub同期エラー**: 部分的な成功を報告し、失敗を詳述
