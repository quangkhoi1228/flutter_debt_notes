import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_exe/model/Tbtransaction.dart';

enum DBQueryResultType { select, insert, update, delete, undefined }

class DBQueryResult {
  DBQueryResultType type;
  dynamic data;
  String query;
}

class DbHelper {
  static String databaseName = 'debt_walet.db';
  static Future<Database> database;

  static Future<void> init({Function onCreate}) async {
    DbHelper.database = createDatabase(onCreate: (db, version) {
      db.execute(
          'CREATE TABLE tbtransaction(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount DECIMAL, createddate DATETIME, description TEXT, status BOOLEAN)');
      if (onCreate != null) {
        onCreate();
      }
    });
  }

  static void query({@required String query, Function callback}) async {
    DBQueryResult result = new DBQueryResult();
    result.query = query;
    String lowercase = query.toLowerCase();
    DbHelper.database.then((db) {
      if (lowercase.startsWith('select')) {
        result.type = DBQueryResultType.select;
        db.rawQuery(query).then((dataList) {
          result.data = dataList;
          if (callback != null) {
            callback(result);
          }
        });
      } else if (lowercase.startsWith('insert')) {
        result.type = DBQueryResultType.insert;
        db.rawInsert(query).then((value) {
          result.data = value;
          if (callback != null) {
            callback(result);
          }
        });
      } else {
        result.type = DBQueryResultType.undefined;
        db.execute(query).then((value) {
          result.data = null;
          if (callback != null) {
            callback(result);
          }
        });
      }
    });
  }

  static Future<Database> createDatabase({Function onCreate}) {
    return getDatabasesPath().then((defaultUrl) {
      return openDatabase(join(defaultUrl, DbHelper.databaseName),
          version: 1, onCreate: onCreate);
    });
  }

  static void select({@required String table, @required Function callback}) {
    DbHelper.query(query: 'SELECT * from $table', callback: callback);
  }

  static void truncateTable(String table) {
    DbHelper.query(query: 'DELETE FROM tbtransaction');
    // DBHelper.query(query: 'DROP table tbtransaction');
    print('truncate table $table');
  }
}
