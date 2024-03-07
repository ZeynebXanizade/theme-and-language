import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AwesomeDialogWidget {
  static showAwesomeDialog({
    required BuildContext context,
    required String message,
    required DialogType dialogType,
    required void Function()? onPressed,
  }) {
    AwesomeDialog(
      context: context,
      animType: AnimType.rightSlide,
      dialogType: dialogType,
      body: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      btnCancel: ElevatedButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          style: ButtonStyle(
            backgroundColor:
                Theme.of(context).elevatedButtonTheme.style?.foregroundColor,
          ),
          child: Text(
            AppLocalizations.of(context)!.cancel.toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          )),
      btnOk: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                Theme.of(context).elevatedButtonTheme.style?.foregroundColor,
          ),
          onPressed: onPressed,
          child: Text(
            AppLocalizations.of(context)!.ok.toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          )),
      dialogBackgroundColor: Theme.of(context).dialogBackgroundColor,
    ).show();
  }
}
