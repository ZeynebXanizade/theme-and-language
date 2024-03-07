import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reservation/src/data/auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/utils/constants/fluttertoast.dart';

final AuthServices _auth = AuthServices();

class SignInWidget {
  static signIn(
      {required BuildContext context,
      required TextEditingController emailcontroller,
      required TextEditingController passwordcontroller,
      required GlobalKey<FormState> formState}) async {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    try {
      if (formState.currentState!.validate()) {
        // ignore: unused_local_variable
        User? user = await _auth.signInWithEmailAndPassword(
          context: context,
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print("FirebaseAuthException hatasi: ${e.code}");
      // ignore: avoid_print
      print("Hata Mesajı: ${e.message}");
      // ignore: use_build_context_synchronously
      FlutterToast.showToasts(
          // ignore: use_build_context_synchronously
          msg: AppLocalizations.of(context)!.error.toString(),
          context: context);
    }
  }
}
