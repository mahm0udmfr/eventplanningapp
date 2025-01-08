import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context, required String message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  message,
                  style: TextStyle(
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: FontsName.inter),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

static  void showMessage(
      {required BuildContext context,
      required String message,
      String? title,
      String? posActionName,
      Function? posAction,
      Function? negAction,
      String? negActionName}) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: TextStyle(
                color: AppColor.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: FontsName.inter),
          )));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: TextStyle(
                color: AppColor.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: FontsName.inter),
          )));
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          title: Text(
            title ?? 'Title',
            style: TextStyle(
                color: AppColor.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: FontsName.inter),
          ),
          actions: actions,
        );
      },
    );
  }
}
