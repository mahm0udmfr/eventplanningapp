import 'package:eventplanningapp/eventManageScreens/edit_event_screen.dart';
import 'package:eventplanningapp/firebase_utils.dart';
import 'package:eventplanningapp/models/event.dart';
import 'package:eventplanningapp/providers/event_list_provider.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/dialog_utils.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:eventplanningapp/utils/show_toast.dart';
import 'package:eventplanningapp/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class EventDetailsScreen extends StatelessWidget {
  static const String routename = "EventScreenDetails";
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    Size screenSize = MediaQuery.of(context).size;

    var args = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Text(
          "Event Details",
          style: TextStyle(
              color: AppColor.primarylLight,
              fontFamily: FontsName.inter,
              fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(EditEventScreen.routename, arguments: args);
              },
              child: Icon(
                Icons.edit,
                color: AppColor.primarylLight,
              )),
          SizedBox(
            width: screenSize.width * 0.02,
          ),
          InkWell(
              onTap: () {
                DialogUtils.showMessage(
                    context: context,
                    message: "Are You Sure You Want To Delete This ?",
                    negActionName: "Cancel",
                    posActionName: "Yes",
                    posAction: () {
                      FirebaseUtils.deleteEvent(args.id, eventListProvider.uId)
                          .then((value) {
                        eventListProvider.changeSelectedIndex(0, context);
                        ShowToast.toast("Event Deleted");
                      }).timeout(
                        Duration(milliseconds: 500),
                        onTimeout: () {},
                      );
                      Navigator.pop(context);
                    });
              },
              child: Icon(
                Icons.delete_outline,
                color: AppColor.redColor,
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            right: screenSize.width * 0.02,
            left: screenSize.width * 0.02,
            top: screenSize.height * 0.01,
            bottom: screenSize.height * 0.02),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  args.image,
                  fit: BoxFit.fill,
                  height: screenSize.height * 0.25,
                  width: screenSize.width,
                ),
              ),
              Expanded(
                flex: 0,
                child: Text(
                  args.title,
                  style: TextStyle(
                      color: AppColor.primarylLight,
                      fontFamily: FontsName.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
              ),
              CustomElevatedButton(
                prefixIconButton: Image.asset(
                  ImageAssets.calenderIconEdit,
                  height: screenSize.height * 0.05,
                ),
                backgroundColor: AppColor.whiteColor,
                text: DateFormat("dd MMMM yyyy").format(args.dateTime),
                textStyle: TextStyle(
                    color: AppColor.primarylLight,
                    fontFamily: FontsName.inter,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                center: false,
                onPressed: () {},
                secondwidgetUnderText: Text(
                  args.time,
                  style: TextStyle(
                      color: AppColor.blackColor,
                      fontFamily: FontsName.inter,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              CustomElevatedButton(
                prefixIconButton: Image.asset(
                  ImageAssets.locationicon,
                  height: screenSize.height * 0.05,
                ),
                suffixIconButton: Image.asset(
                  ImageAssets.arrowRight,
                  height: screenSize.height * 0.05,
                ),
                backgroundColor: AppColor.whiteColor,
                text: "Cairo , Egypt",
                textStyle: TextStyle(
                    color: AppColor.primarylLight,
                    fontFamily: FontsName.inter,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                center: false,
                onPressed: () {},
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  ImageAssets.mapfortest,
                  fit: BoxFit.fill,
                  height: screenSize.height * 0.4,
                  width: screenSize.width,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                        color: AppColor.blackColor,
                        fontFamily: FontsName.inter,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Expanded(
                    flex: 0,
                    child: Text(
                      args.discription,
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontFamily: FontsName.inter,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
