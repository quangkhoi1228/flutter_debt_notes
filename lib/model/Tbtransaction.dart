import 'package:wallet_exe/utils/DBHelper.dart';

class Tbtransaction {
  final int id;
  String name;
  double amount;
  DateTime createddate;
  String description;
  bool status;
  Tbtransaction(
      {this.id,
      this.name,
      this.amount,
      this.createddate,
      this.description,
      this.status});

  void createTable() {
    DBHelper.query(
        query:
            'CREATE TABLE tbtransaction(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount DECIMAL, createddate DATETIME, description TEXT, status BOOLEAN)');
  }

  void truncate() {
    DBHelper.truncateTable('tbtransaction');
  }
}
