import 'package:flutter_money_formatter/flutter_money_formatter.dart';

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
}
