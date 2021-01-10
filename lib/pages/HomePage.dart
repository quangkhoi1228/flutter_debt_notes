import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wallet_exe/event/HomePageEvent.dart';
import 'package:wallet_exe/utils/DBHelper.dart';

import '../model/Tbtransaction.dart';
import '../themes/Css.dart';
import '../utils/DBHelper.dart';

enum _SelectedTab { home, likes, search, profile }

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

    DBHelper.init(onCreate: (db, version) {
      Tbtransaction().createTable();
    });
    homePageEvent.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DBHelper.select(
              table: 'tbtransaction',
              callback: (result) {
                print(result.type);
                print(result.data.toString());
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Css.isPrimary,
      ),
      // appBar: AppBar(
      //   title: Text('Tổng quan'),
      // ),
      body: Container(
        color: Css.isLight,
        child: ListView(
          children: <Widget>[
            homePageEvent.buildOverview(),
            homePageEvent.buildTableTransaction(),
            FlatButton(
                onPressed: () {
                  print('a');
                  // DBHelper.insertDog(Dog(age: 2, id: 3, name: '4'));
                  DBHelper.query(
                      query:
                          'insert into tbtransaction(name,amount,createddate,description,status) values("Hiệp","10000","2020-01-10","des",true)');

                  homePageEvent.loadData();
                  setState(() {});
                },
                child: Text('a')),
            FlatButton(
                onPressed: () {
                  print('b');
                  // DBHelper.insertDog(Dog(age: 2, id: 3, name: '4'));
                  DBHelper.query(
                      query:
                          'insert into tbtransaction(name,amount,createddate,description,status) values("Hiệp","-10000","2020-01-10","des",true)');

                  homePageEvent.loadData();
                  setState(() {});
                },
                child: Text('b')),
            FlatButton(
                onPressed: () {
                  print('remove');
                  DBHelper.truncateTable('transaction');
                },
                child: Text('remove'))
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        onTap: _handleIndexChanged,
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text("Tổng quan"),
            selectedColor: Css.isPrimary,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.history),
            title: Text("Lịch sử"),
            selectedColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
