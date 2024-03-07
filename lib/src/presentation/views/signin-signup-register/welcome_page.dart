import 'package:flutter/material.dart';
import 'package:reservation/src/presentation/views/signin-signup-register/login_page.dart';
import 'package:reservation/src/presentation/views/signin-signup-register/register_page.dart';
import 'package:reservation/src/presentation/widgets/button/button.dart';
import 'package:reservation/src/presentation/widgets/welcome_page/animation_text.dart';
import 'package:reservation/src/presentation/widgets/welcome_page/welcome_page_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              "assets/images/welcome_image.webp",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            child: MyContainer(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                children: [
                  const AnimationWelcomeText(),
                  Column(
                    children: [
////////////////////////////LOGIN BUTTON/////////////////////////////////////////////////////////////////
                      MyButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                        },
                        text: Text(
                            AppLocalizations.of(context)!.login.toString()),
                      ),
///////////////////////REGISTER//////////////////////////////////////////////////////////////////////
                      MyButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        text: Text(
                            AppLocalizations.of(context)!.signup.toString()),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
         
        ],
      )),
    );
  }
}
