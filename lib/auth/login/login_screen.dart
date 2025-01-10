import 'package:eventplanningapp/auth/signup/register_screen.dart';
import 'package:eventplanningapp/firebase_utils.dart';
import 'package:eventplanningapp/homescreen.dart';
import 'package:eventplanningapp/models/users_model.dart';
import 'package:eventplanningapp/providers/event_list_provider.dart';
import 'package:eventplanningapp/providers/user_provider.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/dialog_utils.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:eventplanningapp/utils/show_toast.dart';
import 'package:eventplanningapp/widget/custom_elevated_button.dart';
import 'package:eventplanningapp/widget/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routename = "loginscreen";
  var emailController =
      TextEditingController(text: 'look.mahmoud172@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  final formKey = GlobalKey<FormState>();
  bool obsecure = true;
  late UserProvider userProvider;
  late EventListProvider eventListProvider;
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    userProvider = Provider.of<UserProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  ImageAssets.logo,
                  height: screenSize.height * 0.30,
                ),
                CustomTextFormField(
                  hintText: AppLocalizations.of(context)!.email,
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
                    onPressed: () {
                      obsecure != obsecure;
                    },
                    icon:
                        Image(image: AssetImage(ImageAssets.hidepasswordicon)),
                  ),
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontsName.inter),
                  obscureText: obsecure,
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
                    login(context);
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
                  onPressed: () {
                    signInWithGoogle(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    if (formKey.currentState!.validate() == true) {
      DialogUtils.showLoading(context: context, message: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        var user = await FirebaseUtils.readUserFromFirestore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        eventListProvider.uId = user.id;
        userProvider.updateUser(user);
        eventListProvider.changeSelectedIndex(0, context);
        DialogUtils.hideLoading(context);

        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routename, (Route<dynamic> route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context, message: 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'Check User Email Or Password.',
              title: 'Invalid Credential');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: e.toString());
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    DialogUtils.showLoading(context: context, message: 'Loading....');
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user != null) {
      UsersModel usersmodel =
          UsersModel(id: user.uid, name: user.displayName!, email: user.email!);

      await FirebaseUtils.addUsersToFireStore(usersmodel).then((value) {
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(usersmodel);
        eventListProvider.uId = usersmodel.id;
        eventListProvider.changeSelectedIndex(0, context);
      });

      DialogUtils.hideLoading(context);
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routename, (Route<dynamic> route) => false);
    } else {
      ShowToast.toast("Sign-in failed");
      DialogUtils.hideLoading(context);
      return;
    }
  }
}
