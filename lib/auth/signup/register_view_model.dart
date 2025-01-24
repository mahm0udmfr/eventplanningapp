import 'package:eventplanningapp/auth/signup/register_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  //hold date  And Handle Logic
  late RegisterNavigator navigator;
  var formKey = GlobalKey<FormState>();
  void register(String email, String password) async {
    if (formKey.currentState!.validate() != true) {
      return;
    }
    navigator.showLoading("Loading....");
    try {
      // final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // UsersModel usersmodel = UsersModel(
      //     id: credential.user?.uid ?? "",
      //     name: nameController.text,
      //     email: emailController.text);
      // await FirebaseUtils.addUsersToFireStore(usersmodel);
      // var userProvider = Provider.of<UserProvider>(context, listen: false);
      // userProvider.updateUser(usersmodel);
      // eventListProvider.uId = usersmodel.id;
      // eventListProvider.changeSelectedIndex(0, context);

      navigator.hideLoading();

      navigator.navigateToScreen();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideLoading();
        navigator.showMessage("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        navigator.hideLoading();
        navigator.showMessage("The account already exists for that email.");
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage(e.toString());
    }
  }
}
