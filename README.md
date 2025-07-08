# Kunhavigi

シンプルなファイル共有アプリ

Kunhavigiはエスペラント語で「共有」を意味する。

## Motivation

- Serverpodの学習
- NextCloudの代替

## Platforms

- macOS

## Features

- 基本的なファイルの操作

### Coming Soon

- 他プラットフォーム対応
- ユーザー認証

## Deployment

### ローカルサーバー

Dockerを使用したローカルマシン（Ubuntu Server）などのサーバーへのデプロイ

- `git clone <Repo URL>`
- `kunhavigi_server/config/password.yaml`を配置
- `.env`ファイルを作成し、以下の内容を記述

  ```env
  POSTGRES_PASSWORD=your_password_here
  ```

- `cd kunhavigi`
- `docker-compose up -d`
