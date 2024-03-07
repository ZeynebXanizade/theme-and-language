import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:reservation/src/presentation/provider/language_change_controller.dart';
import 'package:reservation/firebase_options.dart';
import 'package:reservation/src/config/themes.dart';
import 'package:reservation/src/presentation/provider/theme_change.dart';
import 'package:reservation/src/presentation/views/tapcontroller/tapcontroller.dart';
import 'package:reservation/src/presentation/views/signin-signup-register/welcome_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppLanguage appLanguage = AppLanguage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final String languageCode = prefs.getString('language_code') ?? '';
  runApp(MyApp(
    locale: languageCode,
  ));
}

class MyApp extends StatelessWidget {
  final String locale;
  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
      ],
      child: Consumer<AppLanguage>(builder: (context, provider, child) {
        if (provider.appLocal == null) {
          provider.fetchLocale();
          if (locale.isEmpty) {
            provider.changeLanguage(const Locale('en'));
          } else {
            provider.changeLanguage(Locale(locale));
          }
        }
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: Provider.of<ThemeNotifier>(context).themeMode,
            theme: ThemesApp.lightTheme,
            darkTheme: ThemesApp.dartTheme,
            locale: locale == ''
                ? const Locale('en')
                : provider.appLocal == null
                    ? Locale(locale)
                    : Provider.of<AppLanguage>(context).appLocal,

            // locale: provider.appLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [
              Locale("az"),
              Locale("en"),
              Locale("ru"),
            ],
            home: (FirebaseAuth.instance.currentUser != null &&
                    FirebaseAuth.instance.currentUser!.emailVerified)
                ?  const TabControllers()
                : const WelcomePage());
      }),
    );
  }
}
