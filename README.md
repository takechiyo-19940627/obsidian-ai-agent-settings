# Obsidian Vault: takehiro.tanaka

## セットアップ

### Cursor/Claude設定の同期

このリポジトリでは、**設定ファイルのみ**をGitで管理しています。

**Git管理対象:**
- `.cursor/` - Cursorのルール設定
- `.claude/` - Claudeのコマンド設定
- `.gitignore` - Git除外設定
- `README.md` - このファイル
- `setup-settings.sh` - 設定適用用のシェルスクリプト

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

## 既存のRemoteVault同期済みVaultに設定を適用する方法

既にRemoteVaultで同期されている端末のVaultに、この設定を適用する手順です。

### 方法1: 既存VaultでGitリポジトリとして管理（推奨）

シェルスクリプトを使用する方法（簡単）：

```bash
# このリポジトリからsetup-settings.shをダウンロード
# または、このリポジトリをクローンしてsetup-settings.shを取得

# 既存のVaultディレクトリに移動
cd /path/to/your/vault

# スクリプトに実行権限を付与
chmod +x setup-settings.sh

# スクリプトを実行（リポジトリURLを引数として指定）
./setup-settings.sh <このリポジトリのURL>
```

手動で実行する方法：

```bash
# 既存のVaultディレクトリに移動
cd /path/to/your/vault

# Gitリポジトリを初期化
git init

# このリポジトリをリモートとして追加
git remote add origin <このリポジトリのURL>

# リモートから設定ファイルを取得
git fetch origin

# 設定ファイルのみをマージ（コンフリクトを避けるため）
git checkout origin/main -- .cursor/ .claude/ .gitignore README.md

# 初回コミット
git add .gitignore README.md .cursor/ .claude/
git commit -m "Add Cursor and Claude configuration files"
```

### 方法2: 設定ファイルを直接コピー

このリポジトリから設定ファイルだけをコピーする方法です。

```bash
# このリポジトリを一時的にクローン
git clone <このリポジトリのURL> /tmp/obsidian-settings

# 既存のVaultディレクトリに設定ファイルをコピー
cp -r /tmp/obsidian-settings/.cursor /path/to/your/vault/
cp -r /tmp/obsidian-settings/.claude /path/to/your/vault/
cp /tmp/obsidian-settings/.gitignore /path/to/your/vault/
cp /tmp/obsidian-settings/README.md /path/to/your/vault/

# 一時ディレクトリを削除
rm -rf /tmp/obsidian-settings

# 既存のVaultでGitリポジトリを初期化（今後の同期のため）
cd /path/to/your/vault
git init
git add .gitignore README.md .cursor/ .claude/
git commit -m "Add Cursor and Claude configuration files"
git remote add origin <このリポジトリのURL>
```

### 設定適用後の同期

設定を適用した後、他の端末でも同じ手順を実行するか、以下のコマンドで設定を更新できます：

```bash
# 既存のVaultディレクトリで
git pull origin main
```

# obsidian-ai-agent-settings
