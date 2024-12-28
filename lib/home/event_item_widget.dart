import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:flutter/material.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key});

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
            image: AssetImage(ImageAssets.birthdayimage),
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
                  "22",
                  style: TextStyle(
                      color: AppColor.primarylLight,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  "Nov.",
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
            padding: EdgeInsets.symmetric(horizontal: screenSize.width*0.02, vertical: screenSize.height*0.012),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.whiteColor,
            ),
            child: Row(
          
              children: [
                Expanded(
                  child: Text(
                    "This is a Birthday Party ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackColor),
                  ),
                ),
                Icon(Icons.favorite,color: AppColor.primarylLight,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
