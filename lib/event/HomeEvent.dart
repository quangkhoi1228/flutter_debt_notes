import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_exe/utils/DBHelper.dart';

class HomeEvent {
  State state;
  HomeEvent(this.state);
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void loadData() {
    DBHelper.select(
        table: 'tbtrasaction',
        callback: (data) {
          print(data.toString());
        });
  }

  Widget buildTableTransaction() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Tên')),
        DataColumn(label: Text('Số tiền')),
        DataColumn(label: Text('Số lần')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('Hiệp')),
          DataCell(Text('1')),
          DataCell(Text('2')),
        ]),
        DataRow(cells: [
          DataCell(Text('Hiệp')),
          DataCell(Text('1')),
          DataCell(Text('2')),
        ]),
        DataRow(cells: [
          DataCell(Text('Hiệp')),
          DataCell(Text('1')),
          DataCell(Text('2')),
        ]),
      ],
    );
  }
}
