import 'package:notes_plus/core/models/stored_file.dart';

abstract class DatabaseServiceInterface {
  Future initialise();
  Future<StoredFile> getStoredFile(String textID);
  Future<bool> storeFile(StoredFile file);
}
