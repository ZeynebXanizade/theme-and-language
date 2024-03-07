import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/data/restaurant_firestore.dart';
import 'package:reservation/src/presentation/widgets/button/button.dart';

class SearchRes extends StatefulWidget {
  // ignore: use_super_parameters
  const SearchRes({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchResState createState() => _SearchResState();
}

class _SearchResState extends State<SearchRes> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  bool isButtonVisible = false;
 final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formState,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    onTap: () {
                      setState(() {
                        isButtonVisible = true;
                      });
                    },
                    style: Theme.of(context).textTheme.headlineLarge,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .namevalid
                            .toString();
                      }
                      if (!RegExp("^[A-z]").hasMatch(value)) {
                        return "Must include [A-z]";
                      }
                      return null;
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      labelStyle: Theme.of(context).textTheme.headlineLarge,
                      labelText: AppLocalizations.of(context)!
                          .search
                          .toString(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: isButtonVisible ? 48 : 0,
                    child: MyButton(
                      text: Text(
                        AppLocalizations.of(context)!.search.toString(),
                      ),
                      onPressed: () {
                        String searchText = searchController.text;
                        if (searchText.isNotEmpty) {
                          // Kullanıcıdan alınan arama metni ile Firestore'dan veri getirme
                          firestoreService.searchRestaurants(searchText);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
