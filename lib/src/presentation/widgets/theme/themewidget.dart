import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation/src/presentation/provider/theme_change.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).colorScheme.primary,
        ),
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 9.40 / 2,
              child: Text(
                AppLocalizations.of(context)!.theme.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .setThemeMode(ThemeMode.light);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.light.toString(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .setThemeMode(ThemeMode.dark);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.dark.toString(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .setThemeMode(ThemeMode.system);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.system.toString(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
