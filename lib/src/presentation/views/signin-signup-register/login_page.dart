import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservation/src/data/auth.dart';
import 'package:reservation/src/presentation/views/tapcontroller/tapcontroller.dart';
import 'package:reservation/src/presentation/views/signin-signup-register/register_page.dart';
import 'package:reservation/src/presentation/views/signin-signup-register/ressetpassword.dart';
import 'package:reservation/src/presentation/widgets/button/button.dart';
import 'package:reservation/src/presentation/widgets/textfieled/emailandpassword.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:reservation/src/utils/constants/sigin.dart';

class LoginPage extends StatefulWidget {
  // ignore: use_super_parameters
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isSignIn = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final AuthServices _authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
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
                  AppLocalizations.of(context)!.logintitle.toString(),
                  style: GoogleFonts.rubik(
                    textStyle: Theme.of(context).textTheme.headlineLarge,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ////////////////EMAIL AND PASSWORD////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      EmailAndPassword(
                        emailcontroller: _emailController,
                        passwordcontroller: _passwordController,
                      ),
                      //////////////////////////LOG IN AUTH//////////////////////////////////////////////
                      Column(
                        children: [
                          MyButton(
                              text: Text(AppLocalizations.of(context)!
                                  .login
                                  .toString()),
                              onPressed: () {
                                SignInWidget.signIn(
                                  formState: formState,
                                  context: context,
                                  emailcontroller: _emailController,
                                  passwordcontroller: _passwordController,
                                );
                              }),
                          //////////////////////////LOG IN GOOGLE//////////////////////////////////////////////
                          MyButton(
                            text: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/googlelogo.png" , width: 30,),
                                 const SizedBox(width: 20),
                                Text(AppLocalizations.of(context)!
                                    .loginGoogle
                                    .toString()),
                              ],
                            ),
                            onPressed: () async {
                              await _authServices
                                  .signInWithGoogleAndSaveToFirestore()
                                  .then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TabControllers(),
                                          settings: RouteSettings(
                                              arguments: value))));
                            },
                          ),
                          /////////////////////////////////RESET PASSWORD//////////////////////////////////////////////
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ForegetPassword()));
                              },
                              child: Text(AppLocalizations.of(context)!
                                  .forgetpassword
                                  .toString())),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
//////////////////////////REGISTER PAGE GO//////////////////////////////////////////////
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
              },
              child: Text(
                AppLocalizations.of(context)!.account.toString(),
                style: Theme.of(context).textTheme.headlineLarge,
              ))
        ],
      ),
    );
  }
}
