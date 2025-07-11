import 'package:glob/glob.dart';

class PatternMatcher {
  const PatternMatcher(this.patterns);

  final List<String> patterns;

  bool matches(String path) {
    if (patterns.isEmpty) {
      return false;
    }

    for (final pattern in patterns) {
      final glob = Glob(pattern, caseSensitive: false);
      if (glob.matches(path)) {
        return true;
      }
    }

    return false;
  }
}
