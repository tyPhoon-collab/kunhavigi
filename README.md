# Kunhavigi

シンプルなファイル共有アプリ

Kunhavigiはエスペラント語で「共有」を意味する。

## モチベーション

- Serverpodの学習
- NextCloudの代替

## プラットホーム

- Web

## Features

- 基本的なファイルの操作

### Coming Soon

- 他プラットフォーム対応
- ユーザー認証
- メモのリアルタイム編集
- コマンド操作（ショートカット）

## デプロイ

### ビルド

#### Web

静的配信を有効にしている

```bash
flutter build web -o ../kunhavigi_server/web/static
```

GitHub ActionsによるCI/CDパイプラインが設定されており、main・test_ciブランチへのプッシュ時に自動的にビルドされ、成果物がコミットされます。

### ローカルサーバー

Dockerを使用したローカルマシン（Ubuntu Server）などのサーバーへのデプロイ

```bash
git clone <Repo URL>
# 1. `kunhavigi_server/config/password.yaml`を配置
# 2. `.env.example`をコピーし、`.env`ファイル作成、適切に環境変数を設定
cd kunhavigi
docker compose up -d
```
