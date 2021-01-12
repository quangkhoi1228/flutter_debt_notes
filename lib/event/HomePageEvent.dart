import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_exe/utils/DBHelper.dart';
import 'package:wallet_exe/utils/SnbForm.dart';
import 'package:wallet_exe/utils/Util.dart';

import '../themes/Css.dart';

class HomePageEvent {
  State state;
  HomePageEvent(this.state);
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int total = 0;
  List<Map<String, dynamic>> listDebtByUser = [];

  List<Map<String, dynamic>> listTransaction = [];

  void loadData() {
    //query total
    DbHelper.query(
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

    //query list debt group by user
    DbHelper.query(
        query:
            'SELECT name, SUM(amount) as amount FROM tbtransaction GROUP BY name HAVING status = true ORDER BY amount DESC',
        callback: (result) {
          state.setState(() {
            this.listDebtByUser = result.data;
            print(listDebtByUser);
          });
        });

    //query list transaction
    DbHelper.query(
        query: 'SELECT * FROM tbtransaction ORDER BY createddate DESC',
        callback: (result) {
          state.setState(() {
            this.listTransaction = result.data;
          });
        });
  }

  Widget buildOverview() {
    return Container(
      padding: EdgeInsets.only(
          top: Css.paddingLarge, left: Css.padding, bottom: Css.paddingLarge),
      decoration: BoxDecoration(
          image: Css.mainBackgroundImage, borderRadius: Css.borderRadius),
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
      padding: EdgeInsets.only(
        top: Css.padding * 3,
      ),
      width: double.infinity,
      decoration: BoxDecoration(image: Css.mainBackgroundImage),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Padding(
              padding: EdgeInsets.all(Css.padding),
              child: SnbLabel(
                fontSize: Css.fontSizeLarge,
                text: 'Lịch sử',
              ),
            ),
          ),
          Positioned(
            top: Css.fontSize * 5,
            width: MediaQuery.of(state.context).size.width,
            child: Container(
              padding: EdgeInsets.only(bottom: Css.paddingLarge),
              decoration: BoxDecoration(
                  color: Css.isWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Css.avatarBorderRadius),
                      topRight: Radius.circular(Css.avatarBorderRadius))),
              child: DataTable(columns: [
                DataColumn(label: Text('Tên')),
                DataColumn(
                  label: Text('Số tiền'),
                  numeric: true,
                ),
                DataColumn(label: Text('Thời gian')),
              ], rows: []),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Css.fontSize * 8),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: Css.isPrimary),
              ),
              color: Css.isWhite,
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: Css.padding * 6),
                child: DataTable(
                  headingRowHeight: 0,
                  columns: [
                    DataColumn(
                        label: Visibility(
                      visible: false,
                      child: Text(
                        'Tên',
                      ),
                    )),
                    DataColumn(
                        numeric: true,
                        label: Visibility(
                          visible: false,
                          child: Text(
                            'Số tiền',
                          ),
                        )),
                    DataColumn(
                        label: Visibility(
                      visible: false,
                      child: Text(
                        'Thời gian',
                      ),
                    )),
                  ],
                  rows: List.generate(listTransaction.length,
                      (index) => _getDataRow(listTransaction[index])),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _getDataRow(data) {
    print(data);
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(data["name"])),
        DataCell(Text(Util.formatNumber(data["amount"].toString()))),
        DataCell(Text(
            Util.getFormatDate(data["createddate"], format: 'dd/MM/yyyy'))),
      ],
    );
  }
}
