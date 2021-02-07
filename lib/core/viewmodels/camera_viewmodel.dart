import 'dart:io';

import 'package:camera/camera.dart';
import 'package:notes_plus/core/constants/enums.dart';
import 'package:notes_plus/core/services/camera_service/camera_service.dart';
import 'package:notes_plus/core/services/camera_service/camera_service_interface.dart';
import 'package:notes_plus/core/services/crop_image/crop_image_service.dart';
import 'package:notes_plus/core/services/crop_image/crop_image_service_interface.dart';
import 'package:notes_plus/core/services/text_detection_service/text_detection_service.dart';
import 'package:notes_plus/core/services/text_detection_service/text_detection_service_interface.dart';
import 'package:notes_plus/core/utils.dart';
import 'package:notes_plus/locator.dart';
import 'package:notes_plus/ui/constants/routes.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CameraViewModel extends BaseViewModel {
  final CameraService _cameraService = locator<CameraServiceInterface>();
  final DialogService _dialogService = locator<DialogService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final CropImageService _cropImageService =
      locator<CropImageServiceInterface>();
  final TextDetectionService _textDetectionService =
      locator<TextDetectionServiceInterface>();

  static const String defaultText = 'Scan or enter text here';

  CameraPreview preview;
  String detectedText;
  bool newFile;

  Future initialise(String selectedOption) async {
    newFile = selectedOption == 'NEW' ? true : false;

    preview = await _cameraService.getCameraPreview();
    detectedText = detectedText ?? defaultText;
    notifyListeners();
  }

  CameraPreview getPreview() {
    return preview;
  }

  void navigateToViewFileRoute() {
    _navigationService.navigateTo(ViewFileViewRoute, arguments: detectedText);
  }

  void navigateToChooseFileView() {
    if (detectedText == null ||
        detectedText == defaultText ||
        detectedText.isEmpty) {
      return _snackbarService.showSnackbar(
          message: 'Please provide text to identify file first');
    }

    _navigationService.navigateTo(ChooseFileViewRoute, arguments: detectedText);
  }

  void editDetectedText() async {
    var dialogResponse = await _dialogService.showCustomDialog(
        variant: DialogType.editInputField,
        title: 'Correct detected text',
        mainButtonTitle: 'Update text',
        customData:
            dialogCustomData(detectedText == defaultText ? '' : detectedText));

    // ignore: can_be_null_after_null_aware
    detectedText = dialogResponse.responseData?.toString().trim();
    notifyListeners();
  }

  Future takePicture() async {
    setBusy(true);

    String imagePath = await _cameraService.takePicture();
    File croppedImageFile = await _cropImageService.cropImage(imagePath);
    detectedText =
        await _textDetectionService.getDetectedText(croppedImageFile);

    print('DETECTED TEXT: $detectedText');
    notifyListeners();
    setBusy(false);
  }
}
