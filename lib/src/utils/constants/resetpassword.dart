import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPassword {
  static resetpassword(
      {required BuildContext context,
      required TextEditingController controller}) async {
    String email = controller.text.trim();
    // ignore: avoid_print
    print("E-posta adresi: $email");
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // E-posta gönderildiğinde kullanıcıyı bilgilendirme
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              // ignore: use_build_context_synchronously
              content: Text(
            // ignore: use_build_context_synchronously
            AppLocalizations.of(context)!.resetemail.toString(),
            // ignore: use_build_context_synchronously
            style: Theme.of(context).snackBarTheme.contentTextStyle,
          )),
        );
      } catch (error) {
        // ignore: avoid_print
        print(error);
        // Hata durumunda kullanıcıyı bilgilendirme
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              // ignore: use_build_context_synchronously
              content: Text(
            // ignore: use_build_context_synchronously
            AppLocalizations.of(context)!.error.toString(),
            // ignore: use_build_context_synchronously
           style: Theme.of(context).snackBarTheme.contentTextStyle,
          )),
        );
      }
    } else {
      // E-posta boşsa kullanıcıyı bilgilendirme
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
              // ignore: use_build_context_synchronously
              content: Text(
            // ignore: use_build_context_synchronously
            AppLocalizations.of(context)!.emailvalid.toString(),
            // ignore: use_build_context_synchronously
           style: Theme.of(context).snackBarTheme.contentTextStyle,
          )),
      );
    }
  }
}
