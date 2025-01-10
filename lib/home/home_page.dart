import 'package:eventplanningapp/eventManageScreens/event_details_screen.dart';
import 'package:eventplanningapp/home/event_item_widget.dart';
import 'package:eventplanningapp/home/tab_event_widget.dart';
import 'package:eventplanningapp/providers/apptheme_provider.dart';
import 'package:eventplanningapp/providers/event_list_provider.dart';
import 'package:eventplanningapp/providers/language_provider.dart';
import 'package:eventplanningapp/providers/user_provider.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<AppthemeProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcome,
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: FontsName.inter),
                    ),
                    Text(
                      userProvider.currentUser!.name.toUpperCase(),
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.inter),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          ////change app theme
                          themeProvider.apptheme == ThemeMode.light
                              ? themeProvider.changeTheme(ThemeMode.dark)
                              : themeProvider.changeTheme(ThemeMode.light);
                        },
                        icon: Icon(
                          Icons.wb_sunny_outlined,
                          size: 24,
                          color: AppColor.whiteColor,
                        )),
                    InkWell(
                      onTap: () {
                        languageProvider.appLanguage == "en"
                            ? languageProvider.changeLanguage("ar")
                            : languageProvider.changeLanguage("en");
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          languageProvider.appLanguage == "en" ? "EN" : "AR",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontsName.inter),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            Row(
              children: [
                Image.asset(ImageAssets.unSelectedMapImage),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Text(
                  "Cairo , Egypt",
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: FontsName.inter),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            DefaultTabController(
              length: eventListProvider.getEventsNameList(context).length,
              initialIndex: eventListProvider.selectedIndex,
              child: TabBar(
                  onTap: (value) {
                    // eventListProvider.selectedIndex = value;
                    eventListProvider.changeSelectedIndex(value, context);
                  },
                  isScrollable: true,
                  dividerColor: AppColor.transparentColor,
                  indicatorColor: AppColor.transparentColor,
                  tabAlignment: TabAlignment.start,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
                  tabs: eventListProvider
                      .getEventsNameList(context)
                      .map((eventname) {
                    return TabEventWidget(
                      eventName: eventname,
                      isSelected: eventListProvider.selectedIndex ==
                          eventListProvider
                              .getEventsNameList(context)
                              .indexOf(eventname),
                      backGroundColor: AppColor.whiteColor,
                      textSelectedStyle: TextStyle(
                          color: AppColor.primarylLight,
                          fontFamily: FontsName.inter,
                          fontSize: 16),
                      textUnSelectedStyle: TextStyle(
                          color: AppColor.whiteColor,
                          fontFamily: FontsName.inter,
                          fontSize: 16),
                    );
                  }).toList()),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.02,
        ),
        child: eventListProvider.eventList.isEmpty
            ? Center(
                child: Text("No Events In Yet"),
              )
            : ListView.builder(
                itemCount: eventListProvider.eventList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      
                      Navigator.of(context)
                          .pushNamed(EventDetailsScreen.routename,arguments: eventListProvider.eventList[index]);
                    },
                    child: EventItemWidget(
                      event: eventListProvider.eventList[index],
                      onTap: () {
                        eventListProvider
                            .updateFavorite(eventListProvider.eventList[index]);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
