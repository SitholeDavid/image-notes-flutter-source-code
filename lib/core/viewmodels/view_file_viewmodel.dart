import 'package:notes_plus/core/constants/enums.dart';
import 'package:notes_plus/core/models/stored_file.dart';
import 'package:notes_plus/core/services/database_service/database_service.dart';
import 'package:notes_plus/core/services/database_service/database_service_interface.dart';
import 'package:notes_plus/locator.dart';
import 'package:notes_plus/ui/constants/routes.dart';
import 'package:open_file/open_file.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ViewFileViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseServiceInterface>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  String linkValue = '';

  Future showFile(String detectedText) async {
    setBusy(true);
    StoredFile file = await _databaseService.getStoredFile(detectedText);

    if (file == null) {
      _snackbarService.showSnackbar(
          message: 'No file was found', duration: Duration(seconds: 2));

      Future.delayed(Duration(seconds: 2),
          () => _navigationService.clearStackAndShow(HomeViewRoute));
    } else {
      if (file.fileType == FileType.LINK.toString()) {
        linkValue = file.filePath;

        setBusy(false);
        notifyListeners();
        return;
      }

      setBusy(false);
      await OpenFile.open(file.filePath);
      _navigationService.clearStackAndShow(HomeViewRoute);
    }
  }
}
