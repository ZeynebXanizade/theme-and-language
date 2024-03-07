import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:reservation/src/presentation/provider/language_change_controller.dart';
import 'package:reservation/src/presentation/views/tapcontroller/tapcontroller.dart';


enum Language { english, azerbaijani, russian }

class AppLanguages extends StatefulWidget {
  const AppLanguages({super.key});

  @override
  State<AppLanguages> createState() => _AppLanguagesState();
}

bool status = false;
Language? selectedMenu;

class _AppLanguagesState extends State<AppLanguages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLanguage>(
      builder: (context, provider, child) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.language),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        AppLocalizations.of(context)!.applanguage.toString(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ],
                ),
                PopupMenuButton<Language>(
                  color: Theme.of(context).popupMenuTheme.color,
                  initialValue: selectedMenu,
                  onSelected: (Language item) {
                    if (Language.english.name == item.name) {
                      provider.changeLanguage(const Locale('en'));
                    } else if (Language.azerbaijani.name == item.name) {
                      provider.changeLanguage(const Locale('az'));
                    } else if (Language.russian.name == item.name) {
                      provider.changeLanguage(const Locale('ru'));
                    }
        
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>  const TabControllers()
                      ),
                    );
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<Language>>[
                    PopupMenuItem<Language>(
                        onTap: () {
                          provider.changeLanguage(const Locale('az'));
                        },
                        value: Language.azerbaijani,
                        child: Text(
                          AppLocalizations.of(context)!.az.toString(),
                          style: Theme.of(context).popupMenuTheme.textStyle,
                        )),
                    PopupMenuItem<Language>(
                        onTap: () {
                          provider.changeLanguage(const Locale('en'));
                        },
                        value: Language.english,
                        child: Text(
                          AppLocalizations.of(context)!.en.toString(),
                          style: Theme.of(context).popupMenuTheme.textStyle,
                        )),
                    PopupMenuItem<Language>(
                        onTap: () {
                          provider.changeLanguage(const Locale('ru'));
                        },
                        value: Language.russian,
                        child: Text(
                          AppLocalizations.of(context)!.ru.toString(),
                          style: Theme.of(context).popupMenuTheme.textStyle,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
