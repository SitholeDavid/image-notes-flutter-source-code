import 'dart:io';

abstract class CropImageServiceInterface {
  Future<File> cropImage(String imagePath);
}
