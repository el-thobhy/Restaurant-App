import 'dart:async';

import 'package:restaurant_app/core/data/models/list/restaurant_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblRestaurantList = 'restaurant_list';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/restaurant.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tblRestaurantList (
    id TEXT PRIMARY KEY,
    city TEXT,
    name TEXT,
    rate FLOAT,
    description TEXT,
    pictId TEXT
    );
    ''');
  }

  Future<int> insertRestaurantList(RestaurantTable restaurant) async {
    final db = await database;
    return await db!.insert(_tblRestaurantList, restaurant.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> removeRestaurantList(RestaurantTable restaurant) async {
    final db = await database;
    return await db!.delete(
      _tblRestaurantList,
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  Future<Map<String, dynamic>?> getRestaurantId(String id) async {
    final db = await database;
    final result = await db!.query(
      _tblRestaurantList,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getRestaurantBookmark() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db!.query(_tblRestaurantList);

    return result;
  }
}
