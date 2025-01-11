import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:flutter/material.dart';

class ChooseDateOrTime extends StatelessWidget {
  String timeOrdatetext;
  String chooseTimeorDateText;
  Widget iconPrefix;
  void Function()? onTap;
  ChooseDateOrTime(
      {super.key,
      required this.chooseTimeorDateText,
      required this.timeOrdatetext,
      required this.iconPrefix,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          iconPrefix,
          SizedBox(
            width: screenSize.width * 0.03,
          ),
          Text(
            timeOrdatetext,
            style: TextStyle(
                color: AppColor.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: FontsName.inter),
          ),
          Spacer(),
          Text(
            chooseTimeorDateText,
            style: TextStyle(
                color: AppColor.primarylLight,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: FontsName.inter),
          )
        ],
      ),
    );
  }
}
