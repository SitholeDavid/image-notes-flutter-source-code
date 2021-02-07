import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:notes_plus/core/constants/enums.dart' as Enums;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'image_picker_service_interface.dart';

class ImagePickerService implements ImagePickerServiceInterface {
  static final String FOLDER = "ImageNotes/images/";
  final picker = ImagePicker();

  @override
  Future<String> createImagePath() async {
    String directoryPath = (await getApplicationDocumentsDirectory()).path;
    String imagePath = join(directoryPath, FOLDER, "${DateTime.now()}.jpg");
    return imagePath;
  }

  @override
  Future<String> pickImage(Enums.ImageSource imageSource) async {
    final imagePath = await createImagePath();
    final pickedFile = await picker.getImage(
        source: imageSource == Enums.ImageSource.CAMERA
            ? ImageSource.camera
            : ImageSource.gallery);

    if (pickedFile == null) return "";

    //save file to the new path

    // final newFile = await File(pickedFile.path).copy(imagePath);
    return await saveImage(pickedFile.path);
  }

  Future<String> saveImage(String path) async {
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory.path}/ImageNotes';
    String newPath = '$imagePath/${DateTime.now().toString()}.jpg';

    File movedImage = await File(path).copy(newPath);

    ///var newImage = new File('$imagePath/${DateTime.now().toString()}.jpg')..writeAsBytes(img.encodeJpg(image));
    return movedImage.path;
  }
}
