import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  String text;
  Color? backgroundColor;
  Widget? prefixIconButton;
  Widget? suffixIconButton;
  bool center = true;
  void Function()? onPressed;
  TextStyle? textStyle;
  CustomElevatedButton(
      {super.key,
      required this.text,
      this.backgroundColor,
      this.prefixIconButton,
      required this.center,
      required this.onPressed,
      this.textStyle,
      this.suffixIconButton});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(width: 2, color: AppColor.primarylLight)),
            backgroundColor: backgroundColor ?? AppColor.primarylLight,
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.04,
                vertical: screenSize.width * 0.05)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment:
              center ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            prefixIconButton ?? SizedBox(),
            SizedBox(
              width: screenSize.width * 0.02,
            ),
            Text(text,
                style: textStyle ??
                    TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 20,
                      fontFamily: FontsName.inter,
                    )),
            center ? SizedBox() : Spacer(),
            suffixIconButton ?? SizedBox(),
          ],
        ));
  }
}
