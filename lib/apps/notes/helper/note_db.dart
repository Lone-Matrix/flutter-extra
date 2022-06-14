import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

import 'package:extra/apps/notes/models/notes_data.dart';

class DBHelper {
  static int totalData = 0;
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'Notes.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_notes(id TEXT PRIMARY KEY, title TEXT NOT NULL, text TEXT NOT NULL)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int?> getCount() async {
    final db = await DBHelper.database();
    var x = await db.rawQuery('SELECT COUNT (*) from user_notes');
    int? count = sql.Sqflite.firstIntValue(x);
    return count;
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> update(String table, Note note) async {
    final db = await DBHelper.database();

    await db.update(
      table,
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  static Future<void> delete(String table, String id) async {
    final db = await DBHelper.database();
    await db.delete(
      table,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
