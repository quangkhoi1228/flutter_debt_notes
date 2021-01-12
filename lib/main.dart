import 'package:flutter/material.dart';
import 'package:wallet_exe/model/Tbtransaction.dart';
import 'package:wallet_exe/pages/HomePage.dart';
import 'package:wallet_exe/themes/Css.dart';
import 'package:wallet_exe/utils/DBHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Debt notes',
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.light,
        primaryColor: Css.isPrimary,
        accentColor: Css.isSecondary,
        // Define the default font family.
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}
