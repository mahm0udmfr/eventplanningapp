import 'package:eventplanningapp/auth/login/login_screen.dart';
import 'package:eventplanningapp/auth/signup/register_interface.dart';
import 'package:eventplanningapp/auth/signup/register_view_model.dart';
import 'package:eventplanningapp/homescreen.dart';
import 'package:eventplanningapp/providers/event_list_provider.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/dialog_utils.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:eventplanningapp/widget/custom_elevated_button.dart';
import 'package:eventplanningapp/widget/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routename = "RegisterScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  RegisterViewModel viewModel = RegisterViewModel();

  var nameController = TextEditingController(text: 'mahmoud');

  var emailController =
      TextEditingController(text: 'look.mahmoud172@gmail.com');

  var passwordController = TextEditingController(text: '123456');

  var rePasswordController = TextEditingController(text: '123456');

  late EventListProvider eventListProvider;
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    Size screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  Image.asset(
                    ImageAssets.logo,
                    height: screenSize.height * 0.25,
                  ),
                  CustomTextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter name";
                      }
                      return null;
                    },
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Please Enter Email Address";
                      }

                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return "Please Enter a Valid Email Address";
                      }
                      return null;
                    },
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
                    controller: passwordController,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter Password";
                      }
                      if (passwordController.text.length < 6) {
                        return "please enter Minimum 6 Chars";
                      }
                      return null;
                    },
                    maxLines: 1,
                    hintText: AppLocalizations.of(context)!.password,
                    prefixIcon: Image.asset(ImageAssets.passwordicon),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Image(
                          image: AssetImage(ImageAssets.hidepasswordicon)),
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
                    controller: rePasswordController,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter Password";
                      }
                      if (passwordController.text !=
                          rePasswordController.text) {
                        return "please Check Passwords Not Equal";
                      }
                      return null;
                    },
                    maxLines: 1,
                    hintText: AppLocalizations.of(context)!.repassword,
                    prefixIcon: Image.asset(ImageAssets.passwordicon),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Image(
                          image: AssetImage(ImageAssets.hidepasswordicon)),
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
                    onPressed: () {
                      viewModel.register(
                          emailController.text, passwordController.text);
                    },
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
        ),
      ),
    );
  }

  @override
  void hideLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading(String message) {
    DialogUtils.showLoading(context: context, message: message);
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(context: context, message: message);
  }

  @override
  void navigateToScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routename, (Route<dynamic> route) => false);
  }
}
