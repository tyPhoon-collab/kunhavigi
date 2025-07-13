import 'package:intl/intl.dart';

extension ByteFormat on int {
  /// Format bytes as human-readable string (e.g., "1.2KB", "3.4MB")
  String toByteString({bool compact = true}) {
    if (this < 0) return '0B';

    const kb = 1024;
    const mb = kb * 1024;
    const gb = mb * 1024;
    const tb = gb * 1024;

    final formatter = compact
        ? NumberFormat.compact()
        : NumberFormat('#,##0.0');

    if (this < kb) return '${this}B';
    if (this < mb) return '${formatter.format(this / kb)}KB';
    if (this < gb) return '${formatter.format(this / mb)}MB';
    if (this < tb) return '${formatter.format(this / gb)}GB';

    return '${formatter.format(this / tb)}TB';
  }
}
