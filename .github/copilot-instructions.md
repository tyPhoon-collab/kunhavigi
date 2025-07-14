# Copilot Custom Instructions

- このリポジトリはServerpodを使用したFlutterアプリケーションです。

## Specific Instructions

### Structure

- Feature-Firstの構造を採用すること（`lib/features/feature_name/`のようにディレクトリを分ける）
- `kunhavigi_shared`は共通のコードを配置する
- `kunhavigi_server`はサーバーサイドのコードを配置する
- `kunhavigi_flutter`はFlutterアプリケーションのコードを配置する
- `kunhavigi_client`はクライアントサイドのコードを配置する
    - 基本的に自動生成されるため、参照する必要はない
    - 生成コマンドは`kunhavigi_server`ディレクトリで`serverpod generate`を使用する

### Design

- `withOpacity`は使用せず、`withValues`で指定すること（`withOpacity(0.8)` -> `withValues(alpha: 0.8)`）
- `colorScheme`や`textTheme`を使用し、テーマに沿った色やフォントを使用すること
    - `build`メソッドの先頭で`final colorScheme = Theme.of(context).colorScheme;`のように定義する
    - BuildContextがあれば取得できるため、Widgetのコンストラクタで受け取る必要はない
- 共通の設定が何度も重複する場合は、`MaterialApp.theme`で設定し、共通化すること

### Code Style

#### Basic

- コード内のテキストは英語で記述すること
- できるだけ疎結合にすること
- できるだけprivateにすること
- できるだけシンプルなコードを書くこと
- ログ出力が必要だと判断した場合は`logger.dart`を参照し出力すること

#### Type

- `dynamic`型は使用しないこと
- 複雑な型は`typedef`を使用すること
- テストの可用性を考え、`static`メソッドやシングルトンは使用しないこと

#### Widget

- `Widget`を返すメソッドは使用せず、必ずクラスを用いること
- `build`メソッドは見通しを良くすること（`Widget`を分割するなど）
    - 例えば、`AlertDialog`のような大きなWidgetは、別のクラスに分割すること
- Widget構造は保守性を考慮して、できるだけシンプルにすること
- モダンな`Row`や`Column`の`spacing`プロパティを活用すること

### Code Comment

- コメントは許容しない
- ただし、以下のような場合は許可する
    - `TODO`や`FIXME`などのコメント
    - 複雑な処理や意図が明確でない場合の説明
    - 特定の実装方法を選んだ理由

### Flutter/Dart Specific

- `riverpod_generator + flutter_hooks`を採用中
    - Widget間で状態を共有する場合は、`riverpod`を使用する
    - Widget内で状態を管理する場合は、`hooks`を使用する
- `case`句は使用しない。以下のようなモダンな書き方をすること。

    ```dart
    final result = switch (some) {
        A => a,
        B => b,
        C => c,
    }
    ```
