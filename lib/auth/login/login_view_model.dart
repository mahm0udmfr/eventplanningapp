import 'package:eventplanningapp/auth/login/login_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  //hold date  And Handle Logic
  late LoginInterface navigator;
  var emailController =
      TextEditingController(text: "look.mahmoud172@gmail.com");
  var passwordController = TextEditingController(text: "123456");

  var formKey = GlobalKey<FormState>();

  void login() async {
    if (formKey.currentState!.validate() != true) {
      return;
    }
    navigator.showLoading("Loading....");
    try {
      //  final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // var user = await FirebaseUtils.readUserFromFirestore(
      //     credential.user?.uid ?? '');
      // if (user == null) {
      //   return;
      // }
      // eventListProvider.uId = user.id;
      // userProvider.updateUser(user);
      // eventListProvider.changeSelectedIndex(0, context);
      // DialogUtils.hideLoading(context);
      navigator.navigateToScreen();
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     HomeScreen.routename, (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator.hideLoading();
        navigator.showMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        navigator.hideLoading();
        navigator.showMessage("Wrong password provided for that user.");
      } else if (e.code == 'invalid-credential') {
        navigator.hideLoading();
        navigator.showMessage("Check User Email Or Password.");
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage(e.toString());
    }
  }
}
