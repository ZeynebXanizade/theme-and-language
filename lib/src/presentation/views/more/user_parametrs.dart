import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:reservation/src/data/auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/presentation/views/more/more.dart';
import 'package:reservation/src/presentation/views/more/update.dart';
import 'package:reservation/src/presentation/views/signin-signup-register/welcome_page.dart';
import 'package:reservation/src/presentation/views/tapcontroller/tapcontroller.dart';
import 'package:reservation/src/presentation/widgets/awsome%20dialog/awesome.dart';
import 'package:reservation/src/presentation/widgets/welcome_page/welcome_page_container.dart';

class UserParametrs extends StatefulWidget {
  const UserParametrs({super.key, required this.userId});
  final String userId;

  @override
  State<UserParametrs> createState() => _UserParametrsState();
}

class _UserParametrsState extends State<UserParametrs> {
  final AuthServices _authServices = AuthServices();
  Users? _user;

  Future<void> _getUserData() async {
    Users? user = await _authServices.getUserData(widget.userId);
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.profil.toString()),
      ),
      body: SingleChildScrollView(
        child: MyContainer(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                ////////////////////////////////////////////NAME//////////////////////////////////
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                    
                      UserContainer(
                          text: Text(
                        ' ${_user?.name ?? ""}',
                        style: Theme.of(context).textTheme.headlineLarge,
                      )),
                      ////////////////////////////////////////////EMAIL//////////////////////////////////
                      UserContainer(
                          text: Text(
                        ' ${_user?.email ?? ""}',
                        style: Theme.of(context).textTheme.headlineLarge,
                      )),
                      
                      ////////////////////////////////////////////PHONE//////////////////////////////////
                      // ignore: unnecessary_null_comparison
                     if(_user?.phone != null)
                     UserContainer(
                          text: Text(
                        ' ${_user?.phone}',
                        style: Theme.of(context).textTheme.headlineLarge,
                      // ignore: unnecessary_null_comparison
                      ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ////////////////////////////////////////DELETE BUTTON///////////////////////////////////////////////
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                           border: Border.all(color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(60),
                            color: Theme.of(context).colorScheme.onBackground),
                        child: IconButton(
                            onPressed: () {
                              AwesomeDialogWidget.showAwesomeDialog(
                                onPressed: () {
                                  setState(() async {
                                    await _authServices.deleteUsers(
                                        _user!.id, context);
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WelcomePage()));
                                  });
                                },
                                context: context,
                                dialogType: DialogType.info,
                                message: AppLocalizations.of(context)!
                                    .delete
                                    .toString(),
                              );
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                      ////////////////////////////////////////UPDATE BUTTON///////////////////////////////////////////////
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(60),
                            color: Theme.of(context).colorScheme.onBackground),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateUser(userId: _user!.id)));
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class UserContainer extends StatelessWidget {
  const UserContainer({super.key, required this.text});

  final Text text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
         border: Border.all(color: Theme.of(context).colorScheme.primary ),
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}
