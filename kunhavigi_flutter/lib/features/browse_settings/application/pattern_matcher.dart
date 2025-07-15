import 'package:glob/glob.dart';

class PatternMatcher {
  const PatternMatcher(this.patterns);

  final List<String> patterns;

  bool matches(String path) {
    if (patterns.isEmpty) {
      return false;
    }

    final uri = Uri.file(path);

    for (final pattern in patterns) {
      final glob = Glob(pattern, caseSensitive: false);
      if (glob.matches(uri.path)) return true;
    }

    return false;
  }
}
