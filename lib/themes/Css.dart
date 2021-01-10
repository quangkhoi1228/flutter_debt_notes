import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Css {
  static Color isPrimary = Color(0xfffca072);
  static Color isSecondary = Color(0xffe4d9c9);

  static Color mainBackground = Color(0xfff5f5f5);

  static double searchHeight = 35.0;
  static double pageMenuHeight = (Platform.isAndroid) ? 50 : 50;
  static double pageTitleHeight = (Platform.isAndroid) ? 86 : 134;
  static double pageTitleAndMenuHeight = pageTitleHeight + pageMenuHeight;
  static double titleSize = 14.0;
  static double subtitleSize = 12.0;
  static double bodySize = 12.0;

  static Color modalTextColor = Colors.white;
  static Color modalAcceptButtonColor = Colors.white;
  static Color modalRejectButtonColor = Colors.white;
  static Color modalCloseButtonColor = Colors.white;

  static double padding = 15.0;
  static double paddingSmall = 5.0;
  static double paddingMedium = 20.0;
  static double paddingLarge = 25.0;
  static double paddingElement = fontSize * 1.5;

  static EdgeInsets paddingInput =
      EdgeInsets.only(top: 5.0, right: 10.0, bottom: 5.0, left: 10.0);

  static double fontSize = 15.0;
  static double fontSizeSmall = 10.0;
  static double fontSizeMedium = 20.0;
  static double fontSizeLarge = 30.0;

  static FontWeight fontWeight = FontWeight.normal;
  static FontWeight fontWeightLight = FontWeight.w400;
  static FontWeight fontWeightMedium = FontWeight.w500;
  static FontWeight fontWeightBold = FontWeight.bold;

  static double avatarBorderRadius = 30.0;
  static double avatarBorderRadiusSmall = 15.0;
  static double avatarBorderRadiusMedium = 50.0;
  static double avatarBorderRadiusLarge = 80.0;

  static BorderRadius borderRadius = BorderRadius.circular(10.0);
  static BorderRadius borderRadiusRounded =
      BorderRadius.circular(avatarBorderRadiusLarge);

  static Color primaryColor = Color(0xff243448);
  static Color secondaryColor = Color(0xff212b5f);
  static Color borderColor = Color(0xff848d95);
  static Color canvasColor = Color(0xff1e2733);
  static Color isWarning = Color(0xfff16631);
  static Color isDanger = Color(0xffff3860);
  static final Color isLight = Color(0xf5f5f5f5);
  static Color isRed = Color(0xffed3536);
  static Color isYellow = Color(0xffffd900);
  static Color isGreen = Color(0xff3ac426);
  static Color isGreenDark = Color(0xff008f41);

  static Color isWhite = Colors.white;
  static Color isBlack = Colors.black;
  static Color isDark = Color(0x36363636);
  static Color isLightBlack = Color(0xff6d6a6a);
  static Color isTransparent = Colors.transparent;

  static Color isGrey = Color(0xdddddddd);
  static Color isText = Color(0x1b1b1616);

  static double navbarheight = 80.0;
  static double tabHeight = 40.0;

  static Color tableOldRowColor = primaryColor;
  static Color tableEvenRowColor = Color(0xff2d394a);

  static double getHeight(context, String patern) {
    double value;
    if (patern.contains('%')) {
      value = MediaQuery.of(context).size.height *
          double.parse(patern.replaceAll('%', '')) /
          100;
    }
    return value;
  }

  static double fontSizeNews = 18.0;

  static Color isNewsText = Color(0xffdee0e2);
  static Color isOrange = Color(0xfff16631);

  static Color primary = Color.fromRGBO(0, 35, 103, 1);
  static Color secondary = Color(0xfff16631);

  static double chartProfitHeight = 220.0;

  static var routeSetting = RouteSettings();

  static RouteSettings makeRouteSetting(String name) {
    return RouteSettings(name: name);
  }

  static double borderWidth = 2.0;

  static double carouselHeight = 225.0;

  static double searchIconSize = 25.0;
}
