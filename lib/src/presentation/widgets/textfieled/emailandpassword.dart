import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/presentation/widgets/textfieled/textfield.dart';

// ignore: must_be_immutable
class EmailAndPassword extends StatefulWidget {
  // ignore: use_super_parameters
  const EmailAndPassword(
      {Key? key,
      required this.emailcontroller,
      required this.passwordcontroller})
      : super(key: key);

  final TextEditingController emailcontroller;
  final TextEditingController passwordcontroller;

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool first = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
//////////////////////////EMAIL/////////////////////////////
        TextFields(
          obscureText: false,
          controller: widget.emailcontroller,
          text: AppLocalizations.of(context)!.email.toString(),
          keyboardType: TextInputType.emailAddress,
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
///////////////////////PASSWORD////////////////////////        
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return AppLocalizations.of(context)!.passwordvalid.toString();
              }
              if (!RegExp("^[a-zA-Z0-9]").hasMatch(value)) {
                return AppLocalizations.of(context)!.validpassword.toString();
              }
              return null;
            },
            controller: widget.passwordcontroller,
            style: Theme.of(context).textTheme.headlineLarge,
            decoration: InputDecoration(
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide:BorderSide(color:  Theme.of(context).colorScheme.primary)),
                labelStyle: Theme.of(context).textTheme.headlineLarge,
                labelText: AppLocalizations.of(context)!.password.toString(),
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      first = !first;
                    });
                  },
                  child: AnimatedCrossFade(
                      firstChild: const Icon(Icons.visibility),
                      secondChild: const Icon(Icons.visibility_off),
                      crossFadeState: first
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 100)),
                )),
            keyboardType: TextInputType.visiblePassword,
            obscureText: first,
          ),
        ),
      ],
    );
  }
}
