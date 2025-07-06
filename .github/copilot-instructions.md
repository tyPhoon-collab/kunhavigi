# Copilot Custom Instructions

- このリポジトリはServerpodを使用したFlutterアプリケーションです。

## Specific Instructions

### Structure

- Feature-Firstの構造を採用すること（`lib/features/feature_name/`のようにディレクトリを分ける）

### Design

- `withOpacity`は使用せず、`withValues`で指定すること（`withOpacity(0.8)` -> `withValues(alpha: 0.8)`）
- `colorScheme`や`textTheme`を使用すること
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

### Code Comment

- コメントは最小限にすること
- コメントは処理の内容ではなく、なぜそのように実装したのかを記述すること

### Flutter/Dart Specific

- `riverpod_generator + flutter_hooks`を採用すること

