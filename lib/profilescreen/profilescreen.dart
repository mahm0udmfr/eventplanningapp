import 'package:eventplanningapp/auth/login/login_screen.dart';
import 'package:eventplanningapp/profilescreen/language_bottomsheet.dart';
import 'package:eventplanningapp/profilescreen/theme_bottom_sheet.dart';
import 'package:eventplanningapp/providers/apptheme_provider.dart';
import 'package:eventplanningapp/providers/event_list_provider.dart';
import 'package:eventplanningapp/providers/language_provider.dart';
import 'package:eventplanningapp/providers/user_provider.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:eventplanningapp/utils/show_toast.dart';
import 'package:eventplanningapp/widget/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<AppthemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primarylLight,
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
                    userProvider.currentUser!.name.toUpperCase(),
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontsName.inter,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    userProvider.currentUser!.email,
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
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
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
            Spacer(),
            CustomElevatedButton(
              text: AppLocalizations.of(context)!.logout,
              backgroundColor: AppColor.redColor,
              prefixIconButton: Icon(
                Icons.logout_outlined,
                color: AppColor.whiteColor,
                size: screenSize.height * 0.027,
              ),
              center: false,
              onPressed: () {
                eventListProvider.eventList = [];
                signOutFromGoogle();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routename, (Route<dynamic> route) => false);
              },
            ),
            SizedBox(
              height: screenSize.height * 0.04,
            )
          ],
        ),
      ),
    );
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      ShowToast.toast("Logged Out.");
      return true;
    } on Exception catch (_) {
      return false;
    }
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
