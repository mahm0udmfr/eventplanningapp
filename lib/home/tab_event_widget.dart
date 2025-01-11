import 'package:eventplanningapp/utils/colors.dart';
import 'package:flutter/material.dart';

class TabEventWidget extends StatelessWidget {
  String eventName;
  bool isSelected;
  Color backGroundColor;
  Color? bordercolor;
  TextStyle textSelectedStyle;
  TextStyle textUnSelectedStyle;

  TabEventWidget(
      {super.key,
      required this.eventName,
      required this.isSelected,
      required this.backGroundColor,
      required this.textSelectedStyle,
      required this.textUnSelectedStyle,
      this.bordercolor});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.04,
            vertical: screenSize.height * 0.006),
        decoration: BoxDecoration(
            color: isSelected ? backGroundColor : AppColor.transparentColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: bordercolor ?? AppColor.whiteColor, width: 2)),
        child: Text(eventName,
            style: isSelected ? textSelectedStyle : textUnSelectedStyle));
  }
}
