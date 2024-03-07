import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reservation/src/data/auth.dart';
import 'package:reservation/src/presentation/views/more/app_about.dart';
import 'package:reservation/src/presentation/views/more/applanguage.dart';
import 'package:reservation/src/presentation/views/signin-signup-register/login_page.dart';
import 'package:reservation/src/presentation/views/more/user_parametrs.dart';
import 'package:reservation/src/presentation/widgets/awsome%20dialog/awesome.dart';
import 'package:reservation/src/presentation/widgets/material/material_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/presentation/widgets/theme/themewidget.dart';

class MoreWidget extends StatefulWidget {
  const MoreWidget({super.key, required this.userId, this.user});
  final String userId;
  final User? user;
  @override
  State<MoreWidget> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends State<MoreWidget> {
  // ignore: prefer_final_fields
  AuthServices _authServices = AuthServices();
  Users? _user;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    Users? user = await _authServices.getUserData(widget.userId);
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ////////////////////////////USER PARAMETRS/////////////////////////////////////////////////////////
            MaterialWidget(
              text: AppLocalizations.of(context)!.userparametrs.toString(),
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserParametrs(userId: _user!.id)));
              },
              icon: const Icon(Icons.settings),
            ),

//////////////////////////////////////APP ABOUT//////////////////////////////////////////////////////
            MaterialWidget(
                text: AppLocalizations.of(context)!.about.toString(),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AppAbout()));
                },
                icon: const Icon(
                  Icons.accessibility_new_outlined,
                )),
            //////////////////////////////////////////LANGUAGE/////////////////////////////////////
            const AppLanguages(),
//////////////////////////////////////////LOGOUT//////////////////////////////////////////////////
            MaterialWidget(
                text: AppLocalizations.of(context)!.logout.toString(),
                onTap: () {
                  AwesomeDialogWidget.showAwesomeDialog(
                    onPressed: () {
                      setState(() {
                        FirebaseAuth.instance.signOut();
                        GoogleSignIn().signOut();
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      });
                    },
                    context: context,
                    dialogType: DialogType.info,
                    message: AppLocalizations.of(context)!.logout.toString(),
                  );
                },
                icon: const Icon(
                  Icons.logout_outlined,
                )),
///////////////////////////////THEME WIDGET////////////////////////////////////////
            const ThemeWidget(),
          ],
        ),
      )),
    );
  }
}
