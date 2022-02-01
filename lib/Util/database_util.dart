import 'dart:async';

import 'package:great_places/Model/place.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final dbPathFinal = join(dbPath, 'places.db');
    return await openDatabase(
      dbPathFinal,
      onCreate: createDb,
      version: 1,
    );
  }

  static FutureOr<void> createDb(Database db, int version) {
    final sql =
        'CREATE TABLE PLACES(_id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,loc_lat REAL,loc_long REAL,address TEXT,image TEXT)';
    db.execute(sql);
  }

  static Future<int> insert(Place place) async {
    final db = await initDb();
    return await db.insert('Places', {
      '_id': place.id,
      'title': place.title,
      'loc_lat': place.location.latitude,
      'loc_long': place.location.longitude,
      'address': place.location.address,
      'image': place.imageFile.path
    },conflictAlgorithm: ConflictAlgorithm.replace);
    
  }

  static Future<int> delete(int id) async {
    final db = await initDb();
    return await db.delete('Places', where: '_id = ?', whereArgs: [id]);
  }

  static Future<int> deleteAll() async {
    final db = await initDb();
    return await db.delete('Places');
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    final db = await initDb();
    return await db.query('Places');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await initDb();
    return await db.query('Places', where: '_id = ?', whereArgs: [id]);
  }

  // static Future<void> update(int id) async{
  //   final db = await initDb();
  //   final itemMap = await getItem(id);
  //   db.up
  // }
}
