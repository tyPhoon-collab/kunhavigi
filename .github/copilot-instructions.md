# Copilot Custom Instructions

- このリポジトリはServerpodを使用したFlutterアプリケーションです。

## Specific Instructions

### Structure

- Feature-Firstの構造を採用すること（`lib/features/feature_name/`のようにディレクトリを分ける）

### Design

- `withOpacity`は使用せず、`withValues`で指定すること（`withOpacity(0.8)` -> `withValues(alpha: 0.8)`）
- `colorScheme`や`textTheme`を使用し、テーマに沿った色やフォントを使用すること
    - `build`メソッドの先頭で`final colorScheme = Theme.of(context).colorScheme;`のように定義する
    - BuildContextがあれば取得できるため、Widgetのコンストラクタで受け取る必要はない

### Code Style

- `Widget`を返すメソッドはクラス化すること
- `build`メソッドは見通しを良くすること（`Widget`を分割するなど）
- `dynamic`型は使用しないこと
- できるだけ疎結合にすること
- できるだけprivateにすること
- コード内のテキストは英語で記述すること（ローカライズ時にKey名としやすいため）
- 複雑な型は`typedef`を使用すること
- `static`メソッドは使用しないこと
- `logger.dart`を参照し、適切にログを出力すること

### Code Comment

- コメントは許容しない
    - ただし、以下のような場合は許可する
        - `TODO`や`FIXME`などのコメント
        - 複雑な処理や意図が明確でない場合の説明
        - 特定の実装方法を選んだ理由

### Flutter/Dart Specific

- `riverpod_generator + flutter_hooks`を採用すること

#### Widget

- モダンな`Row`や`Column`の`spacing`プロパティを活用すること

#### Switch

`case`句は使用しない。以下のようなモダンな書き方をすること。

```dart
final result = switch (some) {
    A => a,
    B => b,
    C => c,
}

#### Warning

一切許容しない