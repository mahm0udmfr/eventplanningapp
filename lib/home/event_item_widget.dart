import 'package:eventplanningapp/models/event.dart';
import 'package:eventplanningapp/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItemWidget extends StatelessWidget {
  Event event;
  void Function()? onTap;
  EventItemWidget({super.key, required this.event,required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: screenSize.height * 0.28,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.primarylLight, width: 2),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(event.image),
            fit: BoxFit.fill,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.whiteColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event.dateTime.day}",
                  style: TextStyle(
                      color: AppColor.primarylLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  DateFormat("MMM").format(event.dateTime),
                  style: TextStyle(
                      color: AppColor.primarylLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.02,
                vertical: screenSize.height * 0.012),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.whiteColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackColor),
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: event.isFavorite
                      ? Icon(
                          Icons.favorite,
                          color: AppColor.primarylLight,
                        )
                      : Icon(
                          Icons.favorite_border_outlined,
                          color: AppColor.primarylLight,
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
