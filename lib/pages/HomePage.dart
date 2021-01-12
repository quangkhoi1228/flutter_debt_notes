import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wallet_exe/event/HomePageEvent.dart';
import 'package:wallet_exe/pages/TransactionPage.dart';
import 'package:wallet_exe/utils/DBHelper.dart';
import 'package:wallet_exe/utils/SnbForm.dart';
import 'package:wallet_exe/utils/Util.dart';

import '../model/Tbtransaction.dart';
import '../themes/Css.dart';
import '../utils/DBHelper.dart';

enum _SelectedTab { account, home, history }

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageEvent homePageEvent;

  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  void initState() {
    homePageEvent = new HomePageEvent(this);

    DbHelper.init().then((value) {
      homePageEvent.loadData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Util.newPage(context, TransactionPage(), null);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Css.isPrimary,
      ),
      body: buildBody(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Css.isLight),
          ),
        ),
        child: SalomonBottomBar(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          onTap: _handleIndexChanged,
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.account_circle_outlined),
              title: Text("Tài khoản"),
              selectedColor: Css.isPrimary,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.home_outlined),
              title: Text("Tổng quan"),
              selectedColor: Css.isPrimary,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.history),
              title: Text("Lịch sử"),
              selectedColor: Css.isPrimary,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    switch (_SelectedTab.values.indexOf(_selectedTab)) {
      case 0:
        return buildHistoryTab();
        break;
      case 1:
        return buildOverviewTab();
        break;
      case 2:
        return buildHistoryTab();
        break;
      default:
        return buildHistoryTab();
        break;
    }
  }

  Widget buildHistoryTab() {
    return Container(
      color: Css.isWhite,
      child: homePageEvent.buildTableTransaction(),
    );
  }

  Widget buildOverviewTab() {
    return Container(
      padding: EdgeInsets.all(Css.padding),
      color: Css.isLight,
      child: ListView(
        children: <Widget>[
          homePageEvent.buildOverview(),
          Container(
            decoration: BoxDecoration(
                color: Css.isWhite, borderRadius: Css.borderRadius),
            margin: EdgeInsets.only(top: Css.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SnbLabel(
                //   color: Css.isText,
                //   text: 'Danh sách',
                //   fontSize: Css.fontSizeMedium,
                // ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // new line
                  itemCount: homePageEvent.listDebtByUser.length,
                  itemBuilder: (context, index) {
                    print(homePageEvent.listDebtByUser[index]);
                    var data = homePageEvent.listDebtByUser[index];
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(Css.padding),
                      child: Row(
                        children: [
                          Container(
                            height: Css.fontSize * 4,
                            width: Css.fontSize * 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Css.avatarBorderRadius),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/avatar.png"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              padding: EdgeInsets.only(left: Css.padding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text(
                                    data['name'],
                                    style: TextStyle(
                                        color: Css.isText,
                                        fontSize: Css.fontSizeMedium,
                                        fontWeight: Css.fontWeightBold),
                                  ),
                                  Text(
                                    Util.formatNumber(data['amount']),
                                    style: TextStyle(
                                        color: Colors.blue[700],
                                        fontSize: Css.fontSizeMedium,
                                        fontWeight: Css.fontWeightBold),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // homePageEvent.buildTableTransaction(),
          // FlatButton(
          //     onPressed: () {
          //       var currentDate = DateTime.now();

          //       DbHelper.query(
          //           query:
          //               'insert into tbtransaction(name,amount,createddate,description,status) values("Cường","10000","$currentDate","des",true)');

          //       homePageEvent.loadData();
          //       setState(() {});
          //     },
          //     child: Text('a')),
          // FlatButton(
          //     onPressed: () {
          //       var currentDate = DateTime.now();
          //       print(currentDate);
          //       DbHelper.query(
          //           query:
          //               'insert into tbtransaction(name,amount,createddate,description,status) values("Khôi","-10000","$currentDate","des",true)');

          //       homePageEvent.loadData();
          //       setState(() {});
          //     },
          //     child: Text('b')),
          // FlatButton(
          //     onPressed: () {
          //       print('remove');
          //       DbHelper.truncateTable('transaction');
          //     },
          //     child: Text('remove'))
        ],
      ),
    );
  }
}
