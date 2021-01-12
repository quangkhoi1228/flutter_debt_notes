import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:smart_select/smart_select.dart';
import 'package:wallet_exe/utils/AppTheme.dart';
import 'package:wallet_exe/utils/StyleSheet.dart';

class SnbForm {
  static double inputSize = 35;
  static double fontSize = StyleSheet.fontSizeSmall;

  static List<DropdownMenuItem<Map<String, dynamic>>> getDropDownMenuItems(
      List<Map<String, dynamic>> listItem) {
    List<DropdownMenuItem<Map<String, dynamic>>> items = new List();
    listItem.asMap().forEach((index, Map<String, dynamic> item) {
      items.add(new DropdownMenuItem(
        value: item,
        child: Container(
          padding: EdgeInsets.all(StyleSheet.padding),
          decoration: BoxDecoration(
              border: (index > 0)
                  ? Border(top: BorderSide(color: StyleSheet.isGrey, width: 1))
                  : Border()),
          child: Row(
            children: <Widget>[
              Flexible(
                child: new Text(item['innerText'],
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(backgroundColor: StyleSheet.isTransparent)),
              ),
            ],
          ),
        ),
      ));
    });
    return items;
  }

  static Widget fieldItem({int flex, @required Widget child, bool isLast}) {
    flex = (flex == null) ? flex = 5 : flex;
    isLast = (isLast == null) ? false : isLast;
    EdgeInsets padding = (isLast == false)
        ? EdgeInsets.only(right: StyleSheet.paddingSmall)
        : EdgeInsets.all(0);
    return Expanded(flex: flex, child: Padding(padding: padding, child: child));
  }

  static Widget dropdown(
      {@required State state,
      Function onChange,
      TemplateTheme theme,
      @required TextEditingController controller,
      String hintText,
      @required List<Map<String, dynamic>> optionList}) {
    TemplateTheme currentTheme = (theme == null) ? TemplateTheme.dark : theme;

    TextEditingController controllerText = new TextEditingController();
    if (hintText == null) {
      hintText = '';
    }
    dynamic changeText() {
      if (controller.text.trim() == '') {
        controllerText.text = hintText;
      } else {
        optionList.forEach((element) {
          if (element['value'] == controller.text) {
            controllerText.text = element['title'];
            return element;
          }
          return null;
        });
      }
    }

    if (controller.text != null) {
      changeText();
    }

    return Container(
      child: SmartSelect<String>.single(
        modalStyle: S2ModalStyle(
          backgroundColor: StyleSheet.isLight,
        ),
        choiceStyle: S2ChoiceStyle(
          color: StyleSheet.isLightBlack,
          activeColor: StyleSheet.secondary,
        ),
        tileBuilder: (context, state) {
          return GestureDetector(
            onTap: state.showModal,
            child: Container(
                color: StyleSheet.isGrey,
                padding: EdgeInsets.only(
                  right: StyleSheet.paddingSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: 9,
                        child: SnbInput(
                          child: TextField(
                            controller: controllerText,
                            enabled: false,
                            style: TextStyle(color: StyleSheet.isLightBlack),
                            decoration: new InputDecoration(
                              hintText: hintText,
                              hintStyle:
                                  TextStyle(color: StyleSheet.isLightBlack),
                              border: OutlineInputBorder(),
                              contentPadding: StyleSheet.paddingInput,
                            ),
                          ),
                        )),
                    Icon(
                      FontAwesomeIcons.caretDown,
                      color: StyleSheet.isLightBlack,
                    ),
                  ],
                )),
          );
        },
        modalType: S2ModalType.bottomSheet,
        modalFilter: true,
        modalTitle: hintText,
        choiceItems: S2Choice.listFrom<String, Map<String, dynamic>>(
          source: optionList,
          value: (index, item) => item['value'],
          title: (index, item) => item['title'],
        ),
        value: (controller == null) ? null : controller.text,
        onChange: (S2SingleState<String> value) {
          controller.text = value.value;
          dynamic currentItem = changeText();
          if (onChange != null) {
            onChange(currentItem);
          }
        },
      ),
    );
  }

  static Widget radioGroup(
      {@required String name,
      @required List<RadioItem> radioItems,
      @required Function onChange}) {
    List<Widget> items = [];
    if (radioItems == null) {
      radioItems = [];
    }
    radioItems.forEach((item) {
      items.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: StyleSheet.fontSize * 1.5,
              height: StyleSheet.fontSize * 1.25,
              child: new Radio(
                  value: item.value, groupValue: name, onChanged: onChange),
            ),
            Container(
              padding: EdgeInsets.only(
                left: StyleSheet.paddingSmall,
                right: StyleSheet.padding,
              ),
              child: Text(item.text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: StyleSheet.isLightBlack,
                    fontSize: StyleSheet.fontSize,
                  )),
            ),
          ]));
    });

    return Theme(
      data: ThemeData(
          unselectedWidgetColor: StyleSheet.isLightBlack,
          accentColor: StyleSheet.secondary),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: items,
        ),
      ),
    );
  }

  static Widget checkbox(
      {@required bool name,
      @required String text,
      @required Function onChange}) {
    return Theme(
      data: ThemeData(
          unselectedWidgetColor: StyleSheet.isLightBlack,
          accentColor: StyleSheet.secondary),
      child: Container(
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: StyleSheet.fontSize * 1.5,
                height: StyleSheet.fontSize * 1.25,
                child: Checkbox(
                  value: name,
                  activeColor: StyleSheet.secondary,
                  onChanged: onChange,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                ),
              ),
              Flexible(
                flex: 10,
                child: Container(
                  padding: EdgeInsets.only(left: StyleSheet.paddingSmall),
                  child: Text(text,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: StyleSheet.isLightBlack)),
                ),
              ),
            ],
          ),
          onTap: () {
            onChange(!name);
          },
        ),
      ),
    );
  }

  static Widget field({@required child, bool isLast}) {
    isLast = (isLast == null) ? false : isLast;
    double padding =
        (isLast == true) ? StyleSheet.paddingLarge : StyleSheet.padding;
    return Container(
      margin: EdgeInsets.only(bottom: padding),
      child: child,
    );
  }

  static Widget input({
    String hintText = '',
    @required TextEditingController controller,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: StyleSheet.isGrey,
      ),
      child: Theme(
        data: new ThemeData(hintColor: StyleSheet.isLightBlack),
        child: SnbInput(
          child: TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: hintText,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: StyleSheet.isGrey, width: 1.0),
                ),
                border: OutlineInputBorder(),
                contentPadding: StyleSheet.paddingInput,
                focusColor: StyleSheet.isLightBlack,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide:
                        BorderSide(width: 2, color: StyleSheet.secondary))),
          ),
        ),
      ),
    );
  }
}

