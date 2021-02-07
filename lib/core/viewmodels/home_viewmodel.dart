import 'package:notes_plus/core/services/camera_service/camera_service.dart';
import 'package:notes_plus/core/services/camera_service/camera_service_interface.dart';
import 'package:notes_plus/core/services/database_service/database_service.dart';
import 'package:notes_plus/core/services/database_service/database_service_interface.dart';
import 'package:notes_plus/locator.dart';
import 'package:notes_plus/ui/constants/routes.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseServiceInterface>();
  final CameraService _cameraService = locator<CameraServiceInterface>();

  Future initialise() async {
    setBusy(true);
    await _cameraService.initializeController();
    await _databaseService.initialise();
    setBusy(false);
  }

  void navigateToCameraView(String selectedFunction) {
    _navigationService.navigateTo(CameraViewRoute, arguments: selectedFunction);
  }
}
