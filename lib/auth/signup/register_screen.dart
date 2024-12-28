import 'package:eventplanningapp/auth/login/login_screen.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:eventplanningapp/widget/custom_elevated_button.dart';
import 'package:eventplanningapp/widget/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const String routename = "RegisterScreen";
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.03,
            vertical: screenSize.height * 0.02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                ImageAssets.logo,
                height: screenSize.height * 0.25,
              ),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.name,
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
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.repassword,
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
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              CustomElevatedButton(
                text: AppLocalizations.of(context)!.create_account,
                center: true,
                onPressed: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.already_have_account,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: FontsName.inter,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        //gotologin
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            LoginScreen.routename,
                            (Route<dynamic> route) => false);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
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
            ],
          ),
        ),
      ),
    );
  }
}
