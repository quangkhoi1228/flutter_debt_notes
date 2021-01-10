import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:wallet_exe/event/HomeEvent.dart';
import 'package:wallet_exe/utils/DBHelper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeEvent homeEvent;

  @override
  void initState() {
    DBHelper.init();
    homeEvent = new HomeEvent(this);
    homeEvent.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => NewTransactionPage()),
            // );

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
          backgroundColor: Theme.of(context).primaryColor,
        ),
        appBar: AppBar(
          title: Text('Tổng quan'),
        ),
        body: ListView(children: <Widget>[
          homeEvent.buildTableTransaction(),
          FlatButton(
              onPressed: () {
                print('a');
                // DBHelper.insertDog(Dog(age: 2, id: 3, name: '4'));
                DBHelper.query(
                    query:
                        'insert into tbtransaction(name,amount,createddate,description,status) values("Hiệp","10000","2020-01-10","des",true)');
              },
              child: Text('a'))
        ]));
  }
}
