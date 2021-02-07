import 'package:notes_plus/core/constants/enums.dart';

abstract class FilePickerServiceInterface {
  Future pickFile(FileType type);
  List<String> getAllowedExtensions(FileType type);
}
