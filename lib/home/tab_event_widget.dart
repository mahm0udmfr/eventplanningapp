import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:flutter/material.dart';

class TabEventWidget extends StatelessWidget {
  String eventName;
  bool isSelected;
  TabEventWidget(
      {super.key, required this.eventName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.04,
            vertical: screenSize.height * 0.005),
        decoration: BoxDecoration(
            color: isSelected ? AppColor.whiteColor : AppColor.transparentColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.whiteColor, width: 2)),
        child: Text(eventName,
            style: isSelected
                ? TextStyle(
                    color: AppColor.primarylLight,
                    fontFamily: FontsName.inter,
                    fontSize: 16)
                : TextStyle(
                    color: AppColor.whiteColor,
                    fontFamily: FontsName.inter,
                    fontSize: 16)));
  }
}
