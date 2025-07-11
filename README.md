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

今後はCI/CDを使用して自動化する予定

### ローカルサーバー

Dockerを使用したローカルマシン（Ubuntu Server）などのサーバーへのデプロイ

```bash
git clone <Repo URL>

# `kunhavigi_server/config/password.yaml`を配置
# `.env`ファイルを作成し、以下の内容を記述

#   ```env
#   POSTGRES_PASSWORD=your_password_here
#   ```

cd kunhavigi
docker compose up -d
```
