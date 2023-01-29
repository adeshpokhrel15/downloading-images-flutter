import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;
  static const String DB_NAME = 'my_db.db';
  static const String URL_TABLE = 'albumId';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_URL = 'url';

  Future<Database> _createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = "${documentsDirectory.path}/photos.db";
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE photos (albumId INTEGER, id INTEGER PRIMARY KEY, title TEXT)");
    });
  }

  Future<void> insertPhoto(int albumId, int id, String title) async {
    final db = await _createDatabase();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert(
          "INSERT INTO photos (albumId, id, title) VALUES ($albumId, $id, '$title')");
    });
  }

  Future<List<Map<String, dynamic>>> getPhotos() async {
    final db = await _createDatabase();
    return await db.rawQuery("SELECT * FROM photos");
  }
}
