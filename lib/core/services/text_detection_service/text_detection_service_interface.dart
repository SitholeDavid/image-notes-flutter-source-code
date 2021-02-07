import 'dart:io';

abstract class TextDetectionServiceInterface {
  Future<String> getDetectedText(File imageFile);
}
