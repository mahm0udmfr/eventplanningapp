import 'package:eventplanningapp/auth/login/login_interface.dart';
import 'package:eventplanningapp/auth/login/login_view_model.dart';
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

class LoginScreen extends StatefulWidget {
  static const String routename = "loginscreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginInterface {
  LoginViewModel viewModel = LoginViewModel();

  bool obsecure = true;

  late UserProvider userProvider;

  late EventListProvider eventListProvider;
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    userProvider = Provider.of<UserProvider>(context);
    eventListProvider = Provider.of<EventListProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
          child: Form(
            key: viewModel.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    ImageAssets.logo,
                    height: screenSize.height * 0.30,
                  ),
                  CustomTextFormField(
                    hintText: AppLocalizations.of(context)!.email,
                    controller: viewModel.emailController,
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
                    controller: viewModel.passwordController,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return "please enter Password";
                      }
                      if (viewModel.passwordController.text.length < 6) {
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
                      icon: Image(
                          image: AssetImage(ImageAssets.hidepasswordicon)),
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
                      viewModel.login();
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
      ),
    );
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

  @override
  void hideLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void navigateToScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routename, (Route<dynamic> route) => false);
  }

  @override
  void showLoading(String message) {
    DialogUtils.showLoading(context: context, message: message);
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(context: context, message: message);
  }
}
