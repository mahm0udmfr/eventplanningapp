import 'package:eventplanningapp/firebase_utils.dart';
import 'package:eventplanningapp/home/tab_event_widget.dart';
import 'package:eventplanningapp/models/event.dart';
import 'package:eventplanningapp/providers/event_list_provider.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:eventplanningapp/widget/choose_date_or_time.dart';
import 'package:eventplanningapp/widget/custom_elevated_button.dart';
import 'package:eventplanningapp/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  static const String routename = "AddEventScreen";

  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int isSelected = 0;
  String selectedEvent = 'sport';
  String selectedImage = '';
  final formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  var titleController = TextEditingController();
  var discriptionController = TextEditingController();
  late EventListProvider eventListProvider;
  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    Size screenSize = MediaQuery.of(context).size;
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workShop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating
    ];
    List<String> imageSelectedNameList = [
      ImageAssets.sport,
      ImageAssets.birthdayimage,
      ImageAssets.meeting,
      ImageAssets.gamming,
      ImageAssets.workshop,
      ImageAssets.bookclub,
      ImageAssets.exhibition,
      ImageAssets.holiday,
      ImageAssets.eating
    ];

    selectedImage = imageSelectedNameList[eventListProvider.selectedIndex];
    // selectedEvent = eventsNameList[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: TextStyle(
              color: AppColor.primarylLight,
              fontSize: 22,
              fontFamily: FontsName.inter),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: screenSize.width * 0.02,
          left: screenSize.width * 0.02,
          top: screenSize.width * 0.02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    selectedImage,
                    fit: BoxFit.fill,
                    height: screenSize.height * 0.25,
                    width: screenSize.width,
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                  height: screenSize.height * 0.045,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      width: screenSize.width * 0.019,
                    ),
                    itemCount: eventsNameList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          eventListProvider.selectedIndex = index;
                          selectedEvent = eventsNameList[index];
                          setState(() {});
                        },
                        child: TabEventWidget(
                          bordercolor: AppColor.primarylLight,
                          eventName: eventsNameList[index],
                          isSelected: eventListProvider.selectedIndex == index,
                          backGroundColor: AppColor.primarylLight,
                          textSelectedStyle: TextStyle(
                              color: AppColor.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: FontsName.inter),
                          textUnSelectedStyle: TextStyle(
                              color: AppColor.primarylLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: FontsName.inter),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontsName.inter),
                ),
                SizedBox(
                  height: screenSize.height * 0.005,
                ),
                CustomTextFormField(
                  controller: titleController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "please enter event title";
                    }
                    return null;
                  },
                  hintText: AppLocalizations.of(context)!.event_title,
                  prefixIcon: Image.asset(ImageAssets.titleicon),
                ),
                SizedBox(
                  height: screenSize.height * 0.005,
                ),
                Text(
                  AppLocalizations.of(context)!.event_description,
                  style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontsName.inter),
                ),
                SizedBox(
                  height: screenSize.height * 0.005,
                ),
                CustomTextFormField(
                  controller: discriptionController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "please enter Event Description";
                    }
                    return null;
                  },
                  hintText: AppLocalizations.of(context)!.event_description,
                  maxLines: 4,
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                ChooseDateOrTime(
                  iconPrefix: Image.asset(
                    ImageAssets.calendericon,
                    height: screenSize.height * 0.03,
                  ),
                  chooseTimeorDateText: selectedDate == null
                      ? AppLocalizations.of(context)!.choose_date
                      : DateFormat('yyyy-MM-dd').format(selectedDate!),
                  timeOrdatetext: AppLocalizations.of(context)!.event_date,
                  onTap: () {
                    chooseDate();
                  },
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                ChooseDateOrTime(
                  iconPrefix: Image.asset(
                    ImageAssets.timeicon,
                    height: screenSize.height * 0.03,
                  ),
                  chooseTimeorDateText: selectedTime == null
                      ? AppLocalizations.of(context)!.choose_time
                      : selectedTime!.format(context),
                  timeOrdatetext: AppLocalizations.of(context)!.event_time,
                  onTap: () {
                    chooseTime();
                  },
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Text(
                  AppLocalizations.of(context)!.location,
                  style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontsName.inter),
                ),
                SizedBox(
                  height: screenSize.height * 0.005,
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
                  text: AppLocalizations.of(context)!.choose_event_location,
                  textStyle: TextStyle(
                      color: AppColor.primarylLight,
                      fontFamily: FontsName.inter,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  center: false,
                  onPressed: () {},
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                CustomElevatedButton(
                  text: AppLocalizations.of(context)!.add_event,
                  textStyle: TextStyle(
                      color: AppColor.whiteColor,
                      fontFamily: FontsName.inter,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                  center: true,
                  onPressed: () {
                    addEvent();
                  },
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState!.validate() == true) {
      if (selectedDate == null) {
        Fluttertoast.showToast(
            msg: "Please Choose Date Frist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
      if (selectedTime == null) {
        Fluttertoast.showToast(
            msg: "Please Choose Time Frist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }

      Event event = Event(
          title: titleController.text,
          discription: discriptionController.text,
          image: selectedImage,
          eventName: selectedEvent,
          dateTime: selectedDate!,
          time: selectedTime!.format(context));
      FirebaseUtils.addEventToFireStore(event).timeout(
        Duration(milliseconds: 500),
        onTimeout: () {
          
          eventListProvider.getAllEvents();
          
          Fluttertoast.showToast(
              msg: "Data Saved",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.red,
              fontSize: 16.0);
        },
        
      );
      Navigator.pop(context);
    }
  }

  void chooseDate() async {
    var choosedate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = choosedate;
    setState(() {});
  }

  void chooseTime() async {
    var choosentime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedTime = choosentime;
    setState(() {});
  }
}
