import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'basicinfotable.dart';
import 'model/item.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor(); //Singleton DatabaseHelper
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'basicinfo.db';
    //Open/Create the database at a given path
    var bascInfoDatabase =
    openDatabase(path, version: 1, onCreate: _createDb);
    return bascInfoDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE ${BasicInfoTableCol.basic_info_Table} (${BasicInfoTableCol
            .colId} INTEGER PRIMARY KEY, ${BasicInfoTableCol.colName} TEXT)');
  }

  Future insertBasicInfo(List<Item> item) async {
    Database db = await this.database;
    await db.delete(BasicInfoTableCol.basic_info_Table);

    for (var item in item) {
      await db.insert(BasicInfoTableCol.basic_info_Table, item.toMap());
    }
  }

  Future<List<Item>> getInfo() async {
    Database db = await this.database;

    final List<Map<String, dynamic>> maps =
    await db.query(BasicInfoTableCol.basic_info_Table);

    return List.generate(maps.length, (i) {
      return Item.fromMap(maps[i]);
    });
  }
}
