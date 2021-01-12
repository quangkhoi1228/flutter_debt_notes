import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wallet_exe/event/TransactionPageEvent.dart';

import 'package:wallet_exe/utils/DBHelper.dart';
import 'package:wallet_exe/utils/SnbForm.dart';

import '../model/Tbtransaction.dart';
import '../themes/Css.dart';
import '../utils/DBHelper.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({Key key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TransactionPageEvent transactionPageEvent;

  @override
  void initState() {
    transactionPageEvent = new TransactionPageEvent(this);

    DbHelper.init(onCreate: (db, version) {
      Tbtransaction().createTable();
    }).then((value) {
      transactionPageEvent.loadData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Thêm giao dịch', style: TextStyle(color: Css.isWhite)),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Css.isWhite,
            onPressed: () {
              Navigator.pop(context, false);
            }),
      ),
      body: Container(
          padding: EdgeInsets.all(Css.padding),
          color: Css.isLight,
          child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term'),
              )
            ],
          )),
    );
  }
}
