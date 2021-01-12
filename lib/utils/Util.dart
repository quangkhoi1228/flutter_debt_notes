import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

enum SortType { asc, desc }
enum SnbSize { small, normal, medium, large }

class Util {
  static double getNumber(var input) {
    if (input.runtimeType == String) {
      input = double.parse(input);
    }
    if (input.runtimeType == int) {
      input = double.parse(input.toString());
    }
    return input;
  }

  static String formatNumber(var input, {options}) {
    input = getNumber(input);
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(amount: input);

    var value = fmf.output.withoutFractionDigits;
    var decimal = fmf.output.fractionDigitsOnly;
    String result = value;
    double decimalDouble = getNumber(decimal);
    if (decimalDouble != 0) {
      while (decimal.endsWith('0')) {
        decimal = decimal.substring(0, decimal.length - 1);
      }
      result += '.' + decimal;
    }

    return result;
  }

  static void newPage(context, page, Map<String, dynamic> options) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void replacePage(context, page, Map<String, dynamic> options) {
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static setTimeout(callback, timeout) {
    int duration = timeout;
    Timer timer = Timer(Duration(milliseconds: duration), () {
      callback();
    });
    return timer;
  }

  static setInterval(callback, timeout) {
    return Timer.periodic(new Duration(milliseconds: timeout), (timer) {
      callback();
    });
  }

  static sortListWithProperties(List data, String properties,
      {SortType sortType}) {
    sortType = (sortType == null || sortType == SortType.asc)
        ? SortType.asc
        : SortType.desc;
    data.sort((a, b) {
      int sortStatus = 0;
      if (a[properties] == null && b[properties] == null) {
        sortStatus = 0;
      } else if (a[properties] == null && b[properties] != null) {
        sortStatus = -1;
      } else if (a[properties] != null && b[properties] == null) {
        sortStatus = 1;
      } else {
        if (a[properties] < b[properties]) {
          sortStatus = -1;
        } else if (a[properties] > b[properties]) {
          sortStatus = 1;
        } else {
          sortStatus = 0;
        }
      }

      if (sortType == SortType.desc) {
        sortStatus = -sortStatus;
      }
      return sortStatus;
    });

    return data;
  }

  static String getFormatDate(String input,
      {inputFormat: 'yyyy-MM-dd', format: 'dd-MM-yyyy'}) {
    String yearInput = input.substring(
        inputFormat.indexOf('yyyy'), inputFormat.indexOf('yyyy') + 4);
    String partern = '$yearInput';

    if (inputFormat.indexOf('MM') > 0) {
      String monthInput = input.substring(
          inputFormat.indexOf('MM'), inputFormat.indexOf('MM') + 2);
      partern += '-$monthInput';
    }
    if (inputFormat.indexOf('dd') > 0) {
      String dayInput = input.substring(
          inputFormat.indexOf('dd'), inputFormat.indexOf('dd') + 2);
      partern += '-$dayInput';
    }
    if (inputFormat.indexOf('hh') > 0) {
      String hourInput;
      if (input.length > inputFormat.indexOf('hh') + 2) {
        hourInput = input.substring(
            inputFormat.indexOf('hh'), inputFormat.indexOf('hh') + 2);
      } else {
        hourInput = '00';
      }

      partern += ' $hourInput';
    }

    if (inputFormat.indexOf('mm') > 0) {
      String minuteInput;
      if (input.length > inputFormat.indexOf('mm') + 2) {
        minuteInput = input.substring(
            inputFormat.indexOf('mm'), inputFormat.indexOf('mm') + 2);
      } else {
        minuteInput = '00';
      }
      partern += ':$minuteInput';
    }

    if (inputFormat.indexOf('ss') > 0) {
      String secondInput;
      if (input.length > inputFormat.indexOf('ss') + 2) {
        secondInput = input.substring(
            inputFormat.indexOf('ss'), inputFormat.indexOf('ss') + 2);
      } else {
        secondInput = '00';
      }
      partern += ':$secondInput';
    }

    DateTime date = DateTime.parse(partern);
    String year = date.year.toString();
    String month =
        date.month < 10 ? '0' + date.month.toString() : date.month.toString();
    String day =
        date.day < 10 ? '0' + date.day.toString() : date.day.toString();
    String hour =
        date.hour < 10 ? '0' + date.hour.toString() : date.hour.toString();
    String minute = date.minute < 10
        ? '0' + date.minute.toString()
        : date.minute.toString();
    String second = date.second < 10
        ? '0' + date.second.toString()
        : date.second.toString();

    return format
        .replaceAll('yyyy', year)
        .replaceAll('MM', month)
        .replaceAll('dd', day)
        .replaceAll('hh', hour)
        .replaceAll('mm', minute)
        .replaceAll('ss', second);
  }
}
