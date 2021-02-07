import 'package:notes_plus/core/models/stored_file.dart';
import 'package:notes_plus/core/services/database_service/database_service_interface.dart';
import 'package:notes_plus/locator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration_service/sqflite_migration_service.dart';

class DatabaseService extends DatabaseServiceInterface {
  static const FilesTable = 'files';
  static const String DB_NAME = 'notes_plus.sqlite';
  static const int DB_VERSION = 4;
  Database _database;

  final DatabaseMigrationService _migrationService =
      locator<DatabaseMigrationService>();

  @override
  Future initialise() async {
    _database = await openDatabase(DB_NAME, version: DB_VERSION);

    await _migrationService
        .runMigration(_database, migrationFiles: ['1_create_schema.sql']);
  }

  @override
  Future<StoredFile> getStoredFile(String textID) async {
    try {
      var jsonData = await _database.query(FilesTable,
          where: 'textID = ?', whereArgs: [textID.toLowerCase()]);

      if (jsonData.isEmpty) return null;

      return StoredFile.fromMap(jsonData.first);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> storeFile(StoredFile file) async {
    try {
      await _database.insert(FilesTable, file.toJson());
      print('FILE STORED SUCCESSFULLY');
      return true;
    } catch (e) {
      print('COULD NOT STORE FILE: ${e.toString()}');
      return false;
    }
  }
}
