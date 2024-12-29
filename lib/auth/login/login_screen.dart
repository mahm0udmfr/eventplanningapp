import 'package:eventplanningapp/auth/signup/register_screen.dart';
import 'package:eventplanningapp/homescreen.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:eventplanningapp/widget/custom_elevated_button.dart';
import 'package:eventplanningapp/widget/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routename = "loginscreen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
        child: Column(
          children: [
            Image.asset(
              ImageAssets.logo,
              height: screenSize.height * 0.30,
            ),
            CustomTextFormField(
              hintText: AppLocalizations.of(context)!.email,
              prefixIcon: Image.asset(ImageAssets.emailicon),
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontsName.inter),
            ),
            SizedBox(
              height: screenSize.height * 0.015,
            ),
            CustomTextFormField(
              maxLines: 1,
              hintText: AppLocalizations.of(context)!.password,
              prefixIcon: Image.asset(ImageAssets.passwordicon),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Image(image: AssetImage(ImageAssets.hidepasswordicon)),
              ),
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontsName.inter),
                  
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      //gotoforgetpassword
                    },
                    child: Text(
                      AppLocalizations.of(context)!.forgetpassword,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColor.primarylLight,
                        fontSize: 16,
                        fontFamily: FontsName.inter,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    )),
              ],
            ),
            CustomElevatedButton(
              text: AppLocalizations.of(context)!.login,
              center: true,
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.routename, (Route<dynamic> route) => false);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.dont_have_account,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: FontsName.inter,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      //gotoRegisterScreen
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          RegisterScreen.routename,
                          (Route<dynamic> route) => false);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.create_account,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColor.primarylLight,
                        fontSize: 16,
                        fontFamily: FontsName.inter,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Divider(
                  color: AppColor.primarylLight,
                  endIndent: screenSize.width * 0.02,
                  indent: screenSize.width * 0.03,
                  thickness: 2,
                )),
                Text(
                  AppLocalizations.of(context)!.or,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: FontsName.inter,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: AppColor.primarylLight,
                  endIndent: screenSize.width * 0.03,
                  indent: screenSize.width * 0.02,
                  thickness: 2,
                )),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            CustomElevatedButton(
              text: AppLocalizations.of(context)!.login_with_google,
              textStyle: TextStyle(
                color: AppColor.primarylLight,
                fontSize: 20,
                fontFamily: FontsName.inter,
              ),
              prefixIconButton: Image.asset(ImageAssets.googleicon),
              backgroundColor: AppColor.whiteColor,
              center: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
