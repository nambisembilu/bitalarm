import 'dart:io';

import 'package:bitalarm/utils/common_function.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "BitArm.db";
  static final _databaseVersion = 7;
  static final _columnId = '_id';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // SQL code to create the database table
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    devPrint('delete database, and create again');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
    await db.execute('''
      DROP TABLE IF EXISTS alarm_infos
      ''');
    await db.execute('''
      DROP TABLE IF EXISTS alarm_actions
      ''');
    await _onCreate(db, newVersion);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    devPrint('on create database');
    await db.execute('''
      CREATE TABLE alarm_infos (
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        hour TEXT,
        minute TEXT,
        repeat INTEGER DEFAULT 0,
        is_active INTEGER DEFAULT 1
      )
      ''');
    await db.execute('''
      CREATE TABLE alarm_actions (
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        alarm_id INTEGER NOT NULL,
        action_time INTEGER
      )
      ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryFilterRows(String table, String filter) async {
    Database db = await instance.database;
    devPrint('SELECT * FROM $table $filter');
    return await db.rawQuery('SELECT * FROM $table $filter');
  }

  Future<List<Map<String, dynamic>>> queryRawRows(String query) async {
    Database db = await instance.database;
    devPrint(query);
    return await db.rawQuery(query);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> queryRowCountFilter(String table, String filter) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table $filter'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row, int id, String table) async {
    Database db = await instance.database;
    return await db.update(table, row, where: '$_columnId = ?', whereArgs: [id]);
  }

  Future<int> updateByColumn(Map<String, dynamic> row, String id, String column, String table) async {
    Database db = await instance.database;
    devPrint("UPDATE " + column + '=' + "'$id'");
    return await db.update(table, row, where: '$column = ?', whereArgs: [id]);
  }

  Future<int> updateByFilter(Map<String, dynamic> row, String filter, String table) async {
    Database db = await instance.database;
    devPrint("UPDATE " + table + " WHERE " + filter);
    return await db.update(table, row, where: filter);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id, String table) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$_columnId = ?', whereArgs: [id]);
  }

  insertFromList(List<Map<String, dynamic>> datas, String table) async {
    Database db = await instance.database;
    int chunkSize = 500;
    if (datas.length <= chunkSize) {
      String query = "INSERT INTO $table (";
      Iterable<String> columns = datas[0].keys;
      // devPrint(columns);
      columns.forEach((k) {
        if (columns.last == k) {
          query = query + '$k) VALUES ';
        } else {
          query = query + '$k,';
        }
      });
      datas.forEach((data) {
        query = query + '(';
        columns.forEach((k) {
          if (k == 'created_at' || k == 'updated_at' || k == 'deleted_at' || k == 'item_sync_at' || k == 'date' || k == 'time' || k.contains('date')) {
            // devPrint(k + ' : ' + data[k].toString() + ' Length');
            if (data[k].toString().length > 0 && data[k] != null && data[k] != Null && data[k] != '' && data[k] != 'null') {
              data[k] = DateTime.parse(data[k]).millisecondsSinceEpoch;
              // devPrint(data[k]);
            } else {
              data[k] = null;
            }
          }
          if (columns.last == k) {
            query = query + "'" + data[k].toString().replaceAll("'", "`") + "'";
          } else {
            query = query + "'" + data[k].toString().replaceAll("'", "`") + "'" + ',';
          }
        });
        if (datas.last == data) {
          query = query + ')';
        } else {
          query = query + '),';
        }
      });
      await db.execute('''$query''');
    } else {
      int iMax = (datas.length / chunkSize.toDouble()).ceil();
      // devPrint('Imax: ' + iMax.toString());
      for (int i = 1; i <= iMax; i++) {
        String query = "INSERT INTO $table (";
        Iterable<String> columns = datas[0].keys;
        // devPrint(columns);
        columns.forEach((k) {
          if (columns.last == k) {
            query = query + '$k) VALUES ';
          } else {
            query = query + '$k,';
          }
        });
        int jMax = iMax == i ? ((i - 1) * chunkSize) + datas.length % chunkSize : (i * chunkSize);
        // devPrint(jMax);
        for (int j = (i - 1) * chunkSize; j < jMax; j++) {
          Map<String, dynamic> data = datas[j];
          query = query + '(';
          columns.forEach((k) {
            if (k == 'created_at' || k == 'updated_at' || k == 'deleted_at' || k == 'item_sync_at' || k == 'date' || k == 'time' || k.contains('date')) {
              // devPrint(k + ' : ' + data[k].toString() + ' Length');
              if (data[k].toString().length > 0 && data[k] != null && data[k] != Null && data[k] != '' && data[k] != 'null') {
                data[k] = DateTime.parse(data[k]).millisecondsSinceEpoch;
                // devPrint(data[k]);
              } else {
                data[k] = null;
              }
            }
            if (columns.last == k) {
              query = query + "'" + data[k].toString().replaceAll("'", "`") + "'";
            } else {
              query = query + "'" + data[k].toString().replaceAll("'", "`") + "'" + ',';
            }
          });
          if (jMax - 1 == j) {
            query = query + ')';
          } else {
            query = query + '),';
          }
        }
        await db.execute('''$query''');
      }
    }
  }

  deleteAllRows(String table) async {
    Database db = await instance.database;
    await db.rawQuery('DELETE FROM $table');
  }

  deleteAllRowsFilter(String table, String filter) async {
    Database db = await instance.database;
    devPrint('DELETE FROM $table $filter');
    await db.rawQuery('DELETE FROM $table $filter');
  }
}
