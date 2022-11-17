import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/features/detail_weather_information/domain/model/weather.dart';

class DatabaseHelper {
  static const _databaseName = "WeatherDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'cities_table';

  static const columnId = '_id';
  static const columnName = 'name';
  static const columnData = 'data';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    var database = _database ?? await _initDatabase();
    _database ??= database;
    return database;
  }

  _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnData TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(String cityName, Weather weather) async {
    final row = {
      DatabaseHelper.columnName : cityName,
      DatabaseHelper.columnData : jsonEncode(weather.toJson())
    };

    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<int> update(String cityName, Weather weather) async {
    final row = {
      DatabaseHelper.columnName : cityName,
      DatabaseHelper.columnData :jsonEncode(weather.toJson())
    };
    Database db = await instance.database;
    return await db.update(table, row);
  }

  Future<Weather?> select(String cityName) async {
    Database db = await instance.database;
    final count = await db.rawQuery('SELECT $columnData FROM $table WHERE $columnName LIKE \'$cityName\'');

    if (count.isEmpty) {
      return null;
    } else {
      final firstCount = count.first;
      final data = firstCount[columnData] as String;
      final jsonData = jsonDecode(data);
      return Weather.fromJson(jsonData);
    }
  }
}
