import 'package:image_picker/image_picker.dart';
import 'package:notes_plus/core/constants/enums.dart' as Enums;

abstract class ImagePickerServiceInterface {
  Future<String> createImagePath();
  Future<String> pickImage(Enums.ImageSource imageSource);
}
