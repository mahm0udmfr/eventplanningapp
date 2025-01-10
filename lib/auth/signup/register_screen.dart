import 'package:eventplanningapp/auth/login/login_screen.dart';
import 'package:eventplanningapp/firebase_utils.dart';
import 'package:eventplanningapp/homescreen.dart';
import 'package:eventplanningapp/models/users_model.dart';
import 'package:eventplanningapp/providers/event_list_provider.dart';
import 'package:eventplanningapp/providers/user_provider.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/dialog_utils.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:eventplanningapp/widget/custom_elevated_button.dart';
import 'package:eventplanningapp/widget/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String routename = "RegisterScreen";
  var nameController = TextEditingController(text: 'mahmoud');
  var emailController =
      TextEditingController(text: 'look.mahmoud172@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var rePasswordController = TextEditingController(text: '123456');
  final formKey = GlobalKey<FormState>();
  late EventListProvider eventListProvider;
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
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
          child: Form(
            key: formKey,
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
                    icon:
                        Image(image: AssetImage(ImageAssets.hidepasswordicon)),
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
                    if (passwordController.text != rePasswordController.text) {
                      return "please Check Passwords Not Equal";
                    }
                    return null;
                  },
                  maxLines: 1,
                  hintText: AppLocalizations.of(context)!.repassword,
                  prefixIcon: Image.asset(ImageAssets.passwordicon),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon:
                        Image(image: AssetImage(ImageAssets.hidepasswordicon)),
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
                    createAccount(context);
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
    );
  }

  void createAccount(BuildContext context) async {
    if (formKey.currentState!.validate() == true) {
      DialogUtils.showLoading(context: context, message: 'Loading....');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        UsersModel usersmodel = UsersModel(
            id: credential.user?.uid ?? "",
            name: nameController.text,
            email: emailController.text);
        await FirebaseUtils.addUsersToFireStore(usersmodel);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(usersmodel);
        eventListProvider.uId = usersmodel.id;
        eventListProvider.changeSelectedIndex(0, context);
        DialogUtils.hideLoading(context);
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routename, (Route<dynamic> route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context, message: 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: e.toString());
      }
    }
  }
}
