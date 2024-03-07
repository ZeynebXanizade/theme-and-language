import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation/src/presentation/views/signin-signup-register/login_page.dart';
import 'package:reservation/src/presentation/widgets/button/button.dart';
import 'package:reservation/src/presentation/widgets/textfieled/emailandpassword.dart';
import 'package:reservation/src/presentation/widgets/textfieled/textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/utils/constants/register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
   final TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isSignUp = false;
  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formState,
          child: Padding(
            padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                //text
                Text(
                  AppLocalizations.of(context)!.registertitle.toString(),
                  style: GoogleFonts.rubik(
                    textStyle: Theme.of(context).textTheme.headlineLarge,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //name
                    TextFields(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .namevalid
                              .toString();
                        }
                        return null;
                      },
                      obscureText: false,
                      controller: _nameController,
                      text: AppLocalizations.of(context)!.name.toString(),
                      keyboardType: TextInputType.name,
                    ),
                        //phone
                  TextFields(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .phonevalid
                            .toString();
                      }

                      return null;
                    },
                    obscureText: false,
                    controller: _phoneController,
                    // ignore: prefer_interpolation_to_compose_strings
                    text: AppLocalizations.of(context)!.phone.toString() 
                        ,
                    keyboardType: TextInputType.phone,
                  ),
                    //email and password//
                    EmailAndPassword(
                      emailcontroller: _emailController,
                      passwordcontroller: _passwordController,
                    ),

                    //button qeydiyyati
                    MyButton(
                        text: Text(
                            AppLocalizations.of(context)!.signup.toString()),
                        onPressed: () {
                          Register.signUp(
                              context: context,
                              emailController: _emailController,
                              nameController: _nameController,
                              passwordController: _passwordController,
                              phoneController:_phoneController,
                              formState: formState);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: Text(
                AppLocalizations.of(context)!.loginaccount.toString(),
                style: Theme.of(context).textTheme.headlineLarge,
              ))
        ],
      ),
    );
  }
}
