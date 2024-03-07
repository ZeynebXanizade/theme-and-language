import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reservation/src/data/auth.dart';
import 'package:reservation/src/presentation/views/signin-signup-register/welcome_page.dart';
import 'package:reservation/src/presentation/widgets/awsome%20dialog/awesome.dart';
import 'package:reservation/src/presentation/widgets/button/button.dart';
import 'package:reservation/src/presentation/widgets/textfieled/textfield.dart';

class UpdateUser extends StatefulWidget {
  final String userId;
  const UpdateUser({super.key, required this.userId});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
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

  bool first = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final User? user = ModalRoute.of(context)!.settings.arguments as User?;
    return Scaffold(
      appBar: AppBar(
       
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        title: Text(
          style: Theme.of(context).textTheme.headlineLarge,
          AppLocalizations.of(context)!.update.toString(),
        ),
      ),
      body: _user != null
          ? SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //name
                  TextFields(
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
                    obscureText: false,
                    controller: _nameController,
                    // ignore: prefer_interpolation_to_compose_strings
                    text: AppLocalizations.of(context)!.name.toString() +
                        ': ${_user!.name}',
                    keyboardType: TextInputType.name,
                  ),

                  //phone
                  TextFields(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .phonevalid
                            .toString();
                      }

                      return null;
                    },
                    obscureText: false,
                    controller: _phoneController,
                    // ignore: prefer_interpolation_to_compose_strings
                    text: AppLocalizations.of(context)!.phone.toString() +
                        ': ${_user!.phone}',
                    keyboardType: TextInputType.phone,
                  ),
                  /////////////////////////////////////////EMAIL///////////////////////////////////////////////////

                  TextFields(
                    obscureText: false,
                    controller: _emailController,
                    // ignore: prefer_interpolation_to_compose_strings
                    text: AppLocalizations.of(context)!.email.toString() +
                        ': ${_user!.email}',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .emailvalid
                            .toString();
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return "[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]";
                      }
                      return null;
                    },
                  ),
                  /////////////////////////////PASSWORD////////////////////////////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .passwordvalid
                              .toString();
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]").hasMatch(value)) {
                          return "Please enter a valid password";
                        }
                        return null;
                      },
                      controller: _passwordController,
                      style: Theme.of(context).textTheme.headlineLarge,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          labelStyle: Theme.of(context).textTheme.headlineLarge,
                          // ignore: prefer_interpolation_to_compose_strings
                          labelText: AppLocalizations.of(context)!
                                  .password
                                  .toString() +
                              ': ********',
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                first = !first;
                              });
                            },
                            child: AnimatedCrossFade(
                                firstChild: const Icon(Icons.visibility),
                                secondChild: const Icon(Icons.visibility_off),
                                crossFadeState: first
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                duration: const Duration(milliseconds: 100)),
                          )),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: first,
                    ),
                  ),

                  MyButton(
                    text: const Text("Update"),
                    onPressed: () {
                      if (_user != null) {
                        String? userId = _user!.id;
                        // ignore: unnecessary_null_comparison
                        if (userId != null) {
                          _authServices.updateUsers(
                              userId,
                              _nameController.text,
                              _emailController.text,
                              _phoneController.text,
                              _passwordController.text);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  UpdateUser(userId: userId)));
                        } else {
                          // ignore: avoid_print
                          print("User ID is null.");
                        }
                      } else {
                        // ignore: avoid_print
                        print("User is null.");
                      }
                    },
                  ),
                  MyButton(
                      text: const Text("Delete Account"),
                      onPressed: () {
                        AwesomeDialogWidget.showAwesomeDialog(
                          onPressed: () {
                            _authServices.deleteUsers(_user!.id, context);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WelcomePage()));
                          },
                          context: context,
                          dialogType: DialogType.info,
                          message:
                              AppLocalizations.of(context)!.delete.toString(),
                        );
                      }),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
