import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'crop_image_service_interface.dart';

class CropImageService implements CropImageServiceInterface {
  @override
  Future<File> cropImage(String imagePath) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(imagePath);
    File croppedFile = await FlutterNativeImage.cropImage(
        imagePath,
        (properties.width * 0.3).round() + 15,
        0,
        (properties.width * 0.3).round(),
        properties.height);
    return croppedFile;
  }
}
