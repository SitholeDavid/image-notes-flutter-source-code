import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:notes_plus/core/services/text_detection_service/text_detection_service_interface.dart';

class TextDetectionService implements TextDetectionServiceInterface {
  @override
  Future<String> getDetectedText(File imageFile) async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);

    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();

    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    String detectedText = "";

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        detectedText += line.text + " ";
      }
    }

    return detectedText;
  }
}
