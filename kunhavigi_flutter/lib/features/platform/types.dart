import 'package:cross_file/cross_file.dart';

final class FileWithSource {
  const FileWithSource({
    required this.file,
    this.directory,
  });
  final XFile file;
  final String? directory;

  String get name => '${directory ?? ''}${file.name}';
}
