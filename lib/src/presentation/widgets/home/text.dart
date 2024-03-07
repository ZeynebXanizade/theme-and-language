import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reservation/src/data/auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextWid extends StatefulWidget {
  const TextWid({super.key});

  @override
  State<TextWid> createState() => _TextWidState();
}

class _TextWidState extends State<TextWid> {
  final AuthServices _authServices = AuthServices();
  Users? _user;

  Future<void> _getCurrentUser() async {
    User? currentUser = _authServices.getCurrentUser();
    if (currentUser != null) {
      Users? user = await _authServices.getUserData(currentUser.uid);
      setState(() {
        _user = user;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child:  Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.hello.toString(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${_user?.name ?? ""}!",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
    );
  }
}