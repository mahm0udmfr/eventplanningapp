import 'package:eventplanningapp/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  Color? borderColor;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextStyle? hintStyle;
  TextStyle? style;
  bool obscureText;
  int? maxLines;
  String? Function(String?)? validator;
  TextEditingController? controller;
  CustomTextFormField(
      {super.key,
      this.borderColor,
      required this.hintText,
      this.hintStyle,
      this.prefixIcon,
      this.suffixIcon,
      this.style,
      this.obscureText = false,
      this.maxLines,
      this.validator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      obscureText: obscureText,
      obscuringCharacter: "*",
      cursorColor: AppColor.blackColor,
      style: style ??
          TextStyle(
            color: AppColor.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                BorderSide(color: borderColor ?? AppColor.greyColor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                BorderSide(color: borderColor ?? AppColor.greyColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColor.redColor, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColor.redColor, width: 2),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
                  color: AppColor.greyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
    );
  }
}
