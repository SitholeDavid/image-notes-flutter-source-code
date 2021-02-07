import 'dart:io';

import 'package:notes_plus/core/constants/enums.dart';
import 'package:notes_plus/core/models/stored_file.dart';
import 'package:notes_plus/core/services/database_service/database_service.dart';
import 'package:notes_plus/core/services/database_service/database_service_interface.dart';
import 'package:notes_plus/core/services/file_picker_service/file_picker_service.dart';
import 'package:notes_plus/core/services/file_picker_service/file_picker_service_interface.dart';
import 'package:notes_plus/core/utils.dart';
import 'package:notes_plus/locator.dart';
import 'package:notes_plus/ui/constants/routes.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChooseFileViewModel extends BaseViewModel {
  final DatabaseService _databaseService = locator<DatabaseServiceInterface>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final FilePickerService _filePickerService =
      locator<FilePickerServiceInterface>();

  String detectedText = '';

  void initialise(String text) => detectedText = text;

  Future chooseFile(FileType type) async {
    if (type == FileType.LINK) {
      var response = await _dialogService.showCustomDialog(
          variant: DialogType.editInputField,
          customData: dialogCustomData(' '),
          title: 'Enter link',
          mainButtonTitle: 'Save link');

      if (response.responseData != null &&
          response.responseData.toString().trim().isNotEmpty) {
        bool success =
            await saveFile(response.responseData.toString().trim(), type);

        return await showSuccessSnackbar(success);
      }
    }

    String tempFilePath = await _filePickerService.pickFile(type);

    if (tempFilePath.isEmpty) return;

    File chosenFile = File(tempFilePath);
    String finalFilePath = await createFilePath(extension(tempFilePath));
    await moveFile(chosenFile, finalFilePath);

    bool success = await saveFile(finalFilePath, type);
    showSuccessSnackbar(success);
  }

  Future showSuccessSnackbar(bool success) async {
    _snackbarService.showSnackbar(
        message: success ? 'Filed saved successfully' : 'Could not save file',
        duration: Duration(seconds: 2));

    Future.delayed(Duration(seconds: 2), () {
      _navigationService.clearStackAndShow(HomeViewRoute);
    });
  }

  Future<String> createFilePath(String fileExtension) async {
    String directoryPath = (await getApplicationDocumentsDirectory()).path;
    String filePath = join(directoryPath, "${DateTime.now()}$fileExtension");

    return filePath;
  }

  Future<bool> saveFile(String path, FileType type) async {
    print('DETECTED TEXT: ' + detectedText);

    var file = StoredFile(
        filePath: path, fileType: type.toString(), textID: detectedText);

    return await _databaseService.storeFile(file);
  }
}
