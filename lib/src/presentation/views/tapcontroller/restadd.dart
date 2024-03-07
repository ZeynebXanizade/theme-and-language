import 'package:flutter/material.dart';
import 'package:reservation/src/presentation/widgets/button/button.dart';
import 'package:reservation/src/presentation/widgets/textfieled/textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RestaurantAdd extends StatefulWidget {
  const RestaurantAdd({super.key});

  @override
  State<RestaurantAdd> createState() => _RestaurantAddState();
}

class _RestaurantAddState extends State<RestaurantAdd> {
 final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFields(
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.namevalid.toString();
                }
                if (!RegExp("^[A-z]").hasMatch(value)) {
                  return "Must include [A-z]";
                }
                return null;
              },
              obscureText: false,
              controller: _nameController,
              // ignore: prefer_interpolation_to_compose_strings
              text: AppLocalizations.of(context)!.name.toString(),
              keyboardType: TextInputType.name,
            ),
              TextFields(
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.namevalid.toString();
                }
                if (!RegExp("^[A-z]").hasMatch(value)) {
                  return "Must include [A-z]";
                }
                return null;
              },
              obscureText: false,
              controller: _addressController,
              // ignore: prefer_interpolation_to_compose_strings
              text: AppLocalizations.of(context)!.address.toString(),
              keyboardType: TextInputType.name,
            ),
              TextFields(
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.namevalid.toString();
                }
                if (!RegExp("^[A-z]").hasMatch(value)) {
                  return "Must include [A-z]";
                }
                return null;
              },
              obscureText: false,
              controller: _hoursController,
              // ignore: prefer_interpolation_to_compose_strings
              text: AppLocalizations.of(context)!.hours.toString(),
              keyboardType: TextInputType.name,
            ),
            MyButton(text:Text(AppLocalizations.of(context)!.add.toString()) , onPressed: (){})
          ],
        ),
      ),
    );
  }
}
