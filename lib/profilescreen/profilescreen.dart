import 'package:eventplanningapp/profilescreen/language_bottomsheet.dart';
import 'package:eventplanningapp/profilescreen/theme_bottom_sheet.dart';
import 'package:eventplanningapp/providers/apptheme_provider.dart';
import 'package:eventplanningapp/providers/language_provider.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<AppthemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: screenSize.height * 0.20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: languageProvider.appLanguage == "en"
                  ? Radius.circular(60)
                  : Radius.zero,
              bottomRight: languageProvider.appLanguage == "ar"
                  ? Radius.circular(60)
                  : Radius.zero,
            ),
          ),
        title: Row(
  children: [
    languageProvider.appLanguage == "en"
        ? Image.asset(
            ImageAssets.profileimage,
            width: screenSize.width * 0.3,
            height: screenSize.height * 0.3,
          )
        : Image.asset(
            ImageAssets.profileimagertl,
            width: screenSize.width * 0.3,
            height: screenSize.height * 0.3,
          ),
    SizedBox(
      width: screenSize.width * 0.02,
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mahmoud Ramadan",
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: FontsName.inter,
            ),
            overflow: TextOverflow.ellipsis, 
          ),
          Text(
            "mahmoud.mohamed.ram@gmail.com",
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: FontsName.inter,
            ),
            maxLines: 2,
              overflow: TextOverflow.ellipsis, 
          ),
        ],
      ),
    ),
  ],
),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontsName.inter),
            ),
            InkWell(
              onTap: () {
                showLanguageBottomShhet(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColor.blueColor, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.appLanguage == "en"
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: TextStyle(
                          color: AppColor.blueColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.inter),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColor.blueColor,
                      size: 35,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontsName.inter),
            ),
            InkWell(
              onTap: () {
                ///change app theme
                showThemeBottomShhet(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColor.blueColor, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.apptheme == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                      style: TextStyle(
                          color: AppColor.blueColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.inter),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColor.blueColor,
                      size: 35,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomShhet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomShhet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
