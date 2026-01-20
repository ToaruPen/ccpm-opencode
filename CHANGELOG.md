# CCPM OpenCode Changelog

## [v1.0.0] - 2026-01-21 - OpenCode Migration Complete

### Overview
CCPM (Claude Code PM) を OpenCode 形式に完全移行。PRD → Epic → Issue → 並列実行のワークフローを OpenCode で利用可能に。

### Added
- **OpenCode コマンド形式** (Phase 2)
  - 38個の PM コマンドを `.opencode/commands/` に移植
  - コマンド名を `/pm:command` から `/pm-command` に変更
  - `$ARGUMENTS` による引数処理対応

- **OpenCode エージェント** (Phase 3)
  - 4つの専門エージェントを `.opencode/agents/` に移植
  - code-analyzer, file-analyzer, test-runner, parallel-worker

- **インストールスクリプト** (Phase 7)
  - `install/add-ccpm.sh` - 既存プロジェクトへの追加
  - `install/ccpm.sh` - 新規プロジェクト用
  - `install/ccpm.bat` - Windows 用

- **日本語ドキュメント**
  - `ja-docs/README_JA.md`
  - `ja-docs/AGENTS_JA.md`
  - `ja-docs/COMMANDS_JA.md`

### Changed
- **ディレクトリ構造**
  - `.claude/prds/` → `.ccpm/prds/`
  - `.claude/epics/` → `.ccpm/epics/`
  - `.claude/commands/pm/` → `.opencode/commands/`
  - `.claude/agents/` → `.opencode/agents/`
  - `CLAUDE.md` → `AGENTS.md`

- **設定ファイル**
  - `claude.json` → `opencode.json`

- **ルールファイル** (Phase 4)
  - 11個のルールを `.ccpm/rules/` に移植
  - パス参照を `.ccpm/` 形式に更新

- **スクリプト** (Phase 5)
  - 18個のシェルスクリプトを `.ccpm/` パス対応に更新
  - `scripts/pm/` に PM 関連スクリプトを整理

### Removed
- 中国語ドキュメント (`zh-docs/`, `doc/`)
- 旧 Claude Code 形式のファイル参照

### QA Results (Phase 8)
- PRD 作成: PASS
- Epic 変換: PASS
- GitHub 同期: PASS (Issues #6-#9)
- エラーハンドリング: PASS

### Migration Phases
| Phase | 内容 | 状態 |
|-------|------|------|
| Phase 0 | 準備（変換ルール確定） | COMPLETE |
| Phase 1 | 基盤構築 | COMPLETE |
| Phase 2 | コマンド移植（38本） | COMPLETE |
| Phase 3 | エージェント移植（4つ） | COMPLETE |
| Phase 4 | ルール移植（11本） | COMPLETE |
| Phase 5 | スクリプト移植（18本） | COMPLETE |
| Phase 6 | ドキュメント更新 | COMPLETE |
| Phase 7 | 配布準備 | COMPLETE |
| Phase 8 | QA | COMPLETE |

---

## Previous Releases (Original CCPM)

See [automazeio/ccpm](https://github.com/automazeio/ccpm) for the original Claude Code version changelog.
