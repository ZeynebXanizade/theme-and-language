import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/presentation/widgets/button/button.dart';
import 'package:reservation/src/presentation/widgets/textfieled/textfield.dart';
import 'package:reservation/src/utils/constants/resetpassword.dart';

class ForegetPassword extends StatefulWidget {
  const ForegetPassword({super.key});

  @override
  State<ForegetPassword> createState() => _ForegetPasswordState();
}

class _ForegetPasswordState extends State<ForegetPassword> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        title: Text(
          style: Theme.of(context).textTheme.headlineLarge,
          AppLocalizations.of(context)!.userparametrs.toString(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFields(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  text: AppLocalizations.of(context)!.email.toString(),
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.emailvalid.toString();
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return AppLocalizations.of(context)!.validemail.toString();
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MyButton(text:Text(AppLocalizations.of(context)!.ok.toString()), onPressed: () {
                                    setState(() {
                                      ResetPassword.resetpassword(
                                          context: context,
                                          controller: _emailController);
                                    });
                                  }, ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
