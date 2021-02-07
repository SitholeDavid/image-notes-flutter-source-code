import 'package:get_it/get_it.dart';
import 'package:notes_plus/core/services/camera_service/camera_service.dart';
import 'package:notes_plus/core/services/camera_service/camera_service_interface.dart';
import 'package:notes_plus/core/services/crop_image/crop_image_service.dart';
import 'package:notes_plus/core/services/crop_image/crop_image_service_interface.dart';
import 'package:notes_plus/core/services/database_service/database_service.dart';
import 'package:notes_plus/core/services/database_service/database_service_interface.dart';
import 'package:notes_plus/core/services/file_picker_service/file_picker_service.dart';
import 'package:notes_plus/core/services/file_picker_service/file_picker_service_interface.dart';
import 'package:notes_plus/core/services/text_detection_service/text_detection_service.dart';
import 'package:notes_plus/core/services/text_detection_service/text_detection_service_interface.dart';
import 'package:sqflite_migration_service/sqflite_migration_service.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => DatabaseMigrationService());
  locator.registerLazySingleton<CameraServiceInterface>(() => CameraService());

  locator
      .registerLazySingleton<DatabaseServiceInterface>(() => DatabaseService());

  locator.registerLazySingleton<CropImageServiceInterface>(
      () => CropImageService());

  locator.registerLazySingleton<FilePickerServiceInterface>(
      () => FilePickerService());

  locator.registerLazySingleton<TextDetectionServiceInterface>(
      () => TextDetectionService());
}
