import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_exe/utils/DBHelper.dart';
import 'package:wallet_exe/utils/Util.dart';

import '../themes/Css.dart';

class HomePageEvent {
  State state;
  HomePageEvent(this.state);
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int total = 0;
  List<Map<String, dynamic>> listTransaction = [];

  void loadData() {
    DBHelper.query(
        query:
            'SELECT SUM(amount) as total FROM tbtransaction WHERE status = true ',
        callback: (result) {
          print(result.data);
          var total = result.data[0]['total'];
          print(total);
          if (total != null)
            state.setState(() {
              this.total = total;
            });
        });
    DBHelper.select(
        table: 'tbtransaction',
        callback: (result) {
          state.setState(() {
            this.listTransaction = result.data;
          });
        });
  }

  Widget buildOverview() {
    return Container(
      margin: EdgeInsets.all(Css.padding),
      padding: EdgeInsets.only(
          top: Css.paddingLarge, left: Css.padding, bottom: Css.paddingLarge),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: Css.borderRadius),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tổng cộng',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Css.isLight,
            ),
          ),
          Text(Util.formatNumber(total),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Css.isWhite,
                fontSize: Css.fontSizeLarge,
                fontWeight: Css.fontWeightBold,
              )),
        ],
      ),
    );
  }

  Widget buildTableTransaction() {
    return Container(
      // margin: EdgeInsets.all(Css.padding),
      decoration: BoxDecoration(
        color: Css.isWhite,
        borderRadius: Css.borderRadius,
      ),
      child: DataTable(
        columns: [
          DataColumn(label: Text('Tên')),
          DataColumn(label: Text('Số tiền')),
        ],
        rows: List.generate(listTransaction.length,
            (index) => _getDataRow(listTransaction[index])),
      ),
    );
  }

  DataRow _getDataRow(data) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(data["name"])),
        DataCell(Text(Util.formatNumber(data["amount"].toString()))),
      ],
    );
  }
}
