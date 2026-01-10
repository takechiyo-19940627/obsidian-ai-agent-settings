#!/bin/bash

# 既存のRemoteVault同期済みVaultにCursor/Claude設定を適用するスクリプト
# 使用方法: ./setup-settings.sh <リポジトリURL>

set -e

REPO_URL="$1"

if [ -z "$REPO_URL" ]; then
    echo "使用方法: $0 <リポジトリURL>"
    echo "例: $0 https://github.com/username/obsidian-ai-agent-settings.git"
    exit 1
fi

# 現在のディレクトリがVaultのルートか確認
if [ ! -d ".obsidian" ]; then
    echo "警告: 現在のディレクトリがObsidian Vaultのルートではない可能性があります。"
    echo "Vaultのルートディレクトリで実行してください。"
    read -p "続行しますか？ (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo "設定ファイルを適用しています..."

# Gitリポジトリが既に初期化されているか確認
if [ -d ".git" ]; then
    echo "既存のGitリポジトリが見つかりました。"
    # リモートが既に設定されているか確認
    if git remote | grep -q "^origin$"; then
        echo "既にoriginリモートが設定されています。"
        read -p "上書きしますか？ (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git remote set-url origin "$REPO_URL"
        else
            echo "リモートURLの変更をスキップしました。"
        fi
    else
        git remote add origin "$REPO_URL"
    fi
else
    echo "Gitリポジトリを初期化しています..."
    git init
    git remote add origin "$REPO_URL"
fi

# リモートから設定ファイルを取得
echo "リモートから設定ファイルを取得しています..."
git fetch origin

# 設定ファイルのみをマージ（コンフリクトを避けるため）
echo "設定ファイルを適用しています..."
git checkout origin/main -- .cursor/ .claude/ .gitignore README.md 2>/dev/null || {
    echo "エラー: リモートからファイルを取得できませんでした。"
    echo "リポジトリURLが正しいか確認してください。"
    exit 1
}

# 変更をステージング
git add .gitignore README.md .cursor/ .claude/

# 変更があるか確認
if git diff --cached --quiet; then
    echo "変更はありません。設定ファイルは既に最新です。"
else
    # 初回コミットまたは更新コミット
    if git rev-parse --verify HEAD >/dev/null 2>&1; then
        git commit -m "Update Cursor and Claude configuration files"
        echo "設定ファイルを更新しました。"
    else
        git commit -m "Add Cursor and Claude configuration files"
        echo "設定ファイルを追加しました。"
    fi
fi

echo ""
echo "✅ 設定の適用が完了しました！"
echo ""
echo "今後の更新方法:"
echo "  git pull origin main"
echo ""

