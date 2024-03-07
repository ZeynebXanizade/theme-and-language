import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppAbout extends StatelessWidget {
  const AppAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.about.toString(),
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          AppLocalizations.of(context)!.appabout.toString(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      )),
    );
  }
}
