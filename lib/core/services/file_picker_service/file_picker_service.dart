import 'package:file_picker/file_picker.dart';
import 'package:notes_plus/core/constants/enums.dart' as Enums;
import 'package:notes_plus/core/services/file_picker_service/file_picker_service_interface.dart';

class FilePickerService extends FilePickerServiceInterface {
  @override
  Future pickFile(Enums.FileType type) async {
    var allowedExtensions = getAllowedExtensions(type);
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: allowedExtensions);

    if (result != null)
      return result.paths.first;
    else
      return '';
  }

  @override
  List<String> getAllowedExtensions(Enums.FileType type) {
    var allowedExtensions = <String>[];

    switch (type) {
      case Enums.FileType.IMAGE:
        allowedExtensions.addAll(['jpg', 'jpeg', 'png']);
        break;

      case Enums.FileType.DOC:
        allowedExtensions.addAll(['pdf', 'doc', 'docx']);
        break;

      case Enums.FileType.VIDEO:
        allowedExtensions.addAll(['mp4', 'mov', 'vid', 'video']);
        break;
      default:
        break;
    }

    return allowedExtensions;
  }
}
