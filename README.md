# Obsidian Vault: takehiro.tanaka

## セットアップ

### Cursor/Claude設定の同期

このリポジトリでは、**設定ファイルのみ**をGitで管理しています。

**Git管理対象:**
- `.cursor/` - Cursorのルール設定
- `.claude/` - Claudeのコマンド設定
- `.gitignore` - Git除外設定
- `README.md` - このファイル

**Git管理から除外:**
- 全てのマークダウンファイル（`.md`、`.mdc`）
- 画像ファイル（`.png`、`.jpg`など）
- Canvasファイル（`.canvas`）
- `.obsidian/` ディレクトリ（端末ごとに異なるため）

他の端末でこのVaultを開いた際、CursorやClaudeは自動的にこれらの設定を読み込みます。

### 注意事項

- `.obsidian/` ディレクトリは端末ごとに異なるため、Git管理から除外されています
- 各端末でObsidianの設定は個別に管理してください
- マークダウンファイル（デイリーノート、学習ノートなど）はGit管理されません

# obsidian-ai-agent-settings
