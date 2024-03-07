import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reservation/src/data/auth.dart';
import 'package:reservation/src/presentation/views/signin-signup-register/login_page.dart';
import 'package:reservation/src/presentation/widgets/awsome%20dialog/awesome.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/utils/constants/fluttertoast.dart';

final AuthServices _auth = AuthServices();

class Register {
  static signUp({
    required BuildContext context,
    required GlobalKey<FormState> formState,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController nameController,
    required TextEditingController phoneController,
  }) async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String password = passwordController.text.trim();
    String phone = phoneController.text.trim();
    try {
      if (formState.currentState!.validate()) {
        await _auth.signUpWithEmailAndPassword(
            context: context,
            email: email,
            password: password,
            name: name,
            phone: phone);

        // ignore: use_build_context_synchronously
        AwesomeDialogWidget.showAwesomeDialog(
            context: context,
            // ignore: use_build_context_synchronously
            message: AppLocalizations.of(context)!.succesful.toString(),
            dialogType: DialogType.success,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    // ignore: use_build_context_synchronously
                    content: Text(
                  // ignore: use_build_context_synchronously
                  AppLocalizations.of(context)!.emailverifed.toString(),
                  // ignore: use_build_context_synchronously
                  style: Theme.of(context).snackBarTheme.contentTextStyle,
                )),
              );
              FirebaseAuth.instance.currentUser!.sendEmailVerification();
                     Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            });
        // ignore: use_build_context_synchronously
      }
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      FlutterToast.showToasts(
          // ignore: use_build_context_synchronously
          msg: AppLocalizations.of(context)!.error.toString(),
          context: context);
    }
  }
}
