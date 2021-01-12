import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_exe/utils/DBHelper.dart';
import 'package:wallet_exe/utils/Util.dart';

import '../themes/Css.dart';

class TransactionPageEvent {
  State state;
  TransactionPageEvent(this.state);
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int total = 0;
  List<Map<String, dynamic>> listTransaction = [];

  void loadData() {}
}
