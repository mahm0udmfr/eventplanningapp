import 'package:eventplanningapp/home/event_item_widget.dart';
import 'package:eventplanningapp/home/tab_event_widget.dart';
import 'package:eventplanningapp/providers/apptheme_provider.dart';
import 'package:eventplanningapp/providers/language_provider.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int selectedIndex = 0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<AppthemeProvider>(context);

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
                      "Mahmoud Ramadan",
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
              length: eventsNameList.length,
              initialIndex: selectedIndex,
              child: TabBar(
                  onTap: (value) {
                    selectedIndex = value;
                    setState(() {});
                  },
                  isScrollable: true,
                  dividerColor: AppColor.transparentColor,
                  indicatorColor: AppColor.transparentColor,
                  tabAlignment: TabAlignment.start,
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
                  tabs: eventsNameList.map((eventname) {
                    return TabEventWidget(
                        eventName: eventname,
                        isSelected:
                            selectedIndex == eventsNameList.indexOf(eventname));
                  }).toList()),
            )
          ],
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:screenSize.width*0.02,),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: screenSize.height*0.01,),
          itemCount: 20,
          itemBuilder: (context, index) {
            return EventItemWidget();
          },
        ),
      ),
    );
  }
}