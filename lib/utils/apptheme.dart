import 'package:eventplanningapp/utils/colors.dart';
import 'package:flutter/material.dart';

class Apptheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColor.primarylLight,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: AppColor.whiteColor,
          unselectedItemColor: AppColor.whiteColor,
          elevation: 0,
          backgroundColor: AppColor.transparentColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColor.whiteColor, width: 3),
            borderRadius: BorderRadius.circular(50)),
        backgroundColor: AppColor.primarylLight,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: AppColor.primarylLight));

  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColor.primaryDark,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(  
          selectedItemColor: AppColor.whiteColor,
          unselectedItemColor: AppColor.whiteColor,
          elevation: 0,
          backgroundColor: AppColor.transparentColor),



                floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColor.whiteColor, width: 3),
            borderRadius: BorderRadius.circular(50)),
        backgroundColor: AppColor.primaryDark,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: AppColor.primaryDark));
}
