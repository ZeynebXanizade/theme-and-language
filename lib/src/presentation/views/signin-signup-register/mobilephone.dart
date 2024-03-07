// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:reservation/src/data/auth.dart';
// import 'package:reservation/src/presentation/views/login_page.dart';
// import 'package:reservation/src/presentation/views/otp.dart';
// import 'package:reservation/src/presentation/widgets/button/button.dart';


// class MobilePhone extends StatefulWidget {
//   const MobilePhone({super.key});

//   @override
//   State<MobilePhone> createState() => _MobilePhoneState();
// }

// class _MobilePhoneState extends State<MobilePhone> {
//   GlobalKey<FormState> formState = GlobalKey<FormState>();
//   final AuthServices _auth = AuthServices();
//   final TextEditingController _phoneController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: Theme.of(context).iconTheme,
//         backgroundColor: Colors.transparent,
//         title: Text(
//           style: Theme.of(context).textTheme.headlineLarge,
//           AppLocalizations.of(context)!.userparametrs.toString(),
//         ),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               children: [
//                 //phone
//                 Form(
//                   key: formState,
//                   child: TextFormField(
//                       style: Theme.of(context).textTheme.headlineLarge,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           print(value);
//                           return AppLocalizations.of(context)!
//                               .phonevalid
//                               .toString();
//                         }

//                         return null;
//                       },
//                       controller: _phoneController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                           border: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.black,
//                                   strokeAlign: BorderSide.strokeAlignInside)),
//                           labelText:
//                               AppLocalizations.of(context)!.phone.toString(),
//                           prefixIcon: const CountryCodePicker(
//                             onChanged: print,
//                             initialSelection: 'AZ',
//                             favorite: ['+994', 'AZ'],
//                             showCountryOnly: false,
//                             showOnlyCountryWhenClosed: false,
//                             alignLeft: false,
//                           ),
//                           suffixIcon: _phoneController.text.isEmpty
//                               ? Container(
//                                   height: 30,
//                                   width: 30,
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Colors.green),
//                                   child: Icon(
//                                     Icons.done,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                 )
//                               : null)),
//                 ),

//                 Padding(
//                   padding: EdgeInsets.all(20.0),
//                   child: MyButton(
//                     text: Text(AppLocalizations.of(context)!.ok.toString()),
//                     onPressed: () async {
//                       if (formState.currentState!.validate()) {
//                         _auth.verifyOtpAndNavigateToRegisterPage(
//                           phoneNumber: _phoneController.text,
//                           errorStep: () => ScaffoldMessenger.of(context)
//                               .showSnackBar(SnackBar(
//                                   content: Text(AppLocalizations.of(context)!
//                                       .error
//                                       .toString()))),
//                         );
//                         print("${_phoneController.text}");
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => Otp()));
//                       }
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const LoginPage()));
//               },
//               child: Text(
//                 AppLocalizations.of(context)!.loginaccount.toString(),
//                 style: Theme.of(context).textTheme.headlineLarge,
//               ))
//         ],
//       ),
//     );
//   }
// }
