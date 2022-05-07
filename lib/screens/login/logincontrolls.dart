import 'package:app/palette/dialogs/dialogs.dart';
import 'package:app/screens/dataentry/ui/createdata.dart';
import 'package:app/screens/login/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginControlls extends GetxController {
  final gogleSignin = GoogleSignIn();

  GoogleSignInAccount? _user;

  get user => _user;

  Future<void> onGoogleLogin(BuildContext ctx) async {
    showIndicatorDialog(false);
    try {
      final selectedacc = await gogleSignin.signIn();
      popDialog(ctx);
      if (selectedacc != null) {
        _user = selectedacc;

        final googleauth = await selectedacc.authentication;

        final credential = GoogleAuthProvider.credential(
            accessToken: googleauth.accessToken, idToken: googleauth.idToken);
        await FirebaseAuth.instance.signInWithCredential(credential);
        if (isUserLoggedin()) {
          CreateEntry.onBack();
        } else {
          showIndicatorDialog(true);
        }
      }
    } catch (e) {
      debugPrint("lado jastoerro");
    }
  }

  static bool isUserLoggedin() {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    }
    return true;
  }

  static void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

class Userdata {
  static String getCurrnetUsser() {
    return "aG3zl2xbGIM932F74kVbnRrdRj0222";
    //return FirebaseAuth.instance.currentUser!.uid;
  }
}
