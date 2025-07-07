import 'package:file_picker/file_picker.dart';

abstract interface class Picker {
  Future<List<PlatformFile>> pickFiles();
}

class FilePickerPicker implements Picker {
  @override
  Future<List<PlatformFile>> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
    );

    if (result == null) {
      return [];
    }

    return result.files;
  }
}
