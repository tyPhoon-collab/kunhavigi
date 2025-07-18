# Kunhavigi

シンプルなSPAのファイル共有クライアントとサーバー

Kunhavigiはエスペラント語で「共有する」を意味する。

オープンソース。Issueやコントリビュートをお待ちしております。

## モチベーション

- Serverpodの学習
- NextCloudの代替
  - 軽量でシンプルなファイル共有を実現
  - Flutterによる、プラットホームに依らないデザイン

## プラットホーム

- Web
- macOS

## Features

- オープンソース
- 基本的なファイルの操作
- ファイル検索
- tailscaleのサポート

### Coming Soon

- 他プラットフォーム対応
- 自動ファイル配置
- コマンド操作（ショートカット）

## デプロイ

### ビルド

#### Web

静的配信を有効にしている

```bash
flutter build web -o ../kunhavigi_server/web/static
```

GitHub ActionsによるCI/CDパイプラインが設定されており、mainブランチへのプッシュ時に自動的にビルドされ、成果物がコミットされる

### ローカルサーバー

Dockerを使用したローカルマシン（Ubuntu Server）などのサーバーへのデプロイ

```bash
git clone <Repo URL>
cd kunhavigi
# 1. `kunhavigi_server/config/password.yaml`を配置
# 2. `.env.example`をコピーし、`.env`ファイル作成、適切に環境変数を設定
docker compose up -d
```

`git pull`などして更新した場合は、以下のコマンドで再ビルド

```bash
docker compose build --no-cache
docker compose up -d
```
