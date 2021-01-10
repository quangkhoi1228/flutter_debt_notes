import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum DBQueryResultType { select, insert, update, delete, undefined }

class DBQueryResult {
  DBQueryResultType type;
  dynamic data;
  String query;
}

class DBHelper {
  static String databaseName = 'debt_walet.db';
  static Future<Database> database;

  static Future<void> init({Function onCreate}) async {
    DBHelper.database = createDatabase(onCreate: onCreate);
  }

  static void query({@required String query, Function callback}) async {
    DBQueryResult result = new DBQueryResult();
    result.query = query;
    String lowercase = query.toLowerCase();
    DBHelper.database.then((db) {
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
      return openDatabase(join(defaultUrl, DBHelper.databaseName),
          version: 1, onCreate: onCreate);
    });
  }

  static void select({@required String table, @required Function callback}) {
    DBHelper.query(query: 'SELECT * from $table', callback: callback);
  }

  static void truncateTable(String table) {
    DBHelper.query(query: 'DELETE FROM tbtransaction');
    // DBHelper.query(query: 'DROP table tbtransaction');
    print('truncate table $table');
  }
}