class RadioItem {
  final String text;
  final String value;
  RadioItem({
    @required this.text,
    @required this.value,
  });
}

// ignore: must_be_immutable
class SnbLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  final Color color;
  final bool isRequired;
  const SnbLabel(
      {Key key,
      this.text,
      this.isRequired,
      this.fontSize,
      this.fontWeight,
      this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String text = this.text;
    Color color = (this.color == null) ? StyleSheet.isWhite : this.color;
    double fontSize =
        (this.fontSize == null) ? StyleSheet.fontSize : this.fontSize;
    bool isRequired = (this.isRequired == null) ? false : this.isRequired;
    FontWeight fontWeight =
        (this.fontWeight == null) ? FontWeight.w700 : this.fontWeight;

    try {
      Widget returnWidget = Padding(
          padding: EdgeInsets.only(bottom: StyleSheet.paddingSmall),
          child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: color, fontSize: fontSize, fontWeight: fontWeight),
                  children: (isRequired)
                      ? [
                          TextSpan(text: text),
                          TextSpan(
                              text: '*',
                              style: TextStyle(
                                  color: StyleSheet.isDanger,
                                  fontSize: fontSize))
                        ]
                      : [
                          TextSpan(text: text),
                        ])));

      return returnWidget;
    } catch (e) {
      throw UnimplementedError(e);
    }
  }
}

// ignore: must_be_immutable
class SnbInput extends StatelessWidget {
  final Widget child;
  const SnbInput({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    try {
      Widget returnWidget = Container(height: SnbForm.inputSize, child: child);
      return returnWidget;
    } catch (e) {
      throw UnimplementedError();
    }
  }
}

class SnbSelectOption {
  final Map<String, dynamic> value;
  final String innerText;
  const SnbSelectOption({Key key, this.value, this.innerText});
  Map<String, dynamic> build(BuildContext context) {
    try {
      Map<String, dynamic> option = {
        'value': value,
        'innerText': innerText,
      };
      return option;
    } catch (e) {
      throw UnimplementedError();
    }
  }
}

// ignore: must_be_immutable
class SnbSelect extends StatelessWidget {
  final Widget child;
  final TemplateTheme theme;
  SnbSelect({
    Key key,
    this.child,
    this.theme,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    try {
      Widget child = this.child;

      Widget returnWidget = Theme(
          data: ThemeData(
              brightness: Brightness.dark, canvasColor: Color(0xff243448)),
          child: Container(
            padding: EdgeInsets.only(left: StyleSheet.paddingSmall),
            height: SnbForm.inputSize,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white54),
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: new DropdownButtonHideUnderline(
              child: child,
            ),
          ));
      return returnWidget;
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
